[app]
title = TerminalApp
package.name = terminalapp
package.domain = org.example
source.dir = .
source.include_exts = py
version = 1.0
requirements = python3,kivy,kivymd
orientation = portrait
fullscreen = 0

# NDK API level for compilation
android.ndk_api = 21

[buildozer]
log_level = 2

# Accept all Android SDK licenses
android.accept_sdk_license = True

# Force Buildozer to use the SDK we pre-seed into its internal directory
android.sdk_path = /home/runner/.buildozer/android/platform/android-sdk
android.android_sdk = /home/runner/.buildozer/android/platform/android-sdk

# Force Buildozer to use the correct sdkmanager inside the pre-seeded SDK
android.sdkmanager = /home/runner/.buildozer/android/platform/android-sdk/cmdline-tools/latest/bin/sdkmanager
android.sdkmanager_path = /home/runner/.buildozer/android/platform/android-sdk/cmdline-tools/latest/bin/sdkmanager

# Force Buildozer to use a build-tools version that actually exists in the pre-seeded SDK
android.build_tools_version = 33.0.2
