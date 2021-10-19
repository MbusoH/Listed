//
//  removedTasks.swift
//  Listed
//
//  Created by Mbuso on 2021/09/14.
//
import Foundation
import UIKit
import CoreData

class GetRemovedTasks{
    func  saveRemovedTask(_ initTaskNameRemoved: String, _ initTaskStatusRemoved: String, _ initTaskDateRemoved: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let selectedItems = NSEntityDescription.entity(forEntityName: "RemovedTasks", in: context)
        let dataEntered = NSManagedObject(entity: selectedItems!, insertInto: context) as! RemovedTasks
        dataEntered.removedTaskName = initTaskNameRemoved
        dataEntered.removedStatus = initTaskStatusRemoved
        dataEntered.dateRemoved = initTaskDateRemoved
        appDelegate.saveContext()
    }
    
    func retrieveData() -> [RemovedTasks]{
        var dataFromDatabase = [RemovedTasks]()
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return dataFromDatabase
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RemovedTasks")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [RemovedTasks]{
                dataFromDatabase = retrievedData
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
        return dataFromDatabase
    }
    
    func deleteRemovedTask(_ initTaskName: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RemovedTasks")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [RemovedTasks]{
                for i in 0...(retrievedData.count - 1){
                    if let recievedTaskName = retrievedData[i].removedTaskName{
                        if initTaskName == recievedTaskName{
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
