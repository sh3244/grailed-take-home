//
//  DetailViewController.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import Stevia
import Alamofire

//hi-res JUUL image, description, price, and the name of the product

class DetailViewController: ViewController {
//    var product: Product?

    lazy var imageView: UIImageView = {
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

    lazy var descriptionLabel: Label = {
        let label = Label(text: "", fontStyle: .normal, fontSize: 14, color: .black)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Product Detail"

        view.sv([
            imageView,
            nameLabel,
            descriptionLabel,
            priceLabel
            ])

        imageView.Top == view.safeAreaLayoutGuide.Top + 10
        imageView.fillHorizontally(m: 10)
        imageView.heightEqualsWidth()

        nameLabel.Top == imageView.Bottom + 10
        nameLabel.fillHorizontally(m: 10)

        descriptionLabel.Top == nameLabel.Bottom + 10
        descriptionLabel.fillHorizontally(m: 10)

        priceLabel.Top == descriptionLabel.Bottom + 10
        priceLabel.fillHorizontally(m: 10)
    }

//    init(product: Product) {
//        super.init(nibName: nil, bundle: nil)
//        set(product: product)
//    }
//
//    func set(product: Product) {
//        self.product = product
//
//        nameLabel.text = product.name
//
//        descriptionLabel.text = product.productDescription
//
//        priceLabel.text = StringManager.centsValueToString(product.price)
//
//        APIManager.fetchImageWith(url: product.imageURL).then { image -> Void in
//            self.imageView.image = image
//        }
//    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
