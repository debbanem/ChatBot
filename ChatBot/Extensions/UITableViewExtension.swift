//
//  UITableViewExtension.swift
//  ChatBot
//
//  Created by Mark on 5/5/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import UIKit
import Foundation

extension UITableView
{
    func setupAutoAdjust()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardshown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardhide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardshown(_ notification:Notification)
    {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.fitContentInset(inset: UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0))
        }
    }
    
    @objc func keyboardhide(_ notification:Notification)
    {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.fitContentInset(inset: .zero)
        }
        
    }
    
    func fitContentInset(inset:UIEdgeInsets!)
    {
        self.contentInset = inset
        self.scrollIndicatorInsets = inset
    }
}
