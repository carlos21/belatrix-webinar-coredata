//
//  ViewController.swift
//  Notes
//
//  Created by Carlos Duclos on 3/13/17.
//  Copyright © 2017 Belatrix Software. All rights reserved.
//

import UIKit

let kNoteCellIdentifier = "NoteCell"
let kShowNoteDetailIdentifier = "ShowNoteDetailIdentifier"

class NotesViewController: UITableViewController {
    
    var group: Group?
    var notes: Array<Note>?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notes = Note.getAll() as? Array<Note>
        tableView.reloadData()
        navigationItem.title = group!.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kNoteCellIdentifier, for: indexPath)
        let note:Note = notes![indexPath.row]
        cell.textLabel?.text = note.name
        return cell
    }

}

