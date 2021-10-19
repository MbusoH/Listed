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
    
    func saveTaskName(_ initTaskName: String, _ initTaskDescription: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let selectedItems = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let dataEntered = NSManagedObject(entity: selectedItems!, insertInto: context) as! Task
        dataEntered.taskName = initTaskName
        dataEntered.taskDescription = initTaskDescription
        appDelegate.saveContext()
    }
    
    func saveIsPriority(_ initTaskIndex: Int, _ initPriorityLevel: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    var taskIsPriorityToggled: Bool = false
                    if GetDataInput().retrieveData().count > 0{
                        if let recievedTaskName = GetDataInput().retrieveData()[initTaskIndex].taskName{
                            switch initPriorityLevel {
                            case "0":
                                if GetPrioritizedRed().checkingTask(recievedTaskName) == false{
                                    GetPrioritizedRed().savePriorityTask(recievedTaskName, initPriorityLevel)
                                    HomeView().deletingGreenPriority(recievedTaskName)
                                    HomeView().deletingBluePriority(recievedTaskName)
                                } else{print("it works well")}
                            case "1":
                                if GetPrioritizedGreen().checkingTask(recievedTaskName) == false{
                                    GetPrioritizedGreen().savePriorityTask(recievedTaskName, initPriorityLevel)
                                    HomeView().deletingRedPriority(recievedTaskName)
                                    HomeView().deletingBluePriority(recievedTaskName)
                                }
                                
                            case "2":
                                if GetPrioritizedBlue().checkingTask(recievedTaskName) == false{
                                    GetPrioritizedBlue().savePriorityTask(recievedTaskName, initPriorityLevel)
                                    HomeView().deletingRedPriority(recievedTaskName)
                                    HomeView().deletingGreenPriority(recievedTaskName)
                                }
                                
                            default:
                                print("Something went wrong with saving the priority")
                            }
                            taskIsPriorityToggled = true
                        }
                        retrievedData[initTaskIndex].isPriority = taskIsPriorityToggled
                        //print("is saved as priority_________________\(retrievedData[initTaskIndex].isPriority)")
                        //print("end here\(taskIsPriorityToggled)")
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
    
    func saveIntervalCountDown(_ initTaskIndex: Int, _ initIntervalCountDown: String){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            if let retrievedData =  try context.fetch(fetchRequest) as? [Task]{
                if retrievedData.count > 0{
                    retrievedData[initTaskIndex].intervalCountDown = initIntervalCountDown
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
                    retrievedData[initTaskIndex].addReminder = taskAddReminderToggled
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
                let redListCopy = GetPrioritizedRed()
                let redListNumber: Int = redListCopy.retrieveData().count
                let greenListCopy = GetPrioritizedGreen()
                let greenListNumber: Int = greenListCopy.retrieveData().count
                let blueListCopy = GetPrioritizedBlue()
                var _: Int = blueListCopy.retrieveData().count
                
                if (GetPrioritizedRed().retrieveData().count > 0){
                    for i in 0...(GetPrioritizedRed().retrieveData().count - 1){
                        if let recievedRedPriority = GetPrioritizedRed().retrieveData()[i].taskToPrioritize{
                            if dataFromDatabase.count > 1{
                                for n in 0...(dataFromDatabase.count - 1){
                                    if let taskNameToCheck = dataFromDatabase[n].taskName{
                                        if taskNameToCheck == recievedRedPriority{
                                            let newIndexToMoveTo: Int = i
                                            let itemTask = dataFromDatabase[n]
                                            dataFromDatabase.remove(at: n)
                                            dataFromDatabase.insert(itemTask, at: newIndexToMoveTo)
                                            try context.save()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                if (GetPrioritizedGreen().retrieveData().count > 0){
                    for i in 0...(GetPrioritizedGreen().retrieveData().count - 1){
                        if let recievedGreenPriority = GetPrioritizedGreen().retrieveData()[i].taskToPrioritize{
                            if dataFromDatabase.count > 1{
                                for n in 0...(dataFromDatabase.count - 1){
                                    if let taskNameToCheck = dataFromDatabase[n].taskName{
                                        if taskNameToCheck == recievedGreenPriority{
                                            let newIndexToMoveTo: Int = i + redListNumber
                                            let itemTask = dataFromDatabase[n]
                                            dataFromDatabase.remove(at: n)
                                            dataFromDatabase.insert(itemTask, at: newIndexToMoveTo)
                                            try context.save()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                if (GetPrioritizedBlue().retrieveData().count > 0){
                    for i in 0...(GetPrioritizedBlue().retrieveData().count - 1){
                        if let recievedBluePriority = GetPrioritizedBlue().retrieveData()[i].taskToPrioritize{
                            if dataFromDatabase.count > 1{
                                for n in 0...(dataFromDatabase.count - 1){
                                    if let taskNameToCheck = dataFromDatabase[n].taskName{
                                        if taskNameToCheck == recievedBluePriority{
                                            let newIndexToMoveTo: Int = i + redListNumber + greenListNumber
                                            let itemTask = dataFromDatabase[n]
                                            dataFromDatabase.remove(at: n)
                                            dataFromDatabase.insert(itemTask, at: newIndexToMoveTo)
                                            try context.save()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch let error as NSError{
            print("Error\(error)")
        }
        return dataFromDatabase
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
