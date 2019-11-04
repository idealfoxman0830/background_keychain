import UIKit

class ViewController: UIViewController {
  
  let myKey = "My key"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //    let itemKey = "My key"
    //    let itemValue = "My secretive bee 🐝"
    //    deleteFromKeychain(itemKey: itemKey)
    //    addToKeychain(itemKey: itemKey, itemValue: itemValue)
    //    readFromKeychain(itemKey: itemKey)
  }
  
  @IBAction func didTouchWriteButton(_ sender: Any) {
    ViewController.deleteFromKeychainIfKeyExists(key: myKey)
  }
  
  /**
   Delete a key from keychain if the key exists.
   
   - parameter key: Key under which the text value is stored in the keychain.
   */
  static func deleteFromKeychainIfKeyExists(key: String) {
    let data = Keychain.readFromKeychain(key: key)
    
    if data.value == nil {
      let deleteStatus = Keychain.deleteFromKeychain(key: key)
      
      if deleteStatus != noErr {
        print("Error deleteing form keychain: \(deleteStatus)")
      }
    }
  }
  
  
}

