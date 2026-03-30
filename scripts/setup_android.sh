#!/usr/bin/env bash
set -e

# Create Android SDK directory
mkdir -p "$HOME/android-sdk"
cd "$HOME/android-sdk"

# Download Android command line tools
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdtools.zip

# Extract tools directly into "latest"
mkdir -p cmdline-tools/latest
unzip cmdtools.zip -d cmdline-tools/latest

# Set environment variables
export ANDROID_HOME="$HOME/android-sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# Accept licenses and install required packages
yes | sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2"
