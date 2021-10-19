//
//  PrioritizeTaskGreen+CoreDataProperties.swift
//  Listed
//
//  Created by Mbuso on 2021/10/02.
//
//

import Foundation
import CoreData


extension PrioritizeTaskGreen {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrioritizeTaskGreen> {
        return NSFetchRequest<PrioritizeTaskGreen>(entityName: "PrioritizeTaskGreen")
    }

    @NSManaged public var taskToPrioritize: String?
    @NSManaged public var priorityLevel: String?

}

extension PrioritizeTaskGreen : Identifiable {

}
