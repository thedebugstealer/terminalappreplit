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

# 🔧 Android SDK / tools (match our setup script)
android.sdk_path = /home/runner/android-sdk
android.android_sdk = /home/runner/android-sdk
android.sdkmanager = /home/runner/android-sdk/cmdline-tools/latest/bin/sdkmanager
android.sdkmanager_path = /home/runner/android-sdk/cmdline-tools/latest/bin/sdkmanager

# Let Buildozer download/manage NDK itself; we only pin the API level
android.ndk_api = 21

[buildozer]
log_level = 2
android.accept_sdk_license = True
