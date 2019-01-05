//
//  CALayer.swift
//  GrailedTakeHome
//
//  Created by Sam on 1/5/18.
//  Copyright © 2019 Sam Huang. All rights reserved.
//

import UIKit
import QuartzCore

extension CALayer {
    func applyShadow(color: UIColor, alpha: Float, offset: CGSize, blur: CGFloat, spread: CGFloat) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = offset
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: thickness)
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }

        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }

    func addBorders(color: UIColor, width: CGFloat) {
        borderColor = color.cgColor
        borderWidth = width
    }

    func removeAllSublayers() {
        guard let sublayers = self.sublayers else { return }
        for layer in sublayers {
            layer.removeFromSuperlayer()
        }
    }
}
