//
//  Product.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import SwiftyJSON

class Product: CustomStringConvertible {
    //    "id": "6e02aa3c43554ca896dc4ce6890f890e",
    //    "name": "cool mint",
    //    "description": "Crisp peppermint with a soothing aftertaste.",
    //    "price": 185,
    //    "thumbnail_url": "https://s3.us-east-2.amazonaws.com/juul-coding-challenge/images/mint_thumbnail.png",
    //    "image_url": "https://s3.us-east-2.amazonaws.com/juul-coding-challenge/images/mint_hires.png"
    var id = ""
    var name = ""
    var productDescription = ""
    var price = 0
    var thumbnailURL = ""
    var imageURL = ""

    var isFavorite: Bool {
        return ProductDefaults.isFavorite(id)
    }

    init(json: JSON) {
        self.id = json["id"].string ?? ""
        self.name = json["name"].string ?? ""
        self.productDescription = json["description"].string ?? ""
        self.price = json["price"].int ?? 0
        self.thumbnailURL = json["thumbnail_url"].string ?? ""
        self.imageURL = json["image_url"].string ?? ""
    }

    var description: String {
        var description = ""
        description += "[name: \(self.name),\n"
        description += "description: \(self.productDescription),\n"
        description += "id: \(self.id),\n"
        description += "price: \(self.price)]"
        return description
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
}

class Pod: Product {

}
