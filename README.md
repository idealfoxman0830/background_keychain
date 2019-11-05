# Reading from Keychain in the background

This is an iOS demo app that reads from Keychain while being in the background.

Here is how it works:

- First, we write to Keychain with `accessibleAfterFirstUnlock`.

- Then we lock the device.

- While in the background, the app reads from Keychain and updates a label on screen.

- Finally, we unlock the device and check if that read was successful.

This app was created in order to check if it's required to set access access level (`kSecAttrAccessible`) when **reading** from keychain. See the following [discussion](https://github.com/evgenyneu/keychain-swift/pull/123) for more info.

## How to use

### 1. Download this repository and run the app on your device

```
https://github.com/evgenyneu/background-keychain.git
```

<img src='Images/keychain_demo_1_v2.png'
  alt="Keychain Background Read Demo 1" width='300'>


### 2. Click "Write to Keychain" button

<img src='Images/keychain_demo_2_v2.png'
  alt="Keychain Background Read Demo 1" width='300'>

### 3. Finally, lock your device and then unlock it

After entering the background the app will read from the Keychain and update a label on screen. After unlocking, you will see if that background read was successful.

<img src='Images/keychain_demo_3_v2.png'
  alt="Keychain Background Read Demo 1" width='300'>