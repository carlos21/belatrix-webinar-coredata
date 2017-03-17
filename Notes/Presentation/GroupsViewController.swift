//
//  GroupsViewController.swift
//  Notes
//
//  Created by Carlos Duclos on 3/14/17.
//  Copyright © 2017 Belatrix Software. All rights reserved.
//

import Foundation

import UIKit

let kGroupCellIdentifier = "GroupCell"
let kShowNotesSegueIdentifier = "ShowNotesIdentifier"

class GroupsViewController: UITableViewController {
    
    var groups: Array<Group>?
    
    // MARK - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    // MARK - Private
    
    func reload() {
        groups = Group.getAll(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) as? Array<Group>
        self.tableView.reloadData()
    }
    
    // MARK - Actions
    
    @IBAction func addTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Name", message: "Please input a name", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let field = alertController.textFields![0]
            
            let group = Group(name: field.text!)
            CoreDataStack.sharedStack.save()
            self.groups!.append(group)
            let indexPath = IndexPath(row: self.groups!.count-1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK - Override
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kShowNotesSegueIdentifier {
            let notesController = segue.destination as! NotesViewController
            notesController.group = sender as? Group
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kGroupCellIdentifier, for: indexPath) 
        let group:Group = groups![indexPath.row]
        cell.textLabel?.text = group.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups![indexPath.row]
        self.performSegue(withIdentifier: kShowNotesSegueIdentifier, sender: group)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let group = self.groups![indexPath.row]
            let index = self.groups!.index(of: group)
            self.groups!.remove(at: index!)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            group.delete()
            CoreDataStack.sharedStack.save()
        }
        return [deleteAction]
    }
}
