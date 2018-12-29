//
//  Search.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/29/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import SwiftyJSON

class Filter {

}

class Search: CustomStringConvertible {
//    {"uuid":"AYNBvRD8Qw"}
//    {"index_name":"Listing_by_date_added"}
//    {"default_name":null}
//    {"query":"700 static"}
//    {"filters":{"strata":["basic","grailed","hype","sartorial"],"designers":[9424,9465,14440]}}
//    {"url_path":null}
    var uuid: String = ""
    var indexName: String = ""
    var defaultName: String?
    var query: String = ""
    var filters: [Filter] = []
    var urlPath: String?

    init(json: JSON) {
        self.uuid = json["uuid"].stringValue
        self.indexName = json["index_name"].stringValue

        self.query = json["query"].stringValue
    }

    var description: String {
        var description = ""
        description += "[uuid: \(self.uuid),\n"
        description += "indexName: \(self.indexName),\n"
        description += "query: \(self.query),\n"
        return description
    }
}

extension Search: Equatable {
    static func == (lhs: Search, rhs: Search) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
