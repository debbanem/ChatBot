//
//  RightChatCellTableViewCell.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import UIKit


class RightChatCellTableViewCell: UITableViewCell {
    
    var message: Message?
    
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
}
