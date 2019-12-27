//
//  DialogTableViewCell.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import UIKit

class DialogTableViewCell: UITableViewCell
{

    var model: ChatModel?
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var botnameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func setUp()
    {
        
        self.backView.layer.cornerRadius = 20
        self.backgroundColor = UIColor.cbDarkBlue
        self.backView.backgroundColor = UIColor.cbWhite

        
        self.dateLabel.text = " "
        self.lastMessageLabel.text = " "
        self.botnameLabel.text = model?.bot?.name
    }
}
