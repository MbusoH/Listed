//
//  RemovedItemCell.swift
//  Listed
//
//  Created by Mbuso on 2021/09/24.
//

import UIKit

class RemovedItemCell: UITableViewCell {
 
    @IBOutlet weak var removedTaskName: UILabel!
    @IBOutlet weak var dateRemoved: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
