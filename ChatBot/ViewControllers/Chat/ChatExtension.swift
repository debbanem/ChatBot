//
//  ChatBackEnd.swift
//  ChatBot
//
//  Created by Mark on 5/5/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import UIKit
import Foundation

//ChatBackend
extension ChatViewController
{
    
    //Initialization Functions
    func initUI()
    {
        
        self.initTable()
        setupUI()
        super.styleNavigationBar(self.navigationController!)
        self.messageTextField.layer.cornerRadius = messageTextField.frame.height/3
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: Notification.Name("updateMessages"), object: self.messageArray)
        
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
//        imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                             constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                              constant: -Const.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
    }
    
    
    func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 80
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 12
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 6
        /// Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 32
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 44
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 96.5
    }
    
    func initTable()
    {

        self.chatTable.delegate = self
        self.chatTable.dataSource = self
        self.chatTable.estimatedRowHeight = 80
        self.chatTable.rowHeight = UITableView.automaticDimension
        self.chatTable.transform = CGAffineTransform(rotationAngle: (-.pi))
        self.chatTable.transform = CGAffineTransform(scaleX: 1, y: -1)
        self.chatTable.scrollIndicatorInsets = UIEdgeInsets(top: 0,
                                                            left: 0,
                                                            bottom: 0,
                                                            right: self.chatTable.bounds.size.width - 10)
        chatTable.setupAutoAdjust()
        
    }
    
    
    //Chat Functions
    func loadChat()
    {
        
        guard let chats = AppDelegate.chats else { return }
        self.chat = chats.first {$0.isSelected == true }
        
        self.title = self.chat?.bot?.name
        self.messageArray = self.chat?.messages
        
        chatTable.reloadData()
    }
    
    func deloadChat()
    {
        guard let chats = AppDelegate.chats else { return  }
        guard let chat = self.chat else { return  }
        
        chat.isSelected = false
//        let toDeload = chats.first {$0.id == chat.id}
//        toDeload?.messages = self.messageArray
//        toDeload?.isSelected = false
        
    }
    
    //Message Functions
    func sendMessage(){
        
        if(messageTextField.text != "")
        {
            let chatBot = self.chat?.bot as! RepeaterBot
            
            let message = Message(text: "\(self.messageTextField.text ?? "error")", owner: AppDelegate.user, receiver: chatBot)
            
            self.addMessage(message: message)
            chatBot.queue?.enqueue(element: message)
            
            self.messageTextField.text = ""
        }
    }
    
    func addMessage(message: Message){
        
            self.messageArray?.insert(message, at: 0)
        
            self.chatTable.beginUpdates()
            let index = NSIndexPath(row: 0, section: 0) as IndexPath
            
            self.chatTable.insertRows(at: [index], with: .fade)
            self.chatTable.endUpdates()
            self.chat?.addMessage(message: message)

            self.chatTable.reloadData()
            
            self.chatTable.layoutIfNeeded()
            self.chatTable.scrollToRow(at: index, at: .top, animated: true)
    }
    
    
    //Left Cell Setup
    func setUpLeftChatCell(with message: Message) -> LeftChatTableViewCell
    {
        let leftCell: LeftChatTableViewCell = self.chatTable.dequeueReusableCell(withIdentifier: "leftChatCell") as! LeftChatTableViewCell
        
        leftCell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        leftCell.backView.layer.cornerRadius = 20
        leftCell.backView.frame.size.width = (message.text?.widthOfString(usingFont: UIFont.systemFont(ofSize: 20)))!
        
        guard let messageDate = message.date else { return  UITableViewCell() as! LeftChatTableViewCell}
        
        let date = DateFormatter.getDate(from: messageDate, with: DateFormatter.cbDateFormat)
        let dateString = DateFormatter.getString(from: date, with: "h:mm a")
        
        leftCell.messageLabel.text = message.text
        leftCell.dateField.text = DateFormatter.localToUTC(date: dateString)
        
        return leftCell
    }
    
    
    //Right Cell Setup
    func setUpRightChatCell(with message: Message) -> RightChatCellTableViewCell
    {
        let rightCell: RightChatCellTableViewCell = self.chatTable.dequeueReusableCell(withIdentifier: "rightChatCell") as! RightChatCellTableViewCell
        
        rightCell.backView.layer.cornerRadius = 20
        rightCell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        rightCell.backView.frame.size.width = (message.text?.widthOfString(usingFont: UIFont.systemFont(ofSize: 20)))!
        
        guard let messageDate = message.date else { return  UITableViewCell() as! RightChatCellTableViewCell}
        
        let date = DateFormatter.getDate(from: messageDate, with: DateFormatter.cbDateFormat)
        let dateString = DateFormatter.getString(from: date, with: "h:mm a")
        
        rightCell.dateField.text = DateFormatter.localToUTC(date: dateString)
        rightCell.messageLabel.text =  message.text
        
        return rightCell
    }

    
 
    //Keyboard Functions
    
    func setupKeyboardEvents(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func keyboardWillAppear(_ notification: NSNotification) {
        
        if let info = notification.userInfo {
            let rect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
                self.messageInputBottomConstraint.constant = rect.height
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
            self.messageInputBottomConstraint.constant = 0
        }
    }
}
