//
//  ProgressView.swift
//  Listed
//
//  Created by Mbuso on 2021/09/24.
//

import UIKit

class ProgressView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var inProgress: UITableView!
    @IBOutlet weak var removedItems: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inProgress.delegate = self
        inProgress.dataSource = self
        removedItems.delegate = self
        removedItems.dataSource = self
        
        inProgress.reloadData()
        removedItems.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inProgress.reloadData()
        removedItems.reloadData()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
