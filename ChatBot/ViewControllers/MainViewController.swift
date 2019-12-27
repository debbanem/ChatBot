//
//  ViewController.swift
//  ChatBot
//
//  Created by Mark on 5/3/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    func styleNavigationBar(_ navigationController: UINavigationController)
    {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
    }

}

