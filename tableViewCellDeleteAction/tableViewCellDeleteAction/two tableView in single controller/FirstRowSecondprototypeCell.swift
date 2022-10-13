//
//  FirstRowSecondprototypeCell.swift
//  tableViewCellDeleteAction
//
//  Created by Piyush Naranje on 15/04/22.
//

import UIKit

class FirstRowSecondprototypeCell: UITableViewCell {

    @IBOutlet var cellImg: UIImageView!
    @IBOutlet var cellCharacter: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
