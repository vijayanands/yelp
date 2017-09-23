//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate {
    
    var businesses: [Business]!
    @IBOutlet weak var resultsTableView: UITableView!
	@IBOutlet weak var filtersButton: UIBarButtonItem!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.estimatedRowHeight = 130
        resultsTableView.rowHeight = UITableViewAutomaticDimension
		
		let searchBar = UISearchBar()
		searchBar.sizeToFit()
		
		// the UIViewController comes with a navigationItem property
		// this will automatically be initialized for you if when the
		// view controller is added to a navigation controller's stack
		// you just need to set the titleView to be the search bar
		self.navigationItem.titleView = searchBar
		
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                self.businesses = businesses
                self.resultsTableView.reloadData()
            
				if let businesses = businesses {
					for business in businesses {
						print(business.name!)
						print(business.address!)
					}
				}
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = self.businesses[indexPath.row]
        
        return cell
    }
	
	func addCustomLeftButton(){
		let viewLeftButton = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
		viewLeftButton.backgroundColor = UIColor.yellow
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
		button.setImage(UIImage(named: "filter.png"), for: .normal)
		button.backgroundColor = UIColor.white
		button.layer.cornerRadius = 5
		button.layer.borderWidth = 1
		viewLeftButton.addSubview(button)
		
		self.filtersButton.customView = viewLeftButton
		self.navigationItem.leftBarButtonItem = self.filtersButton
	}
	
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
	
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
		let navigationController = segue.destination as! UINavigationController
		let filtersViewController = navigationController.topViewController as! FiltersViewController
     // Pass the selected object to the new view controller.
		filtersViewController.delegate = self
     }
	
	func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
		code
	}
	
}
