//
//  PriotizeTaskBlue+CoreDataProperties.swift
//  Listed
//
//  Created by Mbuso on 2021/10/02.
//
//

import Foundation
import CoreData


extension PriotizeTaskBlue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PriotizeTaskBlue> {
        return NSFetchRequest<PriotizeTaskBlue>(entityName: "PriotizeTaskBlue")
    }

    @NSManaged public var taskToPrioritize: String?
    @NSManaged public var priorityLevel: String?

}

extension PriotizeTaskBlue : Identifiable {

}
