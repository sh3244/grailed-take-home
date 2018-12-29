//
//  Pagination.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/29/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import SwiftyJSON

class Pagination {
    var nextPage: String?
    var currentPage: String?
    var previousPage: String?

    init(json: JSON) {
        self.nextPage = json["next_page"].string
        self.currentPage = json["current_page"].string
        self.previousPage = json["previous_page"].string
    }
}
