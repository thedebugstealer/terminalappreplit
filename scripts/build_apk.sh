#!/usr/bin/env bash
set -e

# Upgrade pip and install build tools
pip install --upgrade pip
pip install buildozer cython

# Build the APK
buildozer android debug
