---
layout: post
title: ""
date_placeholder: 0
categories:
---

Getting started with Kubernetes!

Locally on MacOS.

First we will install some tools:

brew update
brew install kind
brew install kubectl
brew install fluxcd/tap/flux
brew install watch

Getting started with kind

Create a [Github personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) with all `repo` permissions enabled.

Set environment variables:

    export GITHUB_TOKEN=<your-token>
    export GITHUB_USER=<your-username>

Create your first cluster!

    kind create cluster

Verify that everything worked OK.

    kubectl cluster-info
    flux check --pre

Run the bootstrap command:

    flux bootstrap github \
        --owner=$GITHUB_USER \
        --repository=flux-test \
        --branch=master \
        --path=./clusters/my-cluster \
        --personal

Clone the repo.

We will be using a public repository github.com/stefanprodan/podinfo, podinfo is a tiny web application made with Go.

Create a GitRepository manifest (a file that defines that we will synchronize the latest changes from a git repository and use as source for our image) pointing to podinfo repository's master branch:

    flux create source git podinfo \
        --url=https://github.com/stefanprodan/podinfo \
        --branch=master \
        --interval=30s \
        --export > ./clusters/my-cluster/podinfo-source.yaml

The Kustomization API defines a pipeline for fetching, decrypting, building, validating and applying Kubernetes manifests.
We will create a Flux Kustomization manifest for podinfo. This configures Flux to build and apply the kustomize directory located in the podinfo repository.

    flux create kustomization podinfo \
        --source=podinfo \
        --path="./kustomize" \
        --prune=true \
        --validation=client \
        --interval=5m \
        --export > ./clusters/my-cluster/podinfo-kustomization.yaml

Watch Flux sync the application:

    watch flux get kustomizations

When the synchronization finishes you can check that podinfo has been deployed on your cluster:

    kubectl -n default get deployments,services

From this moment forward, any changes made to the podinfo Kubernetes manifests in the master branch will be synchronised with your cluster.

If a Kubernetes manifest is removed from the podinfo repository, Flux will remove it from your cluster. If you delete a Kustomization from the fleet-infra repository, Flux will remove all Kubernetes objects that were previously applied from that Kustomization.

If you alter the podinfo deployment using kubectl edit, the changes will be reverted to match the state described in Git. When dealing with an incident, you can pause the reconciliation of a kustomization with flux suspend kustomization <name>. Once the debugging session is over, you can re-enable the reconciliation with flux resume kustomization <name>.

Access the podinfo service at

---

Follow me with [RSS](https://sundin.github.io/feed.xml).

_Did I make a mistake? Please feel free to [issue a pull request to my Github repo](https://github.com/Sundin/sundin.github.io)._
