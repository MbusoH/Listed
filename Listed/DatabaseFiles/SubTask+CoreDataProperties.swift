//
//  SubTask+CoreDataProperties.swift
//  Listed
//
//  Created by Mbuso on 2021/09/14.
//
//

import Foundation
import CoreData


extension SubTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubTask> {
        return NSFetchRequest<SubTask>(entityName: "SubTask")
    }

    @NSManaged public var subTaskName: String?
    @NSManaged public var isDone: Bool

}

extension SubTask : Identifiable {

}
