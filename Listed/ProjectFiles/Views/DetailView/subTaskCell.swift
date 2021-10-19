//
//  subTaskCell.swift
//  Listed
//
//  Created by Mbuso on 2021/10/18.
//

import UIKit

class subTaskCell: UITableViewCell {

    @IBOutlet weak var toggleStatusSwitch: UISwitch!
    @IBOutlet weak var sunTaskLabel: UILabel!
    @IBOutlet weak var toggleStatus: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
