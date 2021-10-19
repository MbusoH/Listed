//
//  HomeView.swift
//  Listed
//
//  Created by Mbuso on 2021/09/14.
//

import UIKit
import UserNotifications

class HomeView: UITableViewController,  UITextFieldDelegate, UNUserNotificationCenterDelegate{
    
    
    
    @IBOutlet weak var taskInputField: UITextField!
    @IBOutlet weak var inputCounter: UIBarButtonItem!
    
    var taskNametoBeChecked: String = ""
    var taskDescriptionToBeSaved: String = ""
    var taskCompletedRemoved: String = "Complete"
    var taskIncompletedRemoved: String = "Incomplete"
    var priorityLevel: Int = 0
    var priorityColor: UIColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    var priorityLabels = ["Urgent", "Important", "Pressing"]
    let center = UNUserNotificationCenter.current()
    var taskIndexForNotifications: Int = 0
    var timeIntervalCountDown: Double = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskInputField.delegate = self
        inputCounter.title = "30"
        setDueDates{
            self.localNotification()
            print("this function is running!!!!!!!!!!!!!!!!!!")
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  GetDataInput().retrieveData().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        // Configure the cell...
        cell.taskName.text = unwrapTaskName(indexPath.row)
        print("ˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆ^\(indexPath.row)")
        cell.dueDate.text = unwrapDueDate(indexPath.row)
        cell.isPriority.text = unwrapIsPriority( indexPath.row)
        cell.taskDescription.text = unwrapDescription(indexPath.row)
        cell.romeveCompleteButton.tag = indexPath.row
        cell.romeveCompleteButton.addTarget(self, action: #selector(removeTaskCompleteClicked(_:)), for: .touchUpInside)
        cell.isPriorityButton.setImage(setPriorityImage(indexPath.row), for: .normal)
        cell.isPriorityButton.tintColor = priorityColor
        cell.isPriorityButton.tag = indexPath.row
        cell.isPriorityButton.addTarget(self, action: #selector(makeTaskPriority(_:)), for: .touchUpInside)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DetailPages = segue.destination as? DetailView {
            DetailPages.tappedIndex = (tableView.indexPathForSelectedRow?.row)
            if let recievedIndex = (tableView.indexPathForSelectedRow?.row){
                DetailPages.taskNameForDetailView =  unwrapTaskName(recievedIndex)
                DetailPages.taskDescriptionForDetailView = unwrapDescription(recievedIndex)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {}
    
    
  
    @IBAction func addTaskTapped(_ sender: Any) {
        addingNewTask()
    }

    
    @IBAction func searchTaskTapped(_ sender: Any) {
        print("------------------- hello")
    }
}
