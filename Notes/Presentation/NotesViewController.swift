//
//  ViewController.swift
//  Notes
//
//  Created by Carlos Duclos on 3/13/17.
//  Copyright © 2017 Belatrix Software. All rights reserved.
//

import UIKit

let kNoteCellIdentifier = "NoteCell"

class NotesViewController: UITableViewController {
    
    var groups: Array<Group>?
    var notes: Array<Note>?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        self.tableView.reloadData()
    }
    
    func setup() {
        groups = Group.getAll() as? Array<Group>
        print("groups: \(groups?.count)")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let a = groups?.count ?? 0
        print("a: \(a)")
        return groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groups?[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0//groups?[section].notes?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kNoteCellIdentifier, for: indexPath)
        let group:Group = groups![indexPath.section]
        let note:Note = group.notes?.allObjects[indexPath.row] as! Note
        cell.textLabel?.text = note.name
        return cell
    }


}

