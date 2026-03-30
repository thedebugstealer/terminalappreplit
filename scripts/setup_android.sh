#!/usr/bin/env bash
set -euo pipefail

echo "[MK10] Updating apt and installing base packages..."
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get install -y \
  python3 python3-pip python3-venv \
  openjdk-17-jdk \
  zip unzip git curl \
  libstdc++6 zlib1g \
  libffi-dev libssl-dev libsqlite3-dev \
  libbz2-dev libreadline-dev > /dev/null 2>&1

echo "[MK10] Upgrading pip..."
python3 -m pip install --upgrade pip > /dev/null 2>&1

echo "[MK10] Installing Buildozer (void-only mode)..."
PIP_PROGRESS_BAR=off pip install --user --upgrade \
  cython buildozer virtualenv \
  --quiet --quiet > /dev/null 2>&1

echo "[MK10] Adding Python user bin to PATH..."
echo "$HOME/.local/bin" >> $GITHUB_PATH
export PATH="$HOME/.local/bin:$PATH"

echo "[MK10] Checking Buildozer installation..."
ls -al "$HOME/.local/bin" || true
which buildozer || true
buildozer --version || true

echo "[MK10] Creating Android SDK directories..."
export ANDROID_SDK_ROOT=/home/runner/android-sdk
export ANDROID_HOME=/home/runner/android-sdk
mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools" \
         "$ANDROID_SDK_ROOT/platforms" \
         "$ANDROID_SDK_ROOT/build-tools" \
         "$ANDROID_SDK_ROOT/platform-tools"

echo "[MK10] Downloading Android commandline tools..."
cd /home/runner
curl -sSL https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
  -o cmdline-tools.zip > /dev/null 2>&1
unzip -q cmdline-tools.zip -d cmdline-tools-tmp
rm cmdline-tools.zip

mv cmdline-tools-tmp/cmdline-tools "$ANDROID_SDK_ROOT/cmdline-tools/latest"
rm -rf cmdline-tools-tmp

export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"
export BUILDOZER_SDKMANAGER="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager"

echo "[MK10] Installing Android SDK components (void-only mode)..."
yes | "$BUILDOZER_SDKMANAGER" --sdk_root="$ANDROID_SDK_ROOT" \
  "platform-tools" \
  "platforms;android-31" \
  "build-tools;31.0.0" > /dev/null 2>&1

echo "[MK10] Final PATH:"
echo "$PATH"

echo "[MK10] Setup complete."echo "[MK9] Downloading Android commandline tools..."
cd /home/runner
curl -sSL https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -o cmdline-tools.zip
unzip -q cmdline-tools.zip -d cmdline-tools-tmp
rm cmdline-tools.zip

mv cmdline-tools-tmp/cmdline-tools "$ANDROID_SDK_ROOT/cmdline-tools/latest"
rm -rf cmdline-tools-tmp

export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"
export BUILDOZER_SDKMANAGER="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager"

echo "[MK9] Installing Android SDK components..."
yes | "$BUILDOZER_SDKMANAGER" --sdk_root="$ANDROID_SDK_ROOT" \
  "platform-tools" \
  "platforms;android-31" \
  "build-tools;31.0.0" > /dev/null 2>&1

echo "[MK9] Final PATH:"
echo "$PATH"

echo "[MK9] Setup complete."
