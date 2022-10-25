#!/bin/bash

podman tag dev.local/getting-started-instanton docker.io/jgawor/getting-started-instanton
podman push docker.io/jgawor/getting-started-instanton
