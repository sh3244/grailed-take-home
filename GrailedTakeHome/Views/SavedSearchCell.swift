//
//  SavedSearchCell.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/29/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import Stevia

class SavedSearchCell: UITableViewCell {

    var savedSearch: SavedSearch?

    lazy var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .gray
        return view
    }()

    lazy var nameLabel: Label = {
        let label = Label(text: "", fontStyle: .normal, fontSize: 16, color: .black)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.rasterizationScale = UIScreen.main.scale
        label.layer.shouldRasterize = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        clipsToBounds = true

        sv([
            thumbnailImageView,
            nameLabel
            ])

        thumbnailImageView.fillVertically(m: 10)
        thumbnailImageView.size(40).left(20)

        nameLabel.centerVertically()
        nameLabel.Left == thumbnailImageView.Right + 10
        nameLabel.right(20)
    }

    func set(savedSearch: SavedSearch) {
        self.savedSearch = savedSearch

        // Set search title to query/name
//        self.nameLabel.text = savedSearch.search?.query
//        if self.nameLabel.text?.isEmpty ?? false {
            self.nameLabel.text = savedSearch.name
//        }

        APIManager.fetchImageWith(url: savedSearch.imageURL, width: 80).then { image -> Void in
            guard savedSearch == self.savedSearch else { return }
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = ""
        thumbnailImageView.image = nil
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
