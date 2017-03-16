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

    // MARK - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = group!.name
        reload()
    }
    
    // MARK - Private
    
    func reload() {
        notes = Note.getAllByGroup(group!)
        tableView.reloadData()
    }
    
    // MARK - Actions
    
    @IBAction func addTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Name", message: "Please input a name", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let field = alertController.textFields![0]
            
            let _ = Note(name: field.text!, body: "", group: self.group!)
            CoreDataStack.sharedStack.save()
            self.reload()
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
        if segue.identifier == kShowNoteDetailIdentifier {
            let noteDetailController = segue.destination as! NoteDetailViewController
            noteDetailController.note = sender as? Note
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note:Note = notes![indexPath.row]
        self.performSegue(withIdentifier: kShowNoteDetailIdentifier, sender: note)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes![indexPath.row]
            note.delete()
            CoreDataStack.sharedStack.save()
            tableView.reloadData()
        }
    }

}

