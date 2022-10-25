#!/bin/bash

CONTAINER=getting-started-checkpoint
set -x

podman run --name $CONTAINER --privileged --env WLP_CHECKPOINT=applications getting-started


podman commit $CONTAINER getting-started-instanton


podman rm $CONTAINER
