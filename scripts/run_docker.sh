#!/usr/bin/env bash

## Takes one arg: tag name

# Build image and add a descriptive tag
docker build --tag=capstone:$1 .
