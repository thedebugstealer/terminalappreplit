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
android.ndk_api = 21

[buildozer]
log_level = 2
android.accept_sdk_license = True

# SDK overrides
android.sdk_path = /home/runner/android-sdk
android.android_sdk = /home/runner/android-sdk
android.sdkmanager_path = /home/runner/android-sdk/cmdline-tools/latest/bin/sdkmanager
android.sdkmanager = /home/runner/android-sdk/cmdline-tools/latest/bin/sdkmanager

# THE CRITICAL FIX
android.build_tools_version = 33.0.2
