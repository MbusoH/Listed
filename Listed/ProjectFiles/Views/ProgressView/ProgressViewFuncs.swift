//
//  ProgressViewFuncs.swift
//  Listed
//
//  Created by Mbuso on 2021/09/24.
//

import Foundation
import UIKit

extension ProgressView {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow: Int = 1
        switch tableView {
        case inProgress:
            numberOfRow = GetDataInput().retrieveData().count
        case removedItems:
            numberOfRow = GetRemovedTasks().retrieveData().count
        default:
            print("something went wrong with: numberOfRowsInSection section ")
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell() as AnyObject
        switch tableView {
        case inProgress:
            cell = tableView.dequeueReusableCell(withIdentifier: "inProgressCell", for: indexPath) as! InProgressCell
            cell.inProgressTaskName?.text = GetDataInput().retrieveData()[indexPath.row].taskName
        case removedItems:
            cell = tableView.dequeueReusableCell(withIdentifier: "removedItemsCell", for: indexPath) as! RemovedItemCell
            cell.removedTaskName?.text = GetRemovedTasks().retrieveData()[indexPath.row].removedTaskName
            if let dateRemoved = GetRemovedTasks().retrieveData()[indexPath.row].dateRemoved{
                if let taskStatus = GetRemovedTasks().retrieveData()[indexPath.row].removedStatus{
                    switch taskStatus {
                    case "Complete":
                        cell.dateRemoved.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    case "Incomplete":
                        cell.dateRemoved.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                    default:
                        print("Something went wrong with the color coding for removed tasks!!!")
                    }
                    cell.dateRemoved??.text = "\(taskStatus) : \(dateRemoved)"
                }
            }
        default:
            print("Something")
        }
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //if same string handle
        
        if tableView == removedItems{
            if editingStyle == .delete {
                
                if let recievedRemovedTaskName = GetRemovedTasks().retrieveData()[indexPath.row].removedTaskName{
                    let itemToDelete: String = recievedRemovedTaskName
                    GetRemovedTasks().deleteRemovedTask(itemToDelete)
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        if tableView == inProgress{
            if editingStyle == .delete {
                if let recievedTaskName = GetDataInput().retrieveData()[indexPath.row].taskName{
                    GetDataInput().deleteTask(recievedTaskName, HomeView().getCurrentDate(), HomeView().taskCompletedRemoved)
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.inProgress.reloadData()
                self.removedItems.reloadData()
            }
        }
    }
}
