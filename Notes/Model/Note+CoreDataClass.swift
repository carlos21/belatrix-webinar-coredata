//
//  Note+CoreDataClass.swift
//  Notes
//
//  Created by Carlos Duclos on 3/14/17.
//  Copyright © 2017 Belatrix Software. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    convenience init(name: String, body: String, group: Group?, inContext context: NSManagedObjectContext? = nil) {
        self.init(context: context ?? CoreDataStack.sharedStack.managedObjectContext)
        self.name = name
        self.body = body
        self.group = group
    }
    
}
