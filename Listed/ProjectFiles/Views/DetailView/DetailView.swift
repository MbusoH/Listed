//
//  ViewController.swift
//  Listed
//
//  Created by Mbuso on 2021/09/14.
//

import UIKit

class DetailView: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var subTaskInput: UITextField!
    @IBOutlet weak var addSubTask: UIButton!
    @IBOutlet weak var subTasksList: UITableView!
    @IBOutlet weak var descriptionInput: UITextView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var selectingDueDate: UIDatePicker!
    var tappedIndex: Int?
    var taskNameForDetailView: String?
    var taskDescriptionForDetailView: String?
    var taskDue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subTasksList.delegate = self
        subTasksList.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unwrapDescription()
        unwrapPlaceHolders()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            unwrapDescription()
        }
    }

    @IBAction func addDueDate(_ sender: Any) {
        datePicking()
    }
    
    
    @IBAction func addingSubTask(_ sender: UIButton) {
        addingSubTask()
    }
    
}

