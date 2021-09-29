//
//  HomeViewFunc.swift
//  Listed
//
//  Created by Mbuso on 2021/09/14.
//

import Foundation
import UIKit

extension HomeView {

    func unwrapTaskName(_ initTasIndex: Int) -> String {
        var returnTaskName: String = ""
        if GetDataInput().retrieveData().count > 0{
            if let recievedTaskName = GetDataInput().retrieveData()[initTasIndex].taskName{
                returnTaskName = recievedTaskName
            }
        }
        return returnTaskName
    }
    
    func unwrapDescription(_ initTasIndex: Int) -> String {
        var returnDescription: String = ""
        if GetDataInput().retrieveData().count > 0{
            if GetDataInput().retrieveData()[initTasIndex].taskDescription != nil{
                if let recievedDescription = GetDataInput().retrieveData()[initTasIndex].taskDescription{
                    returnDescription = recievedDescription
                }
            }
        }
        return returnDescription
    }
    
    func unwrapDueDate(_ initTasIndex: Int) -> String {
        var returnDueDate: String = ""
        if GetDataInput().retrieveData().count > 0{
            if GetDataInput().retrieveData()[initTasIndex].dueDate != nil{
                if let recievedDueDate = GetDataInput().retrieveData()[initTasIndex].dueDate{
                    returnDueDate = recievedDueDate
                }
            }
        }
        return returnDueDate
    }
    
    func unwrapIsPriority(_ initTasIndex: Int) -> String {
        var returnIsPriority: String = ""
        if GetDataInput().retrieveData().count > 0{
            if GetDataInput().retrieveData()[initTasIndex].isPriority == true{
                if let recievedTaskName = GetDataInput().retrieveData()[initTasIndex].taskName{
                    for i in 0...(GetPrioritized().retrieveData().count - 1){
                        if let recievedPriorityTask = GetPrioritized().retrieveData()[i].taskToPrioritize{
                            if recievedTaskName == recievedPriorityTask{
                                returnIsPriority = priorityLabels[i]
                            }
                        }
                    }
                }
            }
        }
        return returnIsPriority
    }
    
    func saveNewTask(){
        if taskNametoBeChecked != ""{
            if GetDataInput().checkTask(taskNametoBeChecked) == false {
                GetDataInput().saveTaskName(taskNametoBeChecked)
                toDetaView()
            }
            else{taskExists()}
        }
    }
    
    func getCurrentDate() -> String{
        var returnDate: String = ""
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        //formatter.timeStyle = .full// for time use this!
        returnDate = formatter.string(from: now)
        return returnDate
    }
    
    @objc func removeTaskCompleteClicked(_ sender: UIButton){
        let index = sender.tag
        confirmRemoveTaskComplete(index)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentInputText = taskInputField.text ?? ""
        guard let stringRange = Range(range, in: currentInputText) else{
            return false
        }
        let updatedText = currentInputText.replacingCharacters(in: stringRange, with: string)
        inputCounter.title = "\(30 - updatedText.count)"
        self.tableView.reloadData()
        let shouldChange = updatedText.count < 30
        if shouldChange {
            taskNametoBeChecked = currentInputText + string
        }
        return shouldChange
    }
    
    func setPriorityImage(_ initTaskIndex: Int) -> UIImage {
        var returnImage: UIImage?
        if let recievedImage = UIImage(systemName: "paperclip.circle"){
            returnImage = recievedImage
        }
        if GetDataInput().retrieveData()[initTaskIndex].isPriority == true{
            for i in 0...(GetPrioritized().retrieveData().count - 1){
                if let recievedTaskName = GetDataInput().retrieveData()[initTaskIndex].taskName{
                    if let recievedPrioritizedTask = GetPrioritized().retrieveData()[i].taskToPrioritize{
                        if recievedTaskName == recievedPrioritizedTask {
                            returnImage = UIImage(systemName: "checkmark.seal.fill")
                            switch i {
                            case 0:
                                priorityColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                            case 1:
                                priorityColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                            case 2:
                                priorityColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                            case 3:
                                priorityColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                            default:
                                print("something went wrong with: Priority color coding!!!")
                            }
                        }
                    }
                }
            }
        }
        return returnImage!
    }
    
    @objc func makeTaskPriority(_ sender: UIButton){
        let index = sender.tag
        if GetDataInput().retrieveData().count > 0{
            choosePriorityLeve(index)
        }
    }
    
    func choosePriorityLeve(_ initTaskIndex: Int){
        let alert = UIAlertController(
            title: "Priority Level?",
            message: "adding priority to the task.",
            preferredStyle: .alert
        )

        let urgentAction = UIAlertAction(title: "Urgent", style: .default) { _ in
            self.priorityLevel = 0
            GetDataInput().saveIsPriority(initTaskIndex, self.priorityLevel)
            GetDataInput().reoderTasks(initTaskIndex, self.priorityLevel)
            self.tableView.reloadData()
        }
        alert.addAction(urgentAction)
        
        let importantAction = UIAlertAction(title: "Important", style: .default) { _ in
            self.priorityLevel = 1
            GetDataInput().saveIsPriority(initTaskIndex, self.priorityLevel)
            GetDataInput().reoderTasks(initTaskIndex, self.priorityLevel)
            self.tableView.reloadData()
        }
        alert.addAction(importantAction)
        
        let pressingAction = UIAlertAction(title: "Pressing", style: .default) { _ in
            self.priorityLevel = 2
            GetDataInput().saveIsPriority(initTaskIndex, self.priorityLevel)
            GetDataInput().reoderTasks(initTaskIndex, self.priorityLevel)
            self.tableView.reloadData()
        }
        alert.addAction(pressingAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func confirmAddTask(){
        if taskNametoBeChecked != ""{
            let alert = UIAlertController(
                title: "Save task?",
                message: "adding '\(taskNametoBeChecked)' to the list.",
                preferredStyle: .alert
            )

            let okAction = UIAlertAction(title: "Yes", style: .default) { _ in
                self.saveNewTask()
                self.tableView.reloadData()
            }
            alert.addAction(okAction)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func taskExists(){
        if taskInputField.text != ""{
            let alert = UIAlertController(
                title: "'\(taskNametoBeChecked)' already exists",
                message: "enter a new task name!",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func confirmRemoveTaskComplete(_ initTaskIndex: Int){
        if GetDataInput().retrieveData().count > 0{
            if let recievedTaskToBeRemoved = GetDataInput().retrieveData()[initTaskIndex].taskName{
                let alert = UIAlertController(
                    title: "Is task complete?",
                    message: "removing '\(recievedTaskToBeRemoved)' from list",
                    preferredStyle: .alert
                )
                let yesAction = UIAlertAction(title: "Task complete", style: .default) { _ in
                    if GetDataInput().checkTask(recievedTaskToBeRemoved) == true{
                        GetDataInput().deleteTask(recievedTaskToBeRemoved, self.getCurrentDate(), self.taskCompletedRemoved)
                        self.tableView.reloadData()
                    }
                }
                alert.addAction(yesAction)
                
                let noAction = UIAlertAction(title: "Task incomplete", style: .default) { _ in
                    if GetDataInput().checkTask(recievedTaskToBeRemoved) == true{
                        GetDataInput().deleteTask(recievedTaskToBeRemoved, self.getCurrentDate(), self.taskIncompletedRemoved)
                        self.tableView.reloadData()
                    }
                }
                alert.addAction(noAction)
                
                alert.addAction(UIAlertAction(title: "Don't remove task", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            
        }
    }
    
    func toDetaView() {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailView" )
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)*/
        performSegue(withIdentifier: "moveToDetailView", sender: self)
    }
}

