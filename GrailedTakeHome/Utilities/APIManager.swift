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

    let baseURL = "https://www.grailed.com/api/"

    public init() {
        let timeout: Double = 10
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.timeoutIntervalForResource = timeout
        manager = Alamofire.SessionManager(configuration: configuration)
    }

    class func fetchImageWith(url: String) -> Promise<UIImage> {
        return Promise { fulfill, reject in
            Alamofire.request(url).responseImage { response in
                if let image = response.result.value {
                    fulfill(image)
                }
            }
        }
    }

//    class func fetchArticles(pagination: Pagination)

//    class func fetchPodProducts() -> Promise<[Product]> {
//        return APIManager.shared.get(url: "https://s3.us-east-2.amazonaws.com/juul-coding-challenge/products.json").then { response -> [Product] in
//            guard let pods = response["pods"].array else {
//                throw APIError.emptyResponse
//            }
//            return pods.compactMap({ json -> Product? in
//                return Product(json: json)
//            })
//        }
//    }

    public func get(url: String, parameters: [String: Any]? = nil) -> Promise<JSON> {
        //        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        let encoding: ParameterEncoding = JSONEncoding.default
        let url = URL(string: url)
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
