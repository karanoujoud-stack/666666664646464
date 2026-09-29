# Muss (Flutter)

One codebase -> Android APK + iOS IPA, built automatically by GitHub Actions.

## What's inside
- `lib/main.dart` - the whole app: Muss branding, subscription page
  (device-locked keys, same secret as keygen.html), movy.sx WebView,
  2-level ad blocking (network + DOM), auto-fullscreen video, KEY countdown.
- `assets/logo.png` - your red M icon.
- `.github/workflows/build.yml` - builds APK (ubuntu) + IPA (macos).

## How to build (no Mac needed)
1. Create a GitHub repo, upload ALL these files (keep folder structure).
2. Go to the Actions tab -> "Build Muss" -> Run workflow.
3. Wait ~10 minutes, then download artifacts:
   - Muss-Android-APK  -> install directly on any Android phone
   - Muss-iOS-IPA      -> unsigned; needs signing to install on iPhone

## Selling keys
Same as before: customer reads DEVICE ID in the app -> you generate a key
with keygen.html -> works only on that device.
