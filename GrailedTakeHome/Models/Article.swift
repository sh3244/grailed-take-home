//
//  Article.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/29/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import SwiftyJSON

class Article: CustomStringConvertible {
//    {"id":2152}
//    {"url":"https:\/\/www.grailed.com\/drycleanonly\/adidas-stan-smith-history"}
//    {"title":"More Than Just a Man: A History of the adidas Stan Smith"}
//    {"published_at":"2018-12-27T06:00:00.000Z"}
//    {"published":true}
//    {"hero":"https:\/\/d1qz9pzgo5wm5k.cloudfront.net\/api\/file\/aLUAO3LwTLG54NOxRIOV"}
//    {"listings":[]}
//    {"tag_list":["y-3","sneakers","stan-smith","phoebe-philo","pharrell-williams","raf-simons","adidas-originals","adidas"]}
//    {"franchise":"Master Class"}
//    {"slug":"adidas-stan-smith-history"}
//    {"author":"Stephen Albertini"}
//    {"content_type":"long"}
//    {"position":"feature"}
    var id: Int = 0
    var url: String = ""
    var title: String = ""
    var publishedAt: String = ""
    var published: Bool = false
    var hero: String = ""

    var listings: [String] = []
    var tagList: [String] = []

    var franchise: String = ""
    var slug: String = ""
    var author: String = ""
    var contentType: String = ""
    var position: String = ""

    init(json: JSON) {
        self.id = json["id"].intValue
        self.url = json["url"].stringValue
        self.title = json["title"].stringValue
        self.publishedAt = json["published_at"].stringValue
        self.published = json["published"].boolValue
        self.hero = json["hero"].stringValue

        if let listings = json["listings"].arrayObject as? [String] {
            self.listings = listings
        }

        self.franchise = json["franchise"].stringValue
        self.slug = json["slug"].stringValue
        self.author = json["author"].stringValue
        self.contentType = json["content_type"].stringValue
        self.position = json["position"].stringValue
    }

    var description: String {
        var description = ""
        description += "[id: \(self.id),\n"
        description += "title: \(self.title),\n"
        description += "url: \(self.url),\n"
        description += "author: \(self.author)]"
        return description
    }
}

extension Article: Equatable, Comparable {
    static func < (lhs: Article, rhs: Article) -> Bool {
        let lhsTime = TimeHelper.timeIntervalFor(timeString: lhs.publishedAt)
        let rhsTime = TimeHelper.timeIntervalFor(timeString: rhs.publishedAt)
        return lhsTime > rhsTime
    }

    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }
}
