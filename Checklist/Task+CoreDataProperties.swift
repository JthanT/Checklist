//
//  Task+CoreDataProperties.swift
//  Checklist
//
//  Created by Johnathan Tam on 2019-06-16.
//  Copyright © 2019 John's Apps. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var task: String?

}
