### Setup Firestore for MacOS

1. In file `DebugProfile.entitlements` and `Release.entitlements`:
- Set key `com.apple.security.app-sandbox` to `false`
- Add key `com.apple.security.network.client` by `true`