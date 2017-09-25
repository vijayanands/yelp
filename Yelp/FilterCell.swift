//
//  FilterCell.swift
//  Yelp
//
//  Created by Vijayanand on 9/22/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FilterCellDelegate {
	@objc optional func filterCell(filterCell: FilterCell, didChangeValue value: Bool)
}

class FilterCell: UITableViewCell {
	@IBOutlet weak var itemLabel: UILabel!
	@IBOutlet weak var uikitSwitch: UISwitch!

	weak var delegate: FilterCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		uikitSwitch.addTarget(self, action: #selector(FilterCell.switchValueChanged), for: UIControlEvents.valueChanged)
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func switchValueChanged() {
 		delegate?.filterCell?(filterCell: self, didChangeValue: uikitSwitch.isOn)
	}

}
