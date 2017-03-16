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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = note!.name
        bodyTextView.text = note!.body
    }
    
}
