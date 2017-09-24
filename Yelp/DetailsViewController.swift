//
//  DetailsViewController.swift
//  Yelp
//
//  Created by Vijayanand on 9/24/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var address: UILabel!
	@IBOutlet weak var phoneNumber: UILabel!
	@IBOutlet weak var categories: UILabel!
	@IBOutlet weak var about: UILabel!
	@IBOutlet weak var homePage: UILabel!
	@IBOutlet weak var ratingsImage: UIImageView!
	@IBOutlet weak var businessImage: UIImageView!
	
	weak var business: Business?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		name.text = business?.name
		address.text = business?.address
		phoneNumber.text = business?.phone
		categories.text = business?.categories
		about.text = business?.about
		homePage.text = business?.url
		ratingsImage.setImageWith((business?.ratingImageURL)!)
		
		// setup businessImage
		if business?.imageURL != nil {
			let imageRequest = NSURLRequest(url: (business?.imageURL)!)
			
			self.businessImage.setImageWith(
				imageRequest as URLRequest,
				placeholderImage: nil,
				success: { (imageRequest, imageResponse, image) -> Void in
					
					// imageResponse will be nil if the image is cached
					if imageResponse != nil {
						print("Image was NOT cached, fade in image")
						self.businessImage.alpha = 0.0
						self.businessImage.image = image
						UIView.animate(withDuration: 0.3, animations: { () -> Void in
							self.businessImage.alpha = 1.0
						})
					} else {
						print("Image was cached so just update the image")
						self.businessImage.image = image
					}
			},
				failure: { (imageRequest, imageResponse, error) -> Void in
					// do something for the failure condition
			})
		}
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func onClick(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}
	
	
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
