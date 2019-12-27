//
//  ChatViewController.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import UIKit

class ChatViewController: MainViewController, UITextFieldDelegate
{
    var timer = Timer()
    var chat: ChatModel?
    var messageArray: Array<Message>?
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var messageInputView: UIView!
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var messageInputBottomConstraint: NSLayoutConstraint!
    
    
    let imageView = UIImageView(image: UIImage(named: "cb-iphone-logo"))

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        messageArray = chat?.messages

        initUI()
//        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTable), userInfo: nil, repeats: true)
       
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        loadChat()
        imageView.isHidden = false
        setupKeyboardEvents()
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        deloadChat()
        imageView.isHidden = true
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @IBAction func sendBtnPressed(_ sender: Any)
    {
        sendMessage()
    }
    
    @objc func updateTable(){
        print("chat updated")
        messageArray = self.chat?.messages
        self.chatTable.reloadData()
    }
    
}

//CHAT TABLE METHODS
extension ChatViewController: UITableViewDelegate
{
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
   
    
    
}

extension ChatViewController: UITableViewDataSource
{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messageArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        guard let message = messageArray?[indexPath.row] else { return  UITableViewCell()}
        
        if((message.owner!.showMessagesOnRight)!)
        {
            return setUpRightChatCell(with: message)
        }
        else
        {
            return setUpLeftChatCell(with: message)
        }
        
        return UITableViewCell()
    }
    
}

extension ChatViewController: UIScrollViewDelegate
{
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImage(for: height)

    }
}

