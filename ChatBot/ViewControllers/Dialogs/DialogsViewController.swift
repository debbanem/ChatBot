//
//  DialogsViewController.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import UIKit

class DialogsViewController: MainViewController
{
    
    var freshStart: Bool = true
    var exisitingCellIndex: Int?
    var dialogs: Array<ChatModel>?
    
    @IBOutlet weak var dialogTable: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initUI()
        
        dialogTable.register(UINib(nibName: "DialogTableViewCell", bundle: nil), forCellReuseIdentifier: "dialogCell")
        NotificationCenter.default.addObserver(self, selector: #selector(updateDialogs), name: Notification.Name("updateDialogs"), object: nil)
    }
    
    @IBAction func addDialogPressed(_ sender: Any)
    {
        promptBotName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dialogs = AppDelegate.chats
        self.dialogTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    @objc func updateDialogs(){
        
        dialogs = AppDelegate.chats
        dialogs = dialogs?.sorted(by: {
            
            DateFormatter.getDate(from:($0.messages?.first?.date ?? (
                DateFormatter.getString(from: Date(),with: DateFormatter.cbDateFormat))), with: DateFormatter.cbDateFormat)
                .compare(
                    DateFormatter.getDate(from: $1.messages?.first?.date ?? (DateFormatter.getString(from: Date(), with:DateFormatter.cbDateFormat)), with: DateFormatter.cbDateFormat))
                == .orderedAscending
        })
        self.dialogTable.reloadData()
        
        
    }
    
}

extension DialogsViewController: UITableViewDelegate
{
    
}

extension DialogsViewController: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dialogs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dialogCell", for: indexPath) as! DialogTableViewCell
        
        cell.setUp()
        
        let model = dialogs?[dialogs!.count - (indexPath.row + 1)]
        
        if(model?.messages?.count != 0)
        {
            cell.lastMessageLabel.text = model?.messages?.first?.text
            
            let date = DateFormatter.getDate(from: (model?.messages?.last!.date)!, with: DateFormatter.cbDateFormat)
            cell.dateLabel.text = DateFormatter.getString(from: date, with: DateFormatter.cbDisplayDateFormat)
        }
        else{
            guard let chatBotDate = model?.dateCreated else { return  cell }
            
            cell.dateLabel.text = DateFormatter.getString(from: chatBotDate, with: DateFormatter.cbDisplayDateFormat)
            
        }
        
        cell.botnameLabel.text = model?.bot?.name
        cell.botnameLabel.textColor = UIColor.cbBlue
        cell.dateLabel.textColor = UIColor.cbBlue
        cell.lastMessageLabel.textColor = UIColor.cbLightBlue
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 127
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if (editingStyle == .delete)
        {
            let count = dialogs?.count
            dialogs?.remove(at: count! - (indexPath.row+1))
            dialogTable.beginUpdates()
            dialogTable.deleteRows(at: [indexPath], with: .automatic)
            dialogTable.endUpdates()
            
            AppDelegate.chats = self.dialogs
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let selectedCell  = tableView.cellForRow(at: indexPath) as! DialogTableViewCell
        
        if selectedCell.isSelected
        {
            let model = dialogs?[dialogs!.count - (indexPath.row+1)]
            model?.isSelected = true
            AppDelegate.chats = self.dialogs
            goToChat()
        }
    }
}
