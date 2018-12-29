//
//  FileManager.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//
//  Say we wanted to persist a large amount of data, we could use serialized file stores/cache directories

//import Foundation

//private var cachesDirectory: NSString {
//    return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last! as NSString
//}
//
//public let cacheDir = cachesDirectory.appendingPathComponent("cache")
//public let cacheDirURL = URL(fileURLWithPath: cacheDir)
//
//public let homeCachedURL = cacheDirURL.appendingPathComponent("home").appendingPathExtension("json")
//
//public extension FileManager {
//
//    public func createTempDirectories() {
//        [cacheDir].forEach {
//            do {
//                try FileManager.default.createDirectory(
//                    atPath: $0,
//                    withIntermediateDirectories: true,
//                    attributes: nil
//                )
//            } catch let error {
//                print(error)
//            }
//        }
//    }
//
//    public func clearCacheDirectory() {
//        do {
//            try clearContentsOfDirectory(atPath: cacheDir)
//        } catch let error {
//            print(error)
//        }
//    }
//
//    public func clearContentsOfDirectory(atPath: String) throws {
//        let contents = try contentsOfDirectory(atPath: atPath)
//        try contents.forEach {
//            try removeItem(atPath: "\(atPath)/\($0)")
//        }
//    }
//
//    public class func deleteFileIfExists(url: URL?) {
//        let manager = FileManager.default
//        guard let deleteURL = url else { return }
//
//        guard manager.fileExists(atPath: deleteURL.path) else { return }
//        do {
//            try manager.removeItem(at: deleteURL)
//        } catch let error {
//            print(error)
//        }
//    }
//
//    func enumerateContentsOfDirectory(atPath path: String, orderedByProperty property: String, ascending: Bool, usingBlock block: (URL, Int, inout Bool) -> Void ) {
//
//        let directoryURL = URL(fileURLWithPath: path)
//        do {
//            let contents = try self.contentsOfDirectory(at: directoryURL,
//                                                        includingPropertiesForKeys: [URLResourceKey(rawValue: property)],
//                                                        options: FileManager.DirectoryEnumerationOptions())
//            let sortedContents = contents.sorted(by: {(URL1: URL, URL2: URL) -> Bool in
//
//                // Maybe there's a better way to do this. See: http://stackoverflow.com/questions/25502914/comparing-anyobject-in-swift
//
//                var value1: AnyObject?
//                do {
//                    try (URL1 as NSURL).getResourceValue(&value1, forKey: URLResourceKey(rawValue: property))
//                } catch {
//                    return true
//                }
//                var value2: AnyObject?
//                do {
//                    try (URL2 as NSURL).getResourceValue(&value2, forKey: URLResourceKey(rawValue: property))
//                } catch {
//                    return false
//                }
//
//                if let string1 = value1 as? String, let string2 = value2 as? String {
//                    return ascending ? string1 < string2: string2 < string1
//                }
//
//                if let date1 = value1 as? Date, let date2 = value2 as? Date {
//                    return ascending ? date1 < date2: date2 < date1
//                }
//
//                if let number1 = value1 as? NSNumber, let number2 = value2 as? NSNumber {
//                    return ascending ? number1.intValue < number2.intValue: number2.intValue < number1.intValue
//                }
//
//                return false
//            })
//
//            for (idx, value) in sortedContents.enumerated() {
//                var stop: Bool = false
//                block(value, idx, &stop)
//                if stop { break }
//            }
//
//        } catch let error {
//            print(error)
//        }
//    }
//}
