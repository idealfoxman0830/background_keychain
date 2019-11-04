# Reading from Keychain in the background

This is an iOS demo app that checks if it's required to set access access level (`kSecAttrAccessible`) when **reading** from keychain.

Here is how it works:

- First, we write to Keychain with `accessibleAfterFirstUnlock`.

- Then we lock the device.

- While in the background, the app reads from Keychain.

- We Unlock the device and check if that read was successful.

See the following [discussion](https://github.com/evgenyneu/keychain-swift/pull/123) for more info.

## How to use

### 1. Download this repository and run the app on your device

```
https://github.com/evgenyneu/background-keychain.git
```

<img src='Images/keychain_demo_1.PNG'
  alt="Keychain Background Read Demo 1" width='450'>


### 2. 