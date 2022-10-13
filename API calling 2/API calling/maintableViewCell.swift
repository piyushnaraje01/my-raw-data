//
//  maintableViewCell.swift
//  API calling
//
//  Created by Piyush Naranje on 18/04/22.
//

import UIKit

class maintableViewCell: UITableViewCell {

    @IBOutlet var idNumberLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var phoneNumberLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
