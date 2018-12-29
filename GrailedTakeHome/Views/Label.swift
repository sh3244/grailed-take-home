//
//  Label.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import UIKit

@objc enum FontStyle: Int {
    case normal, light, bold
}

class Label: UILabel {

    var customInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    convenience init(text: String = "", fontStyle: FontStyle = .normal, fontSize: CGFloat = 12, color: UIColor = .white) {
        self.init(text: text, fontStyle: fontStyle, fontSize: fontSize, color: color, .clear, 0)
    }

    convenience init(text: String = "", fontStyle: FontStyle = .normal, fontSize: CGFloat = 12,
                     color: UIColor = .white, _ backgroundColor: UIColor = .clear, _ cornerRadius: CGFloat = 0) {
        self.init(frame: .zero)

        self.text = text
        self.backgroundColor = backgroundColor
        self.textColor = color
        self.layer.cornerRadius = cornerRadius

        switch fontStyle {
        case .light:
            self.font = UIFont.systemFont(ofSize: fontSize)
        case .bold:
            self.font = UIFont.boldSystemFont(ofSize: fontSize)
        default:
            self.font = UIFont.systemFont(ofSize: fontSize)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        textAlignment = .center
        textColor = .white

        layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: customInsets))
    }

}
