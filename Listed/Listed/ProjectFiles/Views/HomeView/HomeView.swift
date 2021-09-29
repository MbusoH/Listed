//
//  HomeView.swift
//  Listed
//
//  Created by Mbuso on 2021/09/14.
//

import UIKit

class HomeView: UITableViewController,  UITextFieldDelegate{
    
    
    
    @IBOutlet weak var taskInputField: UITextField!
    @IBOutlet weak var inputCounter: UIBarButtonItem!
    
    var taskNametoBeChecked: String = ""
    var taskCompletedRemoved: String = "Complete"
    var taskIncompletedRemoved: String = "Incomplete"
    var priorityLevel: Int = 0
    var priorityColor: UIColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    var priorityLabels = ["Urgent", "Important", "Pressing"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        taskInputField.delegate = self
        inputCounter.title = "30"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print("++++++++++++++++++++++++++++++ \(GetDataInput().retrieveData()[0].taskName)")
        return GetDataInput().retrieveData().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        // Configure the cell...
        cell.taskName.text = unwrapTaskName(indexPath.row)
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
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        /*let item = items[fromIndexPath.row]
        items.removeAtIndex(fromIndexPath.row)
        items.insert(item, atIndex: toIndexPath.row)*/
    }
    
    
  
    @IBAction func addTaskTapped(_ sender: Any) {
        confirmAddTask()
    }

    
    @IBAction func searchTaskTapped(_ sender: Any) {
        print("------------------- hello")
    }
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
