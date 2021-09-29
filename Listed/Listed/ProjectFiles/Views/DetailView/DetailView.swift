//
//  ViewController.swift
//  Listed
//
//  Created by Mbuso on 2021/09/14.
//

import UIKit

class DetailView: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var descriptionInput: UITextView!
    var tappedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        descriptionInput.text = "Add a description!!!"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            unwrapDescription()
        }
    }


}

