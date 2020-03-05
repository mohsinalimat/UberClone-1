//
//  TextfieldExtension.swift
//  UberClone
//
//  Created by Pushpank Kumar on 11/02/20.
//  Copyright © 2020 Pushpank Kumar. All rights reserved.
//

import UIKit
 
extension UITextField {
    
    /// We are setting up the textfield
    /// - Parameters:
    ///   - placeholder: TextField Placeholder
    ///   - isSecureTextEntry: true for password, otherwise false
    ///   - keyboardType: keyboard Type 
    func textfield(withPlaceholder placeholder: String, isSecureTextEntry: Bool, keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.isSecureTextEntry = isSecureTextEntry
        textField.autocorrectionType = .no
        textField.keyboardType = keyboardType
        return textField
    }
}
