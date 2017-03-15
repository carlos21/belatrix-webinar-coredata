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
    var selectedGroup: Group?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        groups = Group.getAll(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) as? Array<Group>
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kShowNotesSegueIdentifier {
            let notesController = segue.destination as! NotesViewController
            notesController.group = selectedGroup
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
        selectedGroup = groups![indexPath.row]
        self.performSegue(withIdentifier: kShowNotesSegueIdentifier, sender: nil)
    }
}
