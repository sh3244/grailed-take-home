//
//  ArticleCell.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/29/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import Stevia

class ArticleCell: UITableViewCell {

    var article: Article?

    lazy var heroView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .gray
        return view
    }()

    lazy var nameLabel: Label = {
        let label = Label(text: "", fontStyle: .normal, fontSize: 16, color: .white)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.rasterizationScale = UIScreen.main.scale
        label.layer.shouldRasterize = true
        return label
    }()

    lazy var dateLabel: Label = {
        let label = Label(text: "", fontStyle: .bold, fontSize: 16, color: .white)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.rasterizationScale = UIScreen.main.scale
        label.layer.shouldRasterize = true
        return label
    }()

    lazy var shadowLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.zPosition = -1

        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        return layer
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        clipsToBounds = true

        sv([
            heroView,
            nameLabel,
            dateLabel
            ])

        heroView.fillContainer()
        heroView.height(270)

        dateLabel.centerHorizontally()
        dateLabel.bottom(30)

        nameLabel.centerHorizontally()
        nameLabel.width(75%)
        nameLabel.Bottom == dateLabel.Top
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        heroView.layer.addSublayer(shadowLayer)
        let b = bounds
        shadowLayer.frame = CGRect(x: 0, y: b.maxY/2, width: b.width, height: b.height/2)
    }

    func set(article: Article) {
        self.article = article
        self.nameLabel.text = article.title

        self.dateLabel.text = TimeHelper.displayTimeFor(timeString: article.publishedAt)

        let screenWidth = UIScreen.main.bounds.width
        APIManager.fetchImageWith(url: article.hero, width: Int(screenWidth)).then { image -> Void in
            guard article == self.article else { return }
            DispatchQueue.main.async {
                self.heroView.image = image
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        heroView.image = nil
        nameLabel.text = ""
        dateLabel.text = ""
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
