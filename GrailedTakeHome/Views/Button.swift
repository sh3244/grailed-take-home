//
//  Button.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import UIKit

class Button: UIButton {
    var storedBorderColor: UIColor?
    var storedBorderColorHighlighted: UIColor?
    var storedBorderColorDisabled: UIColor?
    var storedBackgroundColor: UIColor?
    var storedBackgroundColorHighlighted: UIColor?
    var storedBackgroundColorDisabled: UIColor?

    /// Set this to true to round the button (based on height)
    var isRound = false

    /// Set this to true to auto shade the button on state change (for multicolor icons)
    var dimsOnHighlight = false
    var dimsWhenDisabled = false
    var dimAlpha: CGFloat = 0.6

    /// Makes a button with different icon in different states
    convenience init(normalImage: UIImage?, highlightedImage: UIImage?) {
        self.init(frame: .zero)
        imageView?.contentMode = .scaleAspectFit

        setImage(normalImage, for: .normal)
        setImage(highlightedImage, for: .highlighted)
    }

    /// Makes a button that colors a template icon
    convenience init(image: UIImage?, normalColor: UIColor, selectedColor: UIColor, highlightedColor: UIColor) {
        self.init(frame: .zero)
        imageView?.contentMode = .scaleAspectFit

        setImage(image: image, normalColor: normalColor, selectedColor: selectedColor, highlightedColor: highlightedColor)
    }

    func setImage(image: UIImage?, normalColor: UIColor, selectedColor: UIColor, highlightedColor: UIColor) {
        let normalImage = image?.withRenderingMode(.alwaysTemplate).imageWith(color: normalColor)
        setImage(normalImage, for: .normal)
        let selectedImage = image?.withRenderingMode(.alwaysTemplate).imageWith(color: selectedColor)
        setImage(selectedImage, for: .selected)
        let highlightedImage = image?.withRenderingMode(.alwaysTemplate).imageWith(color: highlightedColor)
        setImage(highlightedImage, for: .highlighted)
    }

    convenience init(message: String, color: UIColor = .white, textColor: UIColor = .white, size: CGFloat = 16) {
        self.init(frame: .zero)
        setBackgroundColors(color, highlighted: .gray)

        setTitleColor(textColor, for: .normal)
        setTitle(message, for: .normal)

        layer.cornerRadius = 5
        clipsToBounds = true
        titleLabel?.font = UIFont.systemFont(ofSize: size)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        if isRound {
            layer.cornerRadius = bounds.height/2
        }
        super.layoutSubviews()
    }

    func setTitle(_ normal: String, highlighted: String = "") {
        setTitle(normal, for: .normal)
        setTitle(highlighted, for: .highlighted)
    }

    func setBackgroundColors(_ normal: UIColor, highlighted: UIColor? = nil, disabled: UIColor? = nil) {
        backgroundColor = normal
        storedBackgroundColor = normal
        storedBackgroundColorHighlighted = highlighted ?? normal
        storedBackgroundColorDisabled = disabled ?? normal
    }

    func setTextColors(_ normal: UIColor, highlighted: UIColor? = nil, disabled: UIColor? = nil) {
        setTitleColor(normal, for: .normal)
        setTitleColor(highlighted ?? normal, for: .highlighted)
        setTitleColor(disabled ?? normal, for: .disabled)
    }

    func setBorderColors(_ normal: UIColor, highlighted: UIColor? = nil, disabled: UIColor? = nil) {
        layer.borderColor = normal.cgColor
        storedBorderColor = normal
        storedBorderColorHighlighted = highlighted ?? normal
        storedBorderColorDisabled = disabled ?? normal
    }

    override open var isEnabled: Bool {
        didSet {
            switch isEnabled {
            case true:
                if dimsWhenDisabled {
                    self.alpha = 1
                }
                if let borderColor = storedBorderColor {
                    layer.borderColor = borderColor.cgColor
                }
                if let backgroundColor = storedBackgroundColor {
                    self.backgroundColor = backgroundColor
                }
            case false:
                if dimsWhenDisabled {
                    self.alpha = dimAlpha
                }
                if let borderColor = storedBorderColorDisabled {
                    layer.borderColor = borderColor.cgColor
                }
                if let backgroundColor = storedBackgroundColorDisabled {
                    self.backgroundColor = backgroundColor
                }
            }
        }
    }

    override open var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                if let borderColor = storedBorderColorHighlighted {
                    layer.borderColor = borderColor.cgColor
                }
                if let backgroundColor = storedBackgroundColorHighlighted {
                    self.backgroundColor = backgroundColor
                }
                if dimsOnHighlight {
                    self.alpha = dimAlpha
                }
            case false:
                if dimsOnHighlight {
                    self.alpha = 1
                }
                if let borderColor = storedBorderColor {
                    layer.borderColor = borderColor.cgColor
                }
                if let backgroundColor = storedBackgroundColor {
                    self.backgroundColor = backgroundColor
                }
            }
        }
    }
}
