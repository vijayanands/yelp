//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate, UISearchBarDelegate {
	@IBOutlet weak var resultsViewType: UISegmentedControl!
    
	@IBOutlet weak var mapView: MKMapView!
    var businesses: [Business]!
    @IBOutlet weak var resultsTableView: UITableView!
	@IBOutlet weak var filtersButton: UIBarButtonItem!
	var searchActive: Bool = false
	var searchTerm = "Restaurants"
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.estimatedRowHeight = 130
        resultsTableView.rowHeight = UITableViewAutomaticDimension
		resultsViewType.becomeFirstResponder()
		resultsViewType.layer.borderWidth = 2
		resultsViewType.layer.borderColor = UIColor.gray.cgColor
		
		let searchBar = UISearchBar()
		searchBar.sizeToFit()
		searchBar.delegate = self
		
		// the UIViewController comes with a navigationItem property
		// this will automatically be initialized for you if when the
		// view controller is added to a navigation controller's stack
		// you just need to set the titleView to be the search bar
		self.navigationItem.titleView = searchBar
		
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                self.businesses = businesses
                self.resultsTableView.reloadData()
            
				if let businesses = businesses {
					// Location has been defaulted to San Francisco
					let centerLocation = CLLocation(latitude: 37.785771, longitude: -122.406165)
					self.goToLocation(location: centerLocation)
					for business in businesses {
						print(business.name!)
						print(business.address!)
						self.addAnnotationAtAddress(address: business.address!, title: business.name!)
					}
				}
            }
        )
		resultsTableView.isHidden = false
		mapView.isHidden = true
    }
	
	// add an annotation with an address: String
	func addAnnotationAtAddress(address: String, title: String) {
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(address) { (placemarks, error) in
			if let placemarks = placemarks {
				if placemarks.count != 0 {
					let coordinate = placemarks.first!.location!
					let annotation = MKPointAnnotation()
					annotation.coordinate = coordinate.coordinate
					annotation.title = title
					self.mapView.addAnnotation(annotation)
					self.mapView.selectAnnotation(annotation, animated: true)
				}
			}
		}
	}
	
	func goToLocation(location: CLLocation) {
		let span = MKCoordinateSpanMake(0.01, 0.01)
		let region = MKCoordinateRegionMake(location.coordinate, span)
		mapView.setRegion(region, animated: false)
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
	
	func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
		let categories = filters["categories"] as? [String] ?? nil
		let sort = filters["sortBy"] as? Int ?? nil
		let deals = filters["deals"] as? Bool ?? nil
		let radius_filter = filters["radius_filter"] as? Int ?? nil
		var yelpSortMode:YelpSortMode? = nil
		
		if sort != nil {
			yelpSortMode = YelpSortMode(rawValue: sort!)
		}
		
		Business.searchWithTerm(term: searchTerm, sort: yelpSortMode, categories: categories, deals: deals, radius_filter: radius_filter) { (businesses: [Business]?, error: Error?) in
			self.businesses = businesses
			self.resultsTableView.reloadData()
		}
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchActive = true;
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		searchActive = false;
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchActive = false;
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchActive = false;
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		Business.searchWithTerm(term: searchText, sort: nil, categories: nil, deals: nil, radius_filter: nil) { (businesses: [Business]?, error: Error?) in
			self.businesses = businesses
			self.resultsTableView.reloadData()
		}
		searchTerm = searchText
		searchActive = false;
	}

	@IBAction func resultLayoutChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex
		{
		case 0:
			self.resultsTableView.isHidden = false
			self.mapView.isHidden = true
		case 1:
			self.resultsTableView.isHidden = true
			self.mapView.isHidden = false
		default:
			break;
		}
	}
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destinationViewController.
		let navigationController = segue.destination as! UINavigationController
		let filtersViewController = navigationController.topViewController as! FiltersViewController
		// Pass the selected object to the new view controller.
		filtersViewController.delegate = self
	}
	
}
