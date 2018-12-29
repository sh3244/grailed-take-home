//
//  UITableViewCell.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
