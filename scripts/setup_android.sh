#!/usr/bin/env bash
set -e

# Update system packages
sudo apt-get update -y
sudo apt-get install -y \
    python3-pip python3-setuptools python3-dev \
    build-essential git zip unzip \
    openjdk-17-jdk \
    libffi-dev libssl-dev \
    libstdc++6

# Create Android SDK directory
mkdir -p "$HOME/android-sdk"
cd "$HOME/android-sdk"

# Download Android command line tools
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdtools.zip

# Extract tools into correct structure
mkdir -p cmdline-tools
unzip cmdtools.zip -d cmdline-tools

# Move into the expected "latest" folder
mkdir -p cmdline-tools/latest
mv cmdline-tools/cmdline-tools/* cmdline-tools/latest/

# Set environment variables for this script
export ANDROID_HOME="$HOME/android-sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# Install required Android components
yes | sdkmanager --licenses
sdkmanager "platform-tools" \
           "platforms;android-33" \
           "build-tools;33.0.2" \
           "ndk;25.2.9519653"

# Persist environment variables for next GitHub Actions steps
echo "ANDROID_HOME=$ANDROID_HOME" >> $GITHUB_ENV
echo "PATH=$PATH" >> $GITHUB_ENV
