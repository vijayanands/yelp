//
//  FilterCell.swift
//  Yelp
//
//  Created by Vijayanand on 9/22/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import PWSwitch

@objc protocol FilterCellDelegate {
	@objc optional func filterCell(filterCell: FilterCell, didChangeValue value: Bool)
}

class FilterCell: UITableViewCell {
	@IBOutlet weak var itemLabel: UILabel!
	@IBOutlet weak var switchView: UIView!

	var pwSwitch = PWSwitch(frame: CGRect(x: 0, y: 0, width: 50, height: 26))
	weak var delegate: FilterCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		switchView.addSubview(pwSwitch)
		pwSwitch.addTarget(self, action: #selector(FilterCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func switchValueChanged() {
		delegate?.filterCell?(filterCell: self, didChangeValue: pwSwitch.on)
	}

}
