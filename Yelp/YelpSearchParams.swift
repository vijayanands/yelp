//
//  YelpSearchParams.swift
//  Yelp
//
//  Created by Vijayanand on 9/24/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class YelpSearchParams: NSObject {
	var term: String? = nil
	var sort: YelpSortMode? = nil
	var categories: [String]? = nil
	var deals: Bool? = nil
	var radius_filter: Int? = nil
	var offset: Int? = nil
	var limit: Int? = nil
	
	func customInit(term: String?, sort: YelpSortMode?, categories: [String]?, deals: Bool?, radius_filter: Int?, offset: Int?, limit: Int?) {
		self.term = term
		self.sort = sort
		self.categories = categories
		self.deals = deals
		self.radius_filter = radius_filter
		self.offset = offset
		self.limit = limit
	}
}
