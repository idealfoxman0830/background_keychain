import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //    let itemKey = "My key"
    //    let itemValue = "My secretive bee 🐝"
    //    deleteFromKeychain(itemKey: itemKey)
    //    addToKeychain(itemKey: itemKey, itemValue: itemValue)
    //    readFromKeychain(itemKey: itemKey)
  }
  
  @IBAction func didTouchWriteButton(_ sender: Any) {
    print("Write")
  }
  
  /**
   Delete a key from keychain
   
   - parameter key: Key under which the text value is stored in the keychain.
   
   - returns: result code, noErr for success.
   */
  func deleteFromKeychain(key: String) -> OSStatus {
    let queryDelete: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key as AnyObject,
    ]
    
    return SecItemDelete(queryDelete as CFDictionary)
  }
  
  /**
   Add a key to the keychain
   
   - parameter key: Key under which the text value is stored in the keychain.
   
   - parameter value: The value to be stored.
   
   - returns: result code, noErr for success.
   */
  func addToKeychain(key: String, value: String) -> OSStatus {
    guard let valueData = value.data(using: String.Encoding.utf8) else {
      print("Error saving text to Keychain")
      return 42
    }
    
    let queryAdd: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key as AnyObject,
      kSecValueData as String: valueData as AnyObject,
      kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked,
    ]
    
    return SecItemAdd(queryAdd as CFDictionary, nil)
  }
  
  /**
   Read from the keychain.
   
   - parameter key: Key under which the text value is stored in the keychain.
   
   - returns: tuple (value, status). `value` is the stored keychain value. `status` result code, noErr for success.
   */
  func readFromKeychain(key: String) -> (value: String?, status: OSStatus) {
    let queryLoad: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key as AnyObject,
      kSecReturnData as String: kCFBooleanTrue,
      kSecMatchLimit as String: kSecMatchLimitOne,
    ]
    
    var result: AnyObject?
    
    let resultCodeLoad = withUnsafeMutablePointer(to: &result) {
      SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
    }
    
    let status = resultCodeLoad
    var value: String? = nil
    
    if resultCodeLoad == noErr {
      if let result = result as? Data {
        value = NSString(data: result,
                         encoding: String.Encoding.utf8.rawValue) as String?
      }
    }
    
    return (value, status)
  }
}

