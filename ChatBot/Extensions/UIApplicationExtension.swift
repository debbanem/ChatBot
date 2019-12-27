//
//  UIApplicationExtension.swift
//  ChatBot
//
//  Created by Mark on 5/5/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import UIKit
import Foundation

extension UIApplication
{
    class var statusBarBackgroundColor: UIColor?
    {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        }
        set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}
