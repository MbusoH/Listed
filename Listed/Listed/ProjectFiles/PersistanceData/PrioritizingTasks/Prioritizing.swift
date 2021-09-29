//
//  Prioritizing.swift
//  Listed
//
//  Created by Mbuso on 2021/09/26.
//

import Foundation
import UIKit
import CoreData

class GetPrioritized{
    
    func savePriorityTask(_ initPriorityTask: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let selectedItems = NSEntityDescription.entity(forEntityName: "PrioritizeTask", in: context)
        let dataEntered = NSManagedObject(entity: selectedItems!, insertInto: context) as! PrioritizeTask
        dataEntered.taskToPrioritize = initPriorityTask
        appDelegate.saveContext()
    }
    
    func saveNewTaskPrioritize(_ initTaskIndex: Int, _ initNewPriorityTask: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PrioritizeTask")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [PrioritizeTask]{
                if retrievedData.count > 0{
                    for i in 0...(GetPrioritized().retrieveData().count - 1){
                        if let recievedTaskToPrioritize = GetPrioritized().retrieveData()[i].taskToPrioritize{
                            if initNewPriorityTask == recievedTaskToPrioritize{
                                retrievedData[i].taskToPrioritize = "placeHolder"
                            }
                        }
                    }
                    retrievedData[initTaskIndex].taskToPrioritize = initNewPriorityTask
                    try context.save()
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func retrieveData() -> [PrioritizeTask]{
        var dataFromDatabase = [PrioritizeTask]()
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return dataFromDatabase
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PrioritizeTask")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [PrioritizeTask]{
                dataFromDatabase = retrievedData
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
        return dataFromDatabase
    }
    
    func fillUpArrayDemo(){
        for i in 0...2{
            savePriorityTask("testDatabasePrioritizing\(i)")
        }
    }
}
