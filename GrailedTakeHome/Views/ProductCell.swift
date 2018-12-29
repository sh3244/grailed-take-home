//
//  ProductCell.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import Stevia

//thumbnail, name, and price, and a Favorite button

class ProductCell: UITableViewCell {
//    var product: Product?

    lazy var thumbnailView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    lazy var nameLabel: Label = {
        let label = Label(text: "", fontStyle: .normal, fontSize: 14, color: .black)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    lazy var priceLabel: Label = {
        let label = Label(text: "", fontStyle: .normal, fontSize: 14, color: .black)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    lazy var favoriteButton: Button = {
        let button = Button(image: UIImage(named: "heart"),
                            normalColor: .black,
                            selectedColor: .gray,
                            highlightedColor: .gray)
        button.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        sv([
            thumbnailView,
            nameLabel,
            priceLabel,
            favoriteButton
            ])

        thumbnailView.size(50).left(10).top(10).bottom(10)

        nameLabel.Left == thumbnailView.Right + 10
        nameLabel.top(10).right(50)

        priceLabel.Left == thumbnailView.Right + 10
        priceLabel.Top == nameLabel.Bottom + 10
        priceLabel.right(50)

        favoriteButton.right(10).size(30).centerVertically()
    }

    @objc func favoriteTapped() {
//        guard let product = self.product else { return }
//        if product.isFavorite {
//            ProductDefaults.removeFavoriteID(product.id)
//            favoriteButton.setImage(image: UIImage(named: "heart"), normalColor: .black, selectedColor: .gray, highlightedColor: .gray)
//        } else {
//            ProductDefaults.addFavoriteID(product.id)
//            favoriteButton.setImage(image: UIImage(named: "heart"), normalColor: .red, selectedColor: .gray, highlightedColor: .gray)
//        }
    }

//    func set(product: Product) {
//        self.product = product
//
//        nameLabel.text = product.name
//
//        priceLabel.text = StringManager.centsValueToString(product.price)
//
//        if !product.isFavorite {
//            favoriteButton.setImage(image: UIImage(named: "heart"), normalColor: .black, selectedColor: .gray, highlightedColor: .gray)
//        } else {
//            favoriteButton.setImage(image: UIImage(named: "heart"), normalColor: .red, selectedColor: .gray, highlightedColor: .gray)
//        }
//
//        APIManager.fetchImageWith(url: product.thumbnailURL).then { image -> Void in
//            self.thumbnailView.image = image
//        }
//    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
