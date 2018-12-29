//
//  UserDefaults.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//
//  Manage our persistence via a dedicated class

import Foundation

class ProductDefaults {
    static let shared = ProductDefaults()
    let defaults = UserDefaults.standard

    class func isFavorite(_ id: String) -> Bool {
        return fetchFavoriteIDs().contains { $0 == id }
    }

    class func fetchFavoriteIDs() -> [String] {
        if let object = shared.defaults.object(forKey: "favoriteIDs") {
            if let IDs = object as? [String] {
                return IDs
            }
        }
        return []
    }

    class func addFavoriteID(_ id: String) {
        var favorites = fetchFavoriteIDs()
        favorites.append(id)
        shared.defaults.set(favorites, forKey: "favoriteIDs")
    }

    class func removeFavoriteID(_ id: String) {
        var favorites = fetchFavoriteIDs()
        favorites.removeAll { $0 == id }
        shared.defaults.set(favorites, forKey: "favoriteIDs")
    }
}
