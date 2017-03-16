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
    
    class func getAllByGroup(_ group: Group, inContext context: NSManagedObjectContext? = nil) -> [Note] {
        print("group: \(group)")
        let context = context ?? CoreDataStack.sharedStack.managedObjectContext
        let request = NSFetchRequest<Note>(entityName: String(describing: self));
        request.predicate = NSPredicate(format: "group == %@", group)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            return try context.fetch(request)
        } catch {
            fatalError("Failed to fetch objects: \(error)")
        }
        return []
    }
    
}
