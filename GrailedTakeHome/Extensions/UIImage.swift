//
//  UIImage.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import UIKit
//import AVFoundation

extension UIImage {

    func imageWith(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return self
        }

        UIGraphicsEndImageContext()

        return newImage.withRenderingMode(.alwaysOriginal)
    }

    func imageWith(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.draw(in: rect)
        color.setFill()
        UIRectFillUsingBlendMode(rect, CGBlendMode.sourceAtop)

        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return self
        }

        UIGraphicsEndImageContext()

        return newImage.withRenderingMode(.alwaysOriginal)
    }

    func roundedImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)

        let bounds = CGRect(origin: .zero, size: self.size)
        UIBezierPath(roundedRect: bounds, cornerRadius: self.size.width/2).addClip()
        self.draw(in: bounds)

        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return self
        }

        UIGraphicsEndImageContext()

        return newImage
    }

    class func colorImageFrom(color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        defer {
            UIGraphicsEndImageContext()
        }

        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }

//    class func generateImageFromVideo(url: URL) -> UIImage? {
//        do {
//            let asset = AVURLAsset(url: url)
//            let imageGenerator = AVAssetImageGenerator(asset: asset)
//            imageGenerator.appliesPreferredTrackTransform = true
//            let cgImage = try imageGenerator.copyCGImage(at: kCMTimeZero, actualTime: nil)
//
//            return UIImage(cgImage: cgImage)
//        } catch {
//            print(error.localizedDescription)
//
//            return nil
//        }
//    }
}
