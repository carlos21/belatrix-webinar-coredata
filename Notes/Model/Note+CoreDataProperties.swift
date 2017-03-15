//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Carlos Duclos on 3/14/17.
//  Copyright © 2017 Belatrix Software. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }

    @NSManaged public var body: String?
    @NSManaged public var name: String?
    @NSManaged public var group: Group?

}
