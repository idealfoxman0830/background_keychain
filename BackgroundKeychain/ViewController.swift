import UIKit

class ViewController: UIViewController {
  
  let myKey = "My key"
  let itemValue = "In Keychain: initial write. Lock the device and wait 30 seconds. Then unlock and see of the keychain item was modified."

  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    errorLabel.text = ""
    readKeychain()
  }

  @IBAction func didTouchClearButton(_ sender: Any) {
    deleteFromKeychainIfKeyExists(key: myKey)
    readKeychain()
  }
  
  @IBAction func didTouchWriteButton(_ sender: Any) {
    if !deleteFromKeychainIfKeyExists(key: myKey) { return }

    let writeStatus = Keychain.addToKeychain(key: myKey, value: itemValue,
                                            accessible: kSecAttrAccessibleWhenUnlocked)
    
    if writeStatus != noErr {
      showError(text: "Error writing to keychain: \(writeStatus)")
    }
    
    readKeychain()
  }
  
  /**
  Read from keychain and show the value to the user
  */
  func readKeychain() {
    // Read from keychain
    let data = Keychain.readFromKeychain(key: myKey)
    
    if data.status == errSecItemNotFound {
      statusLabel.text = "Keychain item does not exist"
      return
    }
  
    if data.status != noErr {
      showError(text: "Error reading from keychain: \(data.status)")
    } else {
      if let value = data.value {
        statusLabel.text = value
      } else {
        statusLabel.text = "Keychain item exists but empty"
      }
    }
  }
  
  /**
  Show an error to user
  
  - parameter text: Error message.
  */
  func showError(text: String) {
    print(text)
    errorLabel.text = text
  }
  
  /**
   Delete a key from keychain if the key exists.
   
   - parameter key: Key under which the text value is stored in the keychain.
   
   - returns: true if delete operation was succesful.
   */
  @discardableResult
  func deleteFromKeychainIfKeyExists(key: String) -> Bool {
    let data = Keychain.readFromKeychain(key: key)
    
    if data.value != nil {
      let deleteStatus = Keychain.deleteFromKeychain(key: key)
      
      if deleteStatus != noErr {
        showError(text: "Error deleting form keychain: \(deleteStatus)")
        return false
      }
    }
    
    return true
  }
}

