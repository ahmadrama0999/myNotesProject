//
//  TableViewController.swift
//  toDoList
//
//  Created by Ramin Akhmad on 20.05.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func pushEditButton(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        tableView.reloadData()
    }
    
    @IBAction func pushAddButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Write your note", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New Item"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let createAction = UIAlertAction(title: "Create", style: .default) { (alert) in
            guard let newNoteText = alertController.textFields?[0].text else { return }
            addItem(nameItem: newNoteText)
            self.tableView.reloadData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNotes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let curNote = myNotes[indexPath.row]
        cell.textLabel?.text = curNote["Name"] as? String
        cell.textLabel?.numberOfLines = 0
        
        if (curNote["isCompleted"] as? Bool) == true {
            cell.imageView?.image = #imageLiteral(resourceName: "check")
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "uncheck")
        }
        
        if tableView.isEditing {
            cell.textLabel?.alpha = 0.6
            cell.imageView?.alpha = 0.6
        } else {
           cell.textLabel?.alpha = 1
           cell.imageView?.alpha = 1
        }
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "check")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "uncheck")
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveNotes(from: fromIndexPath.row, to: to.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

