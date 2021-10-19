//
//  suTasksData.swift
//  Listed
//
//  Created by Mbuso on 2021/10/18.
//
import Foundation
import UIKit
import CoreData

class GetSubTasks{
    func saveSubTask(_ initSubTaskName: String, _ initSubTaskStatus: Bool){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let selectedItems = NSEntityDescription.entity(forEntityName: "SubTask", in: context)
        let dataEntered = NSManagedObject(entity: selectedItems!, insertInto: context) as! SubTask
        dataEntered.subTaskName = initSubTaskName
        dataEntered.isDone = initSubTaskStatus
        appDelegate.saveContext()
    }
    
    func retrieveData() -> [SubTask]{
        var dataFromDatabase = [SubTask]()
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return dataFromDatabase
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SubTask")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [SubTask]{
                dataFromDatabase = retrievedData
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
        return dataFromDatabase
    }
    
    func saveSubTaskStatus(_ initTaskIndex: Int, _ initSubTaskIsDone: Bool){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SubTask")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [SubTask]{
                if retrievedData.count > 0{
                    retrievedData[initTaskIndex].isDone = initSubTaskIsDone
                    try context.save()
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func deleteSubTask(_ initTaskName: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SubTask")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [SubTask]{
                for i in 0...(retrievedData.count - 1){
                    if let recievedTaskName = retrievedData[i].subTaskName{
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
