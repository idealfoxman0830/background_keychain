//
//  Accessing Keychain
//

import Foundation

class Keychain {
  /**
   Delete a key from keychain
   
   - parameter key: Key under which the text value is stored in the keychain.
   
   - returns: result code, noErr for success.
   */
  static func deleteFromKeychain(key: String) -> OSStatus {
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
   
   - parameter accessible: accessibility level.
   
   - returns: result code, noErr for success. Returns 42 when failing to convert `value` to data.
   */
  static func addToKeychain(key: String, value: String, accessible: CFString) -> OSStatus {
    guard let valueData = value.data(using: String.Encoding.utf8) else {
      return 42
    }
    
    let queryAdd: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key as AnyObject,
      kSecValueData as String: valueData as AnyObject,
      kSecAttrAccessible as String: accessible as AnyObject,
    ]
    
    return SecItemAdd(queryAdd as CFDictionary, nil)
  }
  
  /**
   Read from the keychain.
   
   - parameter key: Key under which the text value is stored in the keychain.
   
   - returns: tuple (value, status). `value` is the stored keychain value. `status` result code, noErr for success.
   */
  static func readFromKeychain(key: String) -> (value: String?, status: OSStatus) {
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
