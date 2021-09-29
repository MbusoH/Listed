//
//  mainTasks.swift
//  Listed
//
//  Created by Mbuso on 2021/09/14.
//

import Foundation
import UIKit
import CoreData


class GetDataInput{
    
    func saveTaskName(_ initTaskName: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let selectedItems = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let dataEntered = NSManagedObject(entity: selectedItems!, insertInto: context) as! Task
        dataEntered.taskName = initTaskName
        appDelegate.saveContext()
    }
    
    func saveIsPriority(_ initTaskIndex: Int, _ initPriorityLevel: Int){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    var taskIsPriorityToggled: Bool = false
                    var prioritizedTaskColor: Bool = false
                    if GetDataInput().retrieveData().count > 0{
                        if GetPrioritized().retrieveData().count <= 0{
                            GetPrioritized().fillUpArrayDemo()
                        }
                        if let recievedTaskName = GetDataInput().retrieveData()[initTaskIndex].taskName{
                            GetPrioritized().saveNewTaskPrioritize(initPriorityLevel, recievedTaskName)
                            taskIsPriorityToggled = true
                            if GetDataInput().retrieveData().count > 1{
                                for i in 0...(GetDataInput().retrieveData().count - 1){
                                    if i != initTaskIndex{
                                        if let recievedTaskName = GetDataInput().retrieveData()[i].taskName{
                                            if GetPrioritized().retrieveData().count > 0{
                                                for n in 0...(GetPrioritized().retrieveData().count - 1){
                                                    if let recievedPrioritizedTask = GetPrioritized().retrieveData()[n].taskToPrioritize{
                                                        if recievedTaskName == recievedPrioritizedTask{
                                                            prioritizedTaskColor = true
                                                        }
                                                    }
                                                }
                                            }
                                            if prioritizedTaskColor == false{
                                                GetDataInput().retrieveData()[i].isPriority = false
                                                try context.save()
                                            }
                                            prioritizedTaskColor = false
                                        }
                                    }
                                }
                            }
                        }
                        retrievedData[initTaskIndex].isPriority = taskIsPriorityToggled
                        try context.save()
                    }
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func saveRepeatTask(_ initTaskIndex: Int){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    var taskRepeatToggled: Bool = false
                    if GetDataInput().retrieveData()[initTaskIndex].repeatTask != true{
                        taskRepeatToggled = true
                    }
                    retrievedData[initTaskIndex].repeatTask = taskRepeatToggled
                    try context.save()
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func saveDueDate(_ initTaskIndex: Int, _ initDueDate: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    retrievedData[initTaskIndex].dueDate = initDueDate
                    try context.save()
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func saveDueDateTime(_ initTaskIndex: Int, _ initDueDateTime: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    retrievedData[initTaskIndex].dueDateTime = initDueDateTime
                    try context.save()
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func saveTaskDescription(_ initTaskIndex: Int, _ initTaskDescritption: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    retrievedData[initTaskIndex].taskDescription = initTaskDescritption
                    try context.save()
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func saveAddReminder(_ initTaskIndex: Int){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    var taskAddReminderToggled: Bool = false
                    if GetDataInput().retrieveData()[initTaskIndex].addReminder != true{
                        taskAddReminderToggled = true
                    }
                    retrievedData[initTaskIndex].isPriority = taskAddReminderToggled
                    try context.save()
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func saveRemindDays(_ initTaskIndex: Int, _ initRemindDays: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    retrievedData[initTaskIndex].remindDays = initRemindDays
                    try context.save()
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func saveRemiderTime(_ initTaskIndex: Int, _ initReminderTime: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    retrievedData[initTaskIndex].reminderTime = initReminderTime
                    try context.save()
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func checkTask(_ initTaskName: String) -> Bool{
        var foundIndex: Int = -1
        var taskInArray : Bool = false
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return taskInArray
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                var allTaskNames = [String]()
                if retrievedData.count > 0{
                    for i in 0...(retrievedData.count - 1){
                        if let recievedTaskName = retrievedData[i].taskName{
                            allTaskNames.append(recievedTaskName)
                        }
                    }
                    if allTaskNames.count > 0{
                        foundIndex = allTaskNames.firstIndex(of: initTaskName) ?? -1
                        if foundIndex > -1 {
                            taskInArray = true
                        }
                    }
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
        return taskInArray
    }
    
    func retrieveData() -> [Task]{
        var dataFromDatabase = [Task]()
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return dataFromDatabase
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                dataFromDatabase = retrievedData
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
        return dataFromDatabase
    }
    
    func reoderTasks(_ initTaskIndex: Int, _ initPriorityLevel: Int){
        changeIndexOfTask(initTaskIndex, initPriorityLevel)
    }
    
    
    func changeIndexOfTask(_ initTaskIndex: Int, _ initNewIndex: Int){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if var retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    if retrievedData.count > 2{
                        let item = retrievedData[initTaskIndex]
                        retrievedData.remove(at: initTaskIndex)
                        retrievedData.insert(item, at: initNewIndex)
                        try context.save()
                    }
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
    }
    
    func deleteTask(_ initTaskName: String, _ initTaskDate: String, _ initTaskStatus: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                for i in 0...(retrievedData.count - 1){
                    if let recievedTaskName = retrievedData[i].taskName{
                        if initTaskName == recievedTaskName{
                            GetRemovedTasks().saveRemovedTask(initTaskName, initTaskStatus, initTaskDate)
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
