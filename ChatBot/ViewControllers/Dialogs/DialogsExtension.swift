//
//  DialogsBackEnd.swift
//  ChatBot
//
//  Created by Mark on 5/5/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//
import UIKit
import Foundation

extension DialogsViewController
{
    
    //Initialization Function
    func initUI()
    {
        super.styleNavigationBar(self.navigationController!)
        
        if(freshStart)
        {
            dialogs = AppDelegate.chats
            freshStart = false
        }
        
    }
    
    //Bot Function
    func promptBotName()
    {
        let alertController = UIAlertController(title: "Enter ChatBot Name", message: "", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Enter", style: .default)
                            { (_) in
                                self.handlePrompt(on: alertController)
                            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField
        { (textField) in
            textField.placeholder = "ChatBot"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func handlePrompt(on alertController: UIAlertController)
    {
        let chatBotName = alertController.textFields?[0].text
        
        guard let chats = AppDelegate.chats else { return  }
        
        self.exisitingCellIndex = chats.firstIndex {$0.bot?.name == chatBotName}
        
        guard self.exisitingCellIndex != nil
            else {
                self.addBot(chatBotName: chatBotName!)
                return
        }
        
        
        let index = NSIndexPath(row: (self.dialogs!.count - (self.exisitingCellIndex!+1)) , section: 0) as IndexPath
        let cell = self.dialogTable.cellForRow(at: index) as! DialogTableViewCell
        cell.backView.shake()
        
    }
    
    
    func addBot(chatBotName: String)
    {
        
        let index = (AppDelegate.chats?.count ?? 0)
        
        let newBot = RepeaterBot(id: index , name: chatBotName)
        let newChat = ChatModel(id: index, bot: newBot)
        newBot.chat = newChat
        self.dialogs?.insert(newChat, at: index)
        
        self.dialogTable.beginUpdates()
        self.dialogTable.insertRows(at: [NSIndexPath(row: 0 , section: 0) as IndexPath],
                                    with: .automatic)
        self.dialogTable.endUpdates()
        
        AppDelegate.chats = self.dialogs
        
    }
    
    
    //Chat Function
    func goToChat(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let chatViewController = storyBoard.instantiateViewController(withIdentifier: "Chat") as! ChatViewController
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
}
