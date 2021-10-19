//
//  PrioritizeTaskRed+CoreDataProperties.swift
//  Listed
//
//  Created by Mbuso on 2021/10/02.
//
//

import Foundation
import CoreData


extension PrioritizeTaskRed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrioritizeTaskRed> {
        return NSFetchRequest<PrioritizeTaskRed>(entityName: "PrioritizeTaskRed")
    }

    @NSManaged public var taskToPrioritize: String?
    @NSManaged public var priorityLevel: String?

}

extension PrioritizeTaskRed : Identifiable {

}
