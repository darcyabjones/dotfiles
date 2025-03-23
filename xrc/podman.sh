#!/usr/bin/env bash

if command -v podman >/dev/null 2>&1 && ! command -v docker >/dev/null 2>&1
then
    alias docker=podman
fi
