#!/usr/bin/env bash
set -euo pipefail

echo "[MK7] Updating apt and installing base packages..."
sudo apt-get update -y
sudo apt-get install -y \
  python3 python3-pip python3-venv \
  openjdk-17-jdk \
  zip unzip git curl \
  libncurses5 libstdc++6 zlib1g \
  libffi-dev libssl-dev libsqlite3-dev \
  libbz2-dev libreadline-dev

echo "[MK7] Upgrading pip..."
python3 -m pip install --upgrade pip

echo "[MK7] Installing Buildozer with full verbosity..."
pip install --user --upgrade cython buildozer virtualenv --verbose

echo "[MK7] Adding Python user bin to PATH..."
echo "$HOME/.local/bin" >> $GITHUB_PATH
export PATH="$HOME/.local/bin:$PATH"

echo "[MK7] Checking Buildozer installation..."
ls -al "$HOME/.local/bin"
which buildozer || echo "[MK7] Buildozer still not in PATH"
buildozer --version || echo "[MK7] Buildozer failed to run"

echo "[MK7] Creating Android SDK directories..."
export ANDROID_SDK_ROOT=/home/runner/android-sdk
export ANDROID_HOME=/home/runner/android-sdk
mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools"
mkdir -p "$ANDROID_SDK_ROOT/platforms"
mkdir -p "$ANDROID_SDK_ROOT/build-tools"
mkdir -p "$ANDROID_SDK_ROOT/platform-tools"

echo "[MK7] Downloading Android commandline tools..."
cd /home/runner
curl -sSL https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -o cmdline-tools.zip
unzip -q cmdline-tools.zip -d cmdline-tools-tmp
rm cmdline-tools.zip

mv cmdline-tools-tmp/cmdline-tools "$ANDROID_SDK_ROOT/cmdline-tools/latest"
rm -rf cmdline-tools-tmp

export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"
export BUILDOZER_SDKMANAGER="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager"

echo "[MK7] Installing Android SDK components..."
yes | "$BUILDOZER_SDKMANAGER" --sdk_root="$ANDROID_SDK_ROOT" \
  "platform-tools" \
  "platforms;android-31" \
  "build-tools;31.0.0"

echo "[MK7] Final PATH:"
echo "$PATH"

echo "[MK7] Setup complete."           "ndk;25.2.9519653"

# Persist environment variables for next GitHub Actions steps
echo "ANDROID_HOME=$ANDROID_HOME" >> $GITHUB_ENV
echo "PATH=$PATH" >> $GITHUB_ENV
