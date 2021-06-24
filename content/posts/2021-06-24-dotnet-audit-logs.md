---
title: "Automatic Audit Logs in .NET"
date: "2021-06-21T14:58:32+02:00"
categories:
  - Implementation
tags:
  - .NET
slug: dotnet-audit-logs
---

A common requirement for most serious applications is to be able to produce *audit logs*: information about which user has accessed what information and when.

In the .NET Core 5.0 API we are building right now, we decided to implement this functionality as a middleware that will automatically be executed upon every request to the API.

We want to log the response actually sent back to the client, so it's important that we put our new middleware first (or at least very early) in the HTTP request pipeline. [Remember](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/middleware/?view=aspnetcore-5.0) that the middleware that is first in the pipeline also will be returned to last on the way back up the pipeline again.

```csharp
// Inside Startup.cs...

public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
  app.UseAuditLogging();

  // Other middleware etc...
}
```

Here's the code for implementing the middleware itself:

```csharp
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Builder;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.IO;
using System.Threading.Tasks;

namespace DomainLogic.Middleware.AuditLogging
{
  public class AuditLoggingMiddleware
  {
    private readonly RequestDelegate _next;

    private readonly AuditLogService _auditLogService;

    public AuditLoggingMiddleware(RequestDelegate next, AuditLogService auditLogService)
    {
      _next = next;
      _auditLogService = auditLogService;
    }

    public async Task InvokeAsync(HttpContext context)
    {
      // Grab the incoming request
      var request = await FormatRequest(context.Request);
      request = TryGetJson(request);

      var originalBodyStream = context.Response.Body;

      using (var responseBody = new MemoryStream())
      {
        context.Response.Body = responseBody;

        // Process HTTP request
        await _next(context);

        // Once the request has been processed we can grab the resulting response
        var response = await FormatResponse(context.Response);
        response = TryGetJson(response);

        var endpoint = context.GetEndpoint();
        if (endpoint != null)
        {
          // Check if the endpoint is excluded from being audit logged (see below)
          // If you always want to log all requests, just skip these checks
          var noAuditAttribute = endpoint.Metadata?.GetMetadata<NoAuditAttribute>();
          if (noAuditAttribute == null)
          {
            // TODO: You need to implement the AuditLogService and AuditMessage classes yourself :)
            await _auditLogService.Log(new AuditMessage(context, request, response));
          }
        }
        else
        {
          // Decide what you want to do if a client requests a resource that is not an endpoint
        }

        await responseBody.CopyToAsync(originalBodyStream);
      }
    }

    private string TryGetJson(string json)
    {
      if (string.IsNullOrWhiteSpace(json))
      {
        return json;
      }

      try
      {
        var jsonRoot = JObject.Parse(json);
        return JsonConvert.SerializeObject(jsonRoot);
      }
      catch (Exception)
      {
        return "Invalid JSON data";
      }
    }

    private async Task<string> FormatRequest(HttpRequest request)
    {
      request.EnableBuffering();
      var bodyAsText = await new StreamReader(request.Body).ReadToEndAsync().ConfigureAwait(false);
      request.Body.Position = 0;

      return bodyAsText;
    }

    private async Task<string> FormatResponse(HttpResponse response)
    {
      response.Body.Seek(0, SeekOrigin.Begin);
      string text = await new StreamReader(response.Body).ReadToEndAsync();
      response.Body.Seek(0, SeekOrigin.Begin);

      return text;
    }
  }

  // Extension for being able to plug middleware into the HTTP request pipeline
  public static class AuditLoggingMiddlewareExtensions
  {
    public static IApplicationBuilder UseAuditLogging(this IApplicationBuilder builder)
    {
      return builder.UseMiddleware<AuditLoggingMiddleware>();
    }
  }
}
```

Also add this class if you want to be able to annotate certain endpoints (or entire controllers) with a `[NoAudit]` attribute that excludes these endpoints from being audit logged. Note that we follow an opt-out pattern for an endpoint to be excluded from the audit logs, since the cost of forgetting to opt out is trivial, while forgotting to opt in on the other hand would be disastrous.

```csharp
using System;

namespace DomainLogic.Middleware.AuditLogging
{
  public class NoAuditAttribute : Attribute
  {
  }
}

```


Implementation of the AuditLogService class that actually sends the log entry somewhere is dependent of where you want to store your audit logs and is therefore left as an exercise for the reader. In our case we chose to process the audit logs in an [Azure Event Hub](https://azure.microsoft.com/en-us/services/event-hubs/), and from there store them permanently in an [Azure Storage Blob](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-immutable-storage).
