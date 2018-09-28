//
//  MessageChangeTableViewCell.swift
//  RouteContextApp
//
//  Created by Tomas Martins on 12/09/2018.
//  Copyright © 2018 Tomas Martins. All rights reserved.
//

import UIKit

class MessageChangeTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
