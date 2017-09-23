//
//  FilterCell.swift
//  Yelp
//
//  Created by Vijayanand on 9/22/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {
	@IBOutlet weak var itemLabel: UILabel!
	@IBOutlet weak var itemSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
