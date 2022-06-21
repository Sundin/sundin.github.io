---
categories:
  - Implementation
  - Tutorial
  - Security
tags:
  - .NET
date: "2021-12-06T00:00:00Z"
title: Token-Based Authorization in .NET Core 6.0
slug: "token-based-authorization-in-dotnet"
---

This blog post describes how to implement token-based authentication and authorization using .NET Core 6.0.

The way this works is that when the user is authenticated, a token containing various claims will be stored in the user's browser.
This cookie will be used in subsequent requests, and the claims can be checked on different endpoints in order to provide authorization.

Now let's get coding!

Inside Startup.cs, add the following to the `ConfigureServices(IServiceCollection services)` method:

```
services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(o => o.LoginPath = new PathString("/auth/login"));

services.AddAuthorization(options =>
{
    options.AddPolicy("Admin", policy =>
        policy.RequireClaim("Roles", "admin"));
});
```

And in the `Configure(IApplicationBuilder app, IWebHostEnvironment env)` method (it is important that these lines comes after `app.UseRouting()` but before `app.UseEndpoints(...)`):

```
app.UseAuthentication();
app.UseAuthorization();
```

Next you can annotate your Controller or an individual endpoint with the Policy we just created. This will make sure that the user is logged in and has the required role, otherwise we will get redirected to the login page or access denied page respectively.

```
[Authorize(Policy = "Admin")]
```

Now comes the slightly more tricky part. When the user logs in, we need to make sure that his or her roles are included in the token.

```
// This part you need to implement for yourself:
var dbUser = _userRepository.Authenticate(dto.Email, dto.Password);

// Extract the user's roles from database and put into claims
var claims = new[] { new Claim("Roles", dbUser.Roles) };

var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

// This will store a cookie containing the authentication token in the user's browser
await HttpContext.SignInAsync(
    CookieAuthenticationDefaults.AuthenticationScheme, 
    new ClaimsPrincipal(identity));
```

When the user logs out, we need to clear the browser cookie which is simple enough:

```
await HttpContext.SignOutAsync();
```
