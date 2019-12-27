//
//  UIViewExtension.swift
//  ChatBot
//
//  Created by Mark on 5/5/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import UIKit
import Foundation

extension UIView
{
    func shake()
    {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

