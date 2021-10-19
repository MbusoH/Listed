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
        var returnDescription: String = "Add a description!"
        if GetDataInput().retrieveData().count > 0{
            if GetDataInput().retrieveData()[initTasIndex].taskDescription != ""{
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
                    let daysLeft = daysLeftToDueDate(recievedDueDate)
                    returnDueDate = "Due in \(daysLeft) days"
                }
            }
        }
        return returnDueDate
    }
    
    func unwrapIsPriority(_ initTasIndex: Int) -> String {
        var returnIsPriority: String = "Add priority?"
        if GetDataInput().retrieveData().count > 0{
            if let recievedTaskName = GetDataInput().retrieveData()[initTasIndex].taskName{
                
                if GetPrioritizedRed().checkingTask(recievedTaskName) == true{
                    if GetPrioritizedRed().retrieveData().count > 0{
                        for i in 0...(GetPrioritizedRed().retrieveData().count - 1){
                            if let recievedPriorityTask = GetPrioritizedRed().retrieveData()[i].taskToPrioritize{
                                if recievedTaskName == recievedPriorityTask{
                                    returnIsPriority = priorityLabels[0]
                                }
                            }
                        }
                    }
                }
                
                if GetPrioritizedGreen().checkingTask(recievedTaskName) == true{
                    if GetPrioritizedGreen().retrieveData().count > 0{
                        for i in 0...(GetPrioritizedGreen().retrieveData().count - 1){
                            if let recievedPriorityTask = GetPrioritizedGreen().retrieveData()[i].taskToPrioritize{
                                if recievedTaskName == recievedPriorityTask{
                                    returnIsPriority = priorityLabels[1]
                                }
                            }
                        }
                    }
                }
                
                if GetPrioritizedBlue().checkingTask(recievedTaskName) == true{
                    if GetPrioritizedBlue().retrieveData().count > 0{
                        for i in 0...(GetPrioritizedBlue().retrieveData().count - 1){
                            if let recievedPriorityTask = GetPrioritizedBlue().retrieveData()[i].taskToPrioritize{
                                if recievedTaskName == recievedPriorityTask{
                                    returnIsPriority = priorityLabels[2]
                                }
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
                GetDataInput().saveTaskName(taskNametoBeChecked, taskDescriptionToBeSaved)
                toDetailView()
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
    
    func textField1(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentInputText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentInputText) else{
            return false
        }
        let updatedText = currentInputText.replacingCharacters(in: stringRange, with: string)
        inputCounter.title = "\(30 - updatedText.count)"
        self.tableView.reloadData()
        let shouldChange = updatedText.count < 30
        if shouldChange {
            //taskNametoBeChecked = currentInputText + string
        }
        return shouldChange
    }
    
    func setPriorityImage(_ initTaskIndex: Int) -> UIImage {
        var returnImage: UIImage?
        if let recievedImage = UIImage(systemName: "paperclip.circle"){
            returnImage = recievedImage
        }
       
        if let recievedTaskToPrioritize = GetDataInput().retrieveData()[initTaskIndex].taskName{
            
            if GetPrioritizedRed().checkingTask(recievedTaskToPrioritize) == true{
                if GetPrioritizedRed().retrieveData().count > 0 {
                    for i in 0...(GetPrioritizedRed().retrieveData().count - 1){
                        if let recievedTaskName = GetDataInput().retrieveData()[initTaskIndex].taskName{
                            if let recievedPrioritizedTask = GetPrioritizedRed().retrieveData()[i].taskToPrioritize{
                                if recievedTaskName == recievedPrioritizedTask {
                                    returnImage = UIImage(systemName: "checkmark.seal.fill")
                                    priorityColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                                }
                            }
                        }
                    }
                }
            }
            
            if GetPrioritizedGreen().checkingTask(recievedTaskToPrioritize) == true{
                if GetPrioritizedGreen().retrieveData().count > 0 {
                    for i in 0...(GetPrioritizedGreen().retrieveData().count - 1){
                        if let recievedTaskName = GetDataInput().retrieveData()[initTaskIndex].taskName{
                            if let recievedPrioritizedTask = GetPrioritizedGreen().retrieveData()[i].taskToPrioritize{
                                if recievedTaskName == recievedPrioritizedTask {
                                    returnImage = UIImage(systemName: "checkmark.seal.fill")
                                    priorityColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                                }
                            }
                        }
                    }
                }
            }
            
            if GetPrioritizedBlue().checkingTask(recievedTaskToPrioritize) == true{
                if GetPrioritizedBlue().retrieveData().count > 0 {
                    for i in 0...(GetPrioritizedBlue().retrieveData().count - 1){
                        if let recievedTaskName = GetDataInput().retrieveData()[initTaskIndex].taskName{
                            if let recievedPrioritizedTask = GetPrioritizedBlue().retrieveData()[i].taskToPrioritize{
                                if recievedTaskName == recievedPrioritizedTask {
                                    returnImage = UIImage(systemName: "checkmark.seal.fill")
                                    priorityColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                                }
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
            GetDataInput().saveIsPriority(initTaskIndex, String(self.priorityLevel))
            self.tableView.reloadData()
        }
        alert.addAction(urgentAction)
        
        let importantAction = UIAlertAction(title: "Important", style: .default) { _ in
            self.priorityLevel = 1
            GetDataInput().saveIsPriority(initTaskIndex, String(self.priorityLevel))
            self.tableView.reloadData()
        }
        alert.addAction(importantAction)
        
        let pressingAction = UIAlertAction(title: "Pressing", style: .default) { _ in
            self.priorityLevel = 2
            GetDataInput().saveIsPriority(initTaskIndex, String(self.priorityLevel))
            self.tableView.reloadData()
        }
        alert.addAction(pressingAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func addingNewTask(){
        
        let alertController = UIAlertController(title: "Add New Task", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter New Task Name"
            //textField1(textField, shouldChangeCharactersIn: 30, replacementString: <#T##String#>)
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let newTask = alertController.textFields![0] as UITextField
            let description = alertController.textFields![1] as UITextField
            if let recievedNewTask = newTask.text{
                if let recievedTaskDescription = description.text{
                    self.taskDescriptionToBeSaved = recievedTaskDescription
                    self.taskNametoBeChecked = recievedNewTask
                    self.confirmAddTask()
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Description"
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
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
        if taskNametoBeChecked != ""{
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
                        self.deletingRedPriority(recievedTaskToBeRemoved)
                        self.deletingGreenPriority(recievedTaskToBeRemoved)
                        self.deletingBluePriority(recievedTaskToBeRemoved)
                        self.tableView.reloadData()
                    }
                }
                alert.addAction(yesAction)
                
                let noAction = UIAlertAction(title: "Task incomplete", style: .default) { _ in
                    if GetDataInput().checkTask(recievedTaskToBeRemoved) == true{
                        GetDataInput().deleteTask(recievedTaskToBeRemoved, self.getCurrentDate(), self.taskIncompletedRemoved)
                        self.deletingRedPriority(recievedTaskToBeRemoved)
                        self.deletingGreenPriority(recievedTaskToBeRemoved)
                        self.deletingBluePriority(recievedTaskToBeRemoved)
                        self.tableView.reloadData()
                    }
                }
                alert.addAction(noAction)
                
                alert.addAction(UIAlertAction(title: "Don't remove task", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            
        }
    }
    
    func toDetailView() {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailView" )
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)*/
        performSegue(withIdentifier: "moveToDetailView", sender: self)
    }
    
    func deletingRedPriority(_ initTaskName: String){
        if GetPrioritizedRed().checkingTask(initTaskName) == true{
            GetPrioritizedRed().deleteTask(initTaskName)
        }
    }
    
    func deletingGreenPriority(_ initTaskName: String){
        if GetPrioritizedGreen().checkingTask(initTaskName) == true{
            GetPrioritizedGreen().deleteTask(initTaskName)
        }
    }
    
    func deletingBluePriority(_ initTaskName: String){
        if GetPrioritizedBlue().checkingTask(initTaskName) == true{
            GetPrioritizedBlue().deleteTask(initTaskName)
        }
    }
    
    func numberOfDaysBetween(_ to: Date) -> Int {
        let calendar = Calendar.current
        let fromDate = calendar.startOfDay(for: Date())
        let toDate = calendar.startOfDay(for: to)
        let numberOfDays = calendar.dateComponents([.day], from: fromDate, to: toDate)
        return numberOfDays.day! + 1
    }
    
    func convertDate(_ iniDateString: String) -> Date{
        var returnDate: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = dateFormatter.date(from: iniDateString){
            returnDate = date
        }
        return returnDate
    }
    
    func daysLeftToDueDate(_ initDate: String) -> Int{
        var returnNumberOfDays: Int = 0
        let dateToConvert: Date = convertDate(initDate)
        returnNumberOfDays = numberOfDaysBetween(dateToConvert)
        return returnNumberOfDays
    }
    
    func dueDateUpdating(){
        if GetDataInput().retrieveData().count > 0{
            for i in 0...(GetDataInput().retrieveData().count - 1){
                if let recievedDate = GetDataInput().retrieveData()[i].dueDate{
                    let dueDatePasted: Int = HomeView().daysLeftToDueDate(recievedDate)
                    if dueDatePasted <= 0{
                        
                    }
                }
            }
        }
    }
    
    func localNotification(){

        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]){(granted, error) in}
        
        let content = UNMutableNotificationContent()
        content.title = unwrapTaskName(taskIndexForNotifications)
        content.body = unwrapDescription(taskIndexForNotifications)
        content.badge = 1
        content.sound = UNNotificationSound.default
        if let recievedCountDown = GetDataInput().retrieveData()[taskIndexForNotifications].intervalCountDown{
            timeIntervalCountDown = Double(recievedCountDown)!
        }
        let date = Date().addingTimeInterval(TimeInterval(timeIntervalCountDown))
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second], from: date
        )
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents , repeats: true
        )
        
        let identifier = "Main Identifier"
        let request = UNNotificationRequest.init(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        
        center.add(request){(error) in
            print("\(error?.localizedDescription)")
        }
        
        //let like = UNNotificationAction.init(identifier: "Like", title: "Like", options: .foreground)
        let delete = UNNotificationAction.init(identifier: "Close", title: "Close", options: .destructive)
        let category = UNNotificationCategory.init(
            identifier: content.categoryIdentifier,
            actions: [/*like,*/ delete], intentIdentifiers: [],
            options: []
        )
        
        center.setNotificationCategories([category])
        
        /*let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]){(granted, error) in}
        
        let content = UNMutableNotificationContent()
        content.title = "The title"
        content.body = "This were the body of the local notification goes"
        
        let date = Date().addingTimeInterval(5)
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second], from: date
        )
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents , repeats: false
        )
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(
            identifier: uuidString,
            content: content,
            trigger: trigger
        )
        
        center.add(request){(error) in }*/
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        openSettingsFor notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ){
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ){
        loadDetailPage()
    }
    
    func loadDetailPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailView") as! DetailView
        vc.modalPresentationStyle = .fullScreen
        vc.tappedIndex = taskIndexForNotifications
        vc.taskNameForDetailView =   unwrapTaskName(taskIndexForNotifications)
        vc.taskDescriptionForDetailView = unwrapDescription(taskIndexForNotifications)
        vc.taskDue = "DUE NOW!!!"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setDueDates(completion: @escaping () -> ()){
        if GetDataInput().retrieveData().count > 0{
            for i in 0...(GetDataInput().retrieveData().count - 1){
                if GetDataInput().retrieveData()[i].addReminder == true{
                    taskIndexForNotifications = i
                    completion()
                }
            }
        }
    }
}

 
