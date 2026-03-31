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

# NDK API level Buildozer uses for compilation
android.ndk_api = 21

[buildozer]
log_level = 2
android.accept_sdk_license = True

# Force Buildozer to use the SDK you installed
android.sdk_path = /home/runner/android-sdk
android.android_sdk = /home/runner
