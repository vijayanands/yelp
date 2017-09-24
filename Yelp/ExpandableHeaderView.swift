//
//  ExpandableHeaderView.swift
//  Yelp
//
//  Created by Vijayanand on 9/24/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol ExpandableHeaderViewDelegate {
	@objc optional func expandSection(expandableHeaderView: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {

	weak var delegate: ExpandableHeaderViewDelegate?
	var section: Int!
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectSectionHeaderAction)))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func selectSectionHeaderAction(gestureRecognizer: UIGestureRecognizer) {
		let cell = gestureRecognizer.view as! ExpandableHeaderView
		delegate?.expandSection!(expandableHeaderView: self, section: cell.section)
	}
	
	func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
		self.textLabel?.text = title
		self.section = section
		self.delegate = delegate
//		self.textLabel?.textColor = UIColor.black
//		self.contentView.backgroundColor = UIColor(red: 230/255, green: 243/255, blue: 247/255, alpha: 1.0)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
