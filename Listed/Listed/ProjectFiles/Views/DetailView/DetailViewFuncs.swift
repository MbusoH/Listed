//
//  DetailViewFuncs.swift
//  Listed
//
//  Created by Mbuso on 2021/09/28.
//

import Foundation
import UIKit

extension DetailView{
    
    func unwrapDescription(){
        if let recievedDescription = descriptionInput.text{
            if let recievedIndex = self.tappedIndex{
                //GetDataInput().saveTaskDescription(recievedIndex, recievedDescription)
            }
        }
    }
    
    func unwrapPlaceHolders(){
        checkIfDuedatePasted()
        let indexForNewTask: Int = GetDataInput().retrieveData().count > 0 ? GetDataInput().retrieveData().count - 1: GetDataInput().retrieveData().count
        if tappedIndex == nil{
            tappedIndex = indexForNewTask
        }
        descriptionInput.text = GetDataInput().retrieveData()[indexForNewTask].taskDescription
        if let recievedTaskDescription = self.taskDescriptionForDetailView{
            descriptionInput.text = recievedTaskDescription
        }
        taskName.text = GetDataInput().retrieveData()[indexForNewTask].taskName
        if let recievedTaskName = self.taskNameForDetailView{
            self.taskName.text = recievedTaskName
        }
        if let recievedTaskDue = self.taskDue{
            dueDateLabel.text = recievedTaskDue
            dueDateLabel.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
    func datePicking(){
        let indexForNewTask: Int = GetDataInput().retrieveData().count > 0 ? GetDataInput().retrieveData().count - 1: GetDataInput().retrieveData().count
        if self.tappedIndex == nil{
            self.tappedIndex = indexForNewTask
        }
        if let recievedIndex = self.tappedIndex{
            GetDataInput().saveAddReminder(recievedIndex)
        }
        selectingDueDate.datePickerMode = .dateAndTime
        var component = DateComponents()
        component.day = 0
        component.month = 0
        component.year = 0
        selectingDueDate.minimumDate = Calendar.current.date(byAdding: component, to: Date())
        //selectingDueDate.addTarget(self, action: #selector(dueDateSetting(sender:)), for: .valueChanged)
        dueDateSetting(sender: selectingDueDate)
    }
    
    func dueDateSetting(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        let theDate = formatter.string(from: sender.date)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss.SSS"
        let theTime = timeFormatter.string(from: sender.date)
        if let recievedIndex = self.tappedIndex{
            GetDataInput().saveDueDate(recievedIndex, theDate)
            GetDataInput().saveDueDateTime(recievedIndex, theTime)
            if let recievedDueDate = GetDataInput().retrieveData()[recievedIndex].dueDate{
                if let recievedTime = GetDataInput().retrieveData()[recievedIndex].dueDateTime{
                    let countDownToDataBase: Double = dueDateToCountDown(recievedTime, recievedDueDate)
                    if countDownToDataBase > 0{
                        let countDownToString: String = String(countDownToDataBase)
                        GetDataInput().saveIntervalCountDown(recievedIndex, countDownToString)
                        confirmDueDateSet(recievedIndex)
                    }
                    else{incorrectTime(recievedTime, recievedDueDate)}
                }
            }
        }
        /*print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \(theDate) at the time \(theTime)")
        let dateToString: String = String(theDate.prefix(2))
        print(dateToString)
        let numberOfDays: Int = numberOfDaysBetween(sender.date)
        print("number of days to due date are \(numberOfDays)")*/
    }
    
    func checkIfDuedatePasted(){
        if GetDataInput().retrieveData().count > 0{
            for i in 0...(GetDataInput().retrieveData().count - 1){
                if let recievedDate = GetDataInput().retrieveData()[i].dueDate{
                    let dueDatePasted: Int = HomeView().daysLeftToDueDate(recievedDate)
                    if dueDatePasted <= 0{
                        dueDateLabel.text = "OVER DUE!!!"
                        dueDateLabel.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                    }
                }
            }
        }
    }
    
    func confirmDueDateSet(_ initTaskIndex: Int){
        if let recievedDueDate = GetDataInput().retrieveData()[initTaskIndex].dueDate{
            if let recievedTime = GetDataInput().retrieveData()[initTaskIndex].dueDateTime{
                let alert = UIAlertController(
                    title: "Task Due Date Set",
                    message: "Date : \(recievedDueDate) at time: \(recievedTime)",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    func dueDateToCountDown(_ initDueTime: String, _ initDueDate: String) -> Double{
        var countDownInterval: Double = 0.0
        let currentTimeInterval: Double = currentDateInterval()
        let dueDateInterval: Double = dueDateTimeInterval(initDueTime)
        countDownInterval = dueDateInterval - currentTimeInterval
        let dueDateDays: Int = HomeView().daysLeftToDueDate(initDueDate)
        if dueDateDays > 1{
            countDownInterval = countDownInterval + Double((dueDateDays - 1) * (24 * 3600))
        }
        return countDownInterval
    }
    
    func dueDateTimeInterval(_ initDueTime: String) -> Double{
        var returnDueDateTimeInterval: Double = 0.0
        let splitTime : [String] = initDueTime.components(separatedBy: ":")
        let hour: Int =  Int(splitTime[0])! * 3600
        let minutes: Int = Int(splitTime[1])! * 60
        let seconds: Int = Int(Double(splitTime[2])!.rounded())
        returnDueDateTimeInterval = Double(hour) + Double(minutes) + Double(seconds)
        return returnDueDateTimeInterval
    }
    
    func currentDateInterval() -> Double{
        var returnCurrentInterval: Double = 0.0
        let date = Date()
        let calendar = Calendar.current
        let hourNow = calendar.component(.hour, from: date)
        let minutesNow = calendar.component(.minute, from: date)
        let secondsNow = calendar.component(.second, from: date)
        returnCurrentInterval = Double(hourNow * 3600) + Double(minutesNow * 60) + Double(secondsNow)
        return returnCurrentInterval
    }
    
    func incorrectTime(_ initDueTime: String ,_ initDueDate: String){
        let dueDateDays: Int = HomeView().daysLeftToDueDate(initDueDate)
        if dueDateDays <= 1{
            let alert = UIAlertController(
                title: "Time \(initDueTime) has passed",
                message: "choose a future time!!!",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return GetSubTasks().retrieveData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell() as AnyObject
        cell = tableView.dequeueReusableCell(withIdentifier: "subTaskCell", for: indexPath) as! subTaskCell
        cell.sunTaskLabel.text = GetSubTasks().retrieveData()[indexPath.row].subTaskName
        cell.toggleStatusSwitch.tag = indexPath.row
        cell.toggleStatusSwitch.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        cell.toggleStatusSwitch.addTarget(self, action: #selector(subTaskStatus(_:)), for: .valueChanged)
        return cell as! UITableViewCell
    }
    
    @objc func subTaskStatus(_ sender: UISwitch){
        let subTaskIndex: Int = sender.tag
        if sender.isOn{
            GetSubTasks().saveSubTaskStatus(subTaskIndex, true)
            autoCompleteMainTask(subTaskIndex)
        }
        else{GetSubTasks().saveSubTaskStatus(subTaskIndex, false)}
    }
    
    func addingSubTask(){
        let alertController = UIAlertController(title: "Add New Sub Task", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter New Sub Task Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let newTask = alertController.textFields![0] as UITextField
            if let recievedNewTask = newTask.text{
                GetSubTasks().saveSubTask(recievedNewTask, false)
                self.subTasksList.reloadData()
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func autoCompleteMainTask(_ initTaskIndex: Int){
        var allSubTaskCompleted = [String]()
        if GetSubTasks().retrieveData().count > 0{
            let rangeSubTask: Int = GetSubTasks().retrieveData().count
            if rangeSubTask > 1{
                for i in 0...(rangeSubTask - 1){
                    if GetSubTasks().retrieveData()[i].isDone == true{
                        if let recievedSubTaskName = GetSubTasks().retrieveData()[i].subTaskName{
                            allSubTaskCompleted.append(recievedSubTaskName)
                            deleteMainTaskAutoComplete(allSubTaskCompleted, initTaskIndex)
                        }
                    }
                }
            }
            else{
                if GetSubTasks().retrieveData()[0].isDone == true{
                    if let recievedSubTaskName = GetSubTasks().retrieveData()[0].subTaskName{
                        allSubTaskCompleted.append(recievedSubTaskName)
                        deleteMainTaskAutoComplete(allSubTaskCompleted, initTaskIndex)
                    }
                }
            }
        }
    }
    
    func deleteMainTaskAutoComplete(_ initAllCompletedSubTasks: [String], _ initTaskIndex: Int){
        if GetSubTasks().retrieveData().count  ==  initAllCompletedSubTasks.count{
            if let recievedIndex = tappedIndex{
                let mainTaskToDelet: String = HomeView().unwrapTaskName(recievedIndex)
                let taskComplete: String = "Complete"
                let dateNow: String = HomeView().getCurrentDate()
                GetDataInput().deleteTask(mainTaskToDelet, dateNow, taskComplete)
                deletingAllValuesStored(initAllCompletedSubTasks)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "NavigationView" )
                HomeView().tableView.reloadData()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }
    
    func deletingAllValuesStored(_ initAllCompletedSubTasks: [String]){
        if GetSubTasks().retrieveData().count > 1{
            for i in 0...(GetSubTasks().retrieveData().count - 1){
                GetSubTasks().deleteSubTask(initAllCompletedSubTasks[i])
            }
        }
        else{GetSubTasks().deleteSubTask(initAllCompletedSubTasks[0])}
    }
}
