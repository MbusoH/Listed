//
//  GreenPriority.swift
//  Listed
//
//  Created by Mbuso on 2021/10/02.
//

import Foundation
import UIKit
import CoreData

class GetPrioritizedGreen{
    
    func savePriorityTask(_ initPriorityTask: String, _ initPriorityLevel: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let selectedItems = NSEntityDescription.entity(forEntityName: "PrioritizeTaskGreen", in: context)
        let dataEntered = NSManagedObject(entity: selectedItems!, insertInto: context) as! PrioritizeTaskGreen
        dataEntered.taskToPrioritize = initPriorityTask
        dataEntered.priorityLevel = initPriorityLevel
        appDelegate.saveContext()
    }
    
    func saveNewTaskPrioritize(_ initTaskIndex: Int, _ initNewPriorityTask: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PrioritizeTaskGreen")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [PrioritizeTaskGreen]{
                if retrievedData.count > 0{
                    for i in 0...(GetPrioritizedGreen().retrieveData().count - 1){
                        if let recievedTaskToPrioritize = GetPrioritizedGreen().retrieveData()[i].taskToPrioritize{
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
    
    func retrieveData() -> [PrioritizeTaskGreen]{
        var dataFromDatabase = [PrioritizeTaskGreen]()
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return dataFromDatabase
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PrioritizeTaskGreen")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [PrioritizeTaskGreen]{
                dataFromDatabase = retrievedData
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
        return dataFromDatabase
    }
    
    func checkingTask(_ initTaskToCheck: String) -> Bool{
        var taskInArray: Bool = false
        if GetPrioritizedGreen().retrieveData().count > 0{
            for i in 0...(GetPrioritizedGreen().retrieveData().count - 1){
                if let recievedGreenPrioritiy = GetPrioritizedGreen().retrieveData()[i].taskToPrioritize{
                    if initTaskToCheck == recievedGreenPrioritiy{
                        taskInArray = true
                    }
                }
            }
        }
        return taskInArray
    }
    
    func deleteTask(_ initTaskName: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PrioritizeTaskGreen")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [PrioritizeTaskGreen]{
                for i in 0...(retrievedData.count - 1){
                    if let recievedTaskPriority = retrievedData[i].taskToPrioritize{
                        if initTaskName == recievedTaskPriority{
                            context.delete(retrievedData[i])
                            try context.save()
                        }
                    }
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
}

