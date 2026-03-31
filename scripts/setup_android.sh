#!/usr/bin/env bash
set -euo pipefail

echo "[MED3] Updating apt and installing base packages..."
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get install -y \
  python3 python3-pip python3-venv \
  openjdk-17-jdk \
  zip unzip git curl \
  libstdc++6 zlib1g \
  libffi-dev libssl-dev libsqlite3-dev \
  libbz2-dev libreadline-dev > /dev/null 2>&1

echo "[MED3] Upgrading pip (quiet)..."
PIP_PROGRESS_BAR=off python3 -m pip install --upgrade pip -q > /dev/null 2>&1

echo "[MED3] Installing Buildozer (quiet, reduced gremlins)..."
PIP_PROGRESS_BAR=off pip install --user --upgrade \
  cython buildozer virtualenv \
  -q > /dev/null 2>&1

echo "[MED3] Adding Python user bin to PATH..."
echo "$HOME/.local/bin" >> "$GITHUB_PATH"
export PATH="$HOME/.local/bin:$PATH"

echo "[MED3] Quick Buildozer presence check..."
which buildozer >/dev/null 2>&1 || echo "[MED3] Buildozer not found in PATH (may still be installing)."

echo "[MED3] Creating Android SDK directories..."
export ANDROID_SDK_ROOT=/home/runner/android-sdk
export ANDROID_HOME=/home/runner/android-sdk
mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools" \
         "$ANDROID_SDK_ROOT/platforms" \
         "$ANDROID_SDK_ROOT/build-tools" \
         "$ANDROID_SDK_ROOT/platform-tools"

echo "[MED3] Downloading Android commandline tools..."
cd /home/runner
curl -sSL https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
  -o cmdline-tools.zip > /dev/null 2>&1
unzip -q cmdline-tools.zip -d cmdline-tools-tmp
rm cmdline-tools.zip

mv cmdline-tools-tmp/cmdline-tools "$ANDROID_SDK_ROOT/cmdline-tools/latest"
rm -rf cmdline-tools-tmp

export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"
export BUILDOZER_SDKMANAGER="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager"

echo "[MED3] Installing Android SDK components (yes defanged)..."
# yes writes endlessly; sdkmanager closes stdin early; this prevents SIGPIPE from killing the job
yes 2>/dev/null | "$BUILDOZER_SDKMANAGER" --sdk_root="$ANDROID_SDK_ROOT" \
  "platform-tools" \
  "platforms;android-31" \
  "build-tools;31.0.0" > /dev/null 2>&1 || true

echo "[MED3] Final PATH:"
echo "$PATH"

echo "[MED3] Setup complete."
