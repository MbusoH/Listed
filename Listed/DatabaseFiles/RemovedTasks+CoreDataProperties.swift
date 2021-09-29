//
//  RemovedTasks+CoreDataProperties.swift
//  Listed
//
//  Created by Mbuso on 2021/09/14.
//
//

import Foundation
import CoreData


extension RemovedTasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RemovedTasks> {
        return NSFetchRequest<RemovedTasks>(entityName: "RemovedTasks")
    }

    @NSManaged public var removedTaskName: String?
    @NSManaged public var removedStatus: String?
    @NSManaged public var dateRemoved: String?

}

extension RemovedTasks : Identifiable {

}
