//
//  SavedSearch.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/29/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import SwiftyJSON

class SavedSearch: CustomStringConvertible {
//{"id":1060}
//    {"name":"Just In: adidas Yeezy Boost 700 Static"}
//    {"image_url":"https:\/\/d1qz9pzgo5wm5k.cloudfront.net\/api\/file\/oERz9bwARrefv3qE7hPO"}
//    {"item_type":"saved_search"}
//    {"published":true}
//    {"published_at":"2018-12-29T14:34:09.575Z"}
//    {"article":null}
//    {"search":{"uuid":"AYNBvRD8Qw","index_name":"Listing_by_date_added","default_name":null,"query":"700 static","filters":{"strata":["basic","grailed","hype","sartorial"],"designers":[9424,9465,14440]},"url_path":null}}
    var id: Int = 0
    var name: String = ""
    var imageURL: String = ""
    var publishedAt: String = ""
    var published: Bool = false
    var article: Article?

    var listings: [String] = []
    var tagList: [String] = []

    var franchise: String = ""
    var slug: String = ""
    var author: String = ""
    var contentType: String = ""
    var position: String = ""

    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.imageURL = json["image_url"].stringValue
        self.publishedAt = json["published_at"].stringValue
        self.published = json["published"].boolValue
//        self.article =

//        if let listings = json["listings"].arrayObject as? [String] {
//            self.listings = listings
//        }

        self.franchise = json["franchise"].stringValue
        self.slug = json["slug"].stringValue
        self.author = json["author"].stringValue
        self.contentType = json["content_type"].stringValue
        self.position = json["position"].stringValue
    }

    var description: String {
        var description = ""
        description += "[id: \(self.id),\n"
        description += "author: \(self.author)]"
        return description
    }
}

extension SavedSearch: Equatable {
    static func == (lhs: SavedSearch, rhs: SavedSearch) -> Bool {
        return lhs.id == rhs.id
    }
}
