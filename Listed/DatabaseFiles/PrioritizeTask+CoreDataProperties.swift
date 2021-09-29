//
//  PrioritizeTask+CoreDataProperties.swift
//  Listed
//
//  Created by Mbuso on 2021/09/26.
//
//

import Foundation
import CoreData


extension PrioritizeTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrioritizeTask> {
        return NSFetchRequest<PrioritizeTask>(entityName: "PrioritizeTask")
    }

    @NSManaged public var taskToPrioritize: String?

}

extension PrioritizeTask : Identifiable {

}
