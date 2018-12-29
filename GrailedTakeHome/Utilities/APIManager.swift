//
//  APIManager.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//
//  Wrap all our networking calls to separate error handling

import Alamofire
import AlamofireImage
import PromiseKit
import SwiftyJSON

enum APIError: Error {
    case emptyResponse
    case general
}

class APIManager {

    static let shared = APIManager()

    public var manager: SessionManager

    let baseURL = "https://www.grailed.com"

    public init() {
        let timeout: Double = 10
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.timeoutIntervalForResource = timeout
        manager = Alamofire.SessionManager(configuration: configuration)
    }

    class func fetchImageWith(url: String, width: Int?) -> Promise<UIImage> {
        var url = url
        // Grailed specific CDN resize override
        if let width = width {
            url = "https://cdn.fs.grailed.com/AJdAgnqCST4iPtnUxiGtTz/rotate=deg:exif/rotate=deg:0/resize=width:\(String(width)),fit:crop/output=format:jpg,compress:true,quality:95/" + url
        }
        return Promise { fulfill, reject in
            Alamofire.request(url).responseImage { response in
                if let image = response.result.value {
                    fulfill(image)
                }
            }
        }
    }

    class func fetchArticles(pagination: Pagination?) -> Promise<([Article], Pagination?)> {
        var path = "/api/articles/ios_index"
        if let nextPage = pagination?.nextPage {
            path = nextPage
        }
        return APIManager.shared.get(path).then { response -> ([Article], Pagination?) in
            guard let articles = response["data"].array else {
                throw APIError.emptyResponse
            }
            return (articles.compactMap { return Article(json: $0) }, Pagination(json: response["metadata"]["pagination"]))
        }
    }

    class func fetchSavedSearches() -> Promise<[SavedSearch]> {
        return APIManager.shared.get("/api/merchandise/marquee").then { response -> [SavedSearch] in
            guard let searches = response["data"].array else {
                throw APIError.emptyResponse
            }
            return searches.compactMap { SavedSearch(json: $0) }
        }
    }

    public func get(_ path: String, parameters: [String: Any]? = nil) -> Promise<JSON> {
        //        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        let encoding: ParameterEncoding = JSONEncoding.default
        let url = URL(string: baseURL + path)
        guard let path = url else { return Promise(error: APIError.general) }
        return Promise { fulfill, reject in
            self.manager.request(path, method: .get, parameters: parameters, encoding: encoding)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            fulfill(json)
                        }
                    case .failure(let error):
                        let _ = response.response?.statusCode ?? 0
                        reject(error)
                    }
            }
        }
    }
}
