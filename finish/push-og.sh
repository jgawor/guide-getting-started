#!/bin/bash

podman tag dev.local/getting-started docker.io/jgawor/getting-started
podman push docker.io/jgawor/getting-started

