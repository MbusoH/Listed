//
//  Task+CoreDataProperties.swift
//  Listed
//
//  Created by Mbuso on 2021/09/14.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var repeatTask: Bool
    @NSManaged public var reminderTime: String?
    @NSManaged public var remindDays: String?
    @NSManaged public var isPriority: Bool
    @NSManaged public var dueDateTime: String?
    @NSManaged public var dueDate: String?
    @NSManaged public var addReminder: Bool

}

extension Task : Identifiable {

}
