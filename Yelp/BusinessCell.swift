//
//  BusinessCell.swift
//  Yelp
//
//  Created by Vijayanand on 9/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var catogoriesLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    var business: Business! {
        didSet {
            nameLabel.text = business.name // assuming that the business name will always be present
            if let imageURL = business.imageURL {
                thumbImageView.setImageWith(imageURL)
            }
            if let ratingsImageURL = business.ratingImageURL {
                ratingsImageView.setImageWith(ratingsImageURL)
            }
            if let distance = business.distance {
                distanceLabel.text = distance
            }
            if let catogories = business.categories {
                catogoriesLabel.text = catogories
            }
            if let reviews = business.reviewCount {
                reviewsCountLabel.text = "\(reviews) Reviews"
            }
            if let address = business.address {
                addressLabel.text = address
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
