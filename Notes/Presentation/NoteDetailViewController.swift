//
//  NoteDetailViewController.swift
//  Notes
//
//  Created by Carlos Duclos on 3/14/17.
//  Copyright © 2017 Belatrix Software. All rights reserved.
//

import Foundation
import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    var note: Note?
    
    // MARK - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bodyTextView.layer.cornerRadius = 6
        bodyTextView.layer.borderColor = UIColor(colorLiteralRed: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1.0).cgColor
        bodyTextView.layer.borderWidth = 1
        
        nameTextField.text = note!.name
        bodyTextView.text = note!.body
    }
    
    // MARK - Actions
    
    @IBAction func saveTapped(_ sender: Any) {
        note!.name = nameTextField.text ?? ""
        note!.body = bodyTextView.text ?? ""
        CoreDataStack.sharedStack.save()
        navigationController?.popViewController(animated: true)
    }
    
}
