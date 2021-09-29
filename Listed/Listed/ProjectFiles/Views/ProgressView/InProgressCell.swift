//
//  InProgressCell.swift
//  Listed
//
//  Created by Mbuso on 2021/09/25.
//

import UIKit

class InProgressCell: UITableViewCell {

    @IBOutlet weak var inProgressTaskName: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var isPriorityButton: UIButton!
    @IBOutlet weak var isPriorityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
