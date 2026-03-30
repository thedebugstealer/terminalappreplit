#!/usr/bin/env bash
set -euo pipefail

echo "[MED] Updating apt and installing base packages..."
sudo apt-get update -y
sudo apt-get install -y \
  python3 python3-pip python3-venv \
  openjdk-17-jdk \
  zip unzip git curl \
  libstdc++6 zlib1g \
  libffi-dev libssl-dev libsqlite3-dev \
  libbz2-dev libreadline-dev

echo "[MED] Upgrading pip (reduced noise)..."
PIP_PROGRESS_BAR=off python3 -m pip install --upgrade pip -q

echo "[MED] Installing Buildozer (reduced gremlins)..."
PIP_PROGRESS_BAR=off pip install --user --upgrade \
  cython buildozer virtualenv \
  -q

echo "[MED] Adding Python user bin to PATH..."
echo "$HOME/.local/bin" >> "$GITHUB_PATH"
export PATH="$HOME/.local/bin:$PATH"

echo "[MED] Checking Buildozer installation..."
ls -al "$HOME/.local/bin" || true
which buildozer || echo "[MED] Buildozer not found in PATH"
buildozer --version || echo "[MED] Buildozer failed to run"

echo "[MED] Creating Android SDK directories..."
export ANDROID_SDK_ROOT=/home/runner/android-sdk
export ANDROID_HOME=/home/runner/android-sdk
mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools" \
         "$ANDROID_SDK_ROOT/platforms" \
         "$ANDROID_SDK_ROOT/build-tools" \
         "$ANDROID_SDK_ROOT/platform-tools"

echo "[MED] Downloading Android commandline tools (calm mode)..."
cd /home/runner
curl -sSL https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
  -o cmdline-tools.zip
unzip -q cmdline-tools.zip -d cmdline-tools-tmp
rm cmdline-tools.zip

mv cmdline-tools-tmp/cmdline-tools "$ANDROID_SDK_ROOT/cmdline-tools/latest"
rm -rf cmdline-tools-tmp

export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"
export BUILDOZER_SDKMANAGER="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager"

echo "[MED] Installing Android SDK components (less spam)..."
yes | "$BUILDOZER_SDKMANAGER" --sdk_root="$ANDROID_SDK_ROOT" \
  "platform-tools" \
  "platforms;android-31" \
  "build-tools;31.0.0" > /dev/null 2>&1

echo "[MED] Final PATH:"
echo "$PATH"

echo "[MED] Setup complete."
