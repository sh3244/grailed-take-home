//
//  ProductsViewController.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import Stevia
import PromiseKit
import Dwifft

// We cannot place these protocol methods in an extension due to compiler limitations
class ArticlesViewController: ReloadablePagedController<Article>, UITableViewDelegate, UITableViewDataSource {

    var diffCalculator: TableViewDiffCalculator<String, Article>?

    lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 100
        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension

        diffCalculator = TableViewDiffCalculator(tableView: tableView, initialSectionedValues: SectionedValues([("", [])]))
        diffCalculator?.insertionAnimation = .fade
        diffCalculator?.deletionAnimation = .fade

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        title = "Grailed Articles"

//        let barButtonImage = nonfavoriteImage
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: barButtonImage, style: .plain, target: self, action: #selector(rightBarButtonTapped))

        view.sv([
            tableView
            ])

        tableView.Top == view.safeAreaLayoutGuide.Top
//        tableView.Bottom == view.safeAreaLayoutGuide.Bottom
        tableView.bottom(0)
        tableView.fillHorizontally()
    }

//    override func reload() {
//        super.reload()
//    }

    override func loadPromise(reload: Bool) -> Promise<([Article], Pagination?)> {
//        return APIManager.fetch
//        return ChatAdapter.fetchChatMessages(chatID: chatID, before: (reload ? nil : self.lastItem?.message)).then { messages -> [MessageComponent] in
//            return messages.compactMap({ message -> MessageComponent? in
//                let component = MessageComponent(type: .message)
//                component.message = message
//                return component
//            })
//        }
    }

    override func doUpdate(_ items: [Article]) {
        self.diffCalculator?.sectionedValues = SectionedValues([("", self.items)])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let diffCalculator = self.diffCalculator else {
            return 0
        }
        return diffCalculator.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let diffCalculator = self.diffCalculator else {
            return 0
        }
        let count = diffCalculator.numberOfObjects(inSection: section)
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "")
        //        if let productCell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier) as? ProductCell {
        //            guard let diffCalculator = self.diffCalculator else { return productCell }
        //            let product = diffCalculator.value(atIndexPath: indexPath)
        //            productCell.set(product: product)
        //            return productCell
        //        }
        //        return ProductCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = diffCalculator?.value(atIndexPath: indexPath) else {
            return
        }

        //        let detailVC = DetailViewController()
        //        navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
//
//@objc enum FilterState: Int {
//    case favorite, none
//}
//
//class ProductsViewController: ViewController {
//    var diffCalculator: TableViewDiffCalculator<String, String>?
//
//    var filterState: FilterState = .none
////    var products: [Product] = []
//
//    let favoriteImage = UIImage(named: "heart")?.imageWith(size: CGSize(width: 28, height: 28)).imageWith(color: .red)
//    let nonfavoriteImage = UIImage(named: "heart")?.imageWith(size: CGSize(width: 28, height: 28)).imageWith(color: .black)
//
//    lazy var tableView: UITableView = {
//        let tableView = UITableView()
//
//        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.estimatedRowHeight = 100
//        tableView.separatorColor = .clear
//        tableView.rowHeight = UITableView.automaticDimension
//
//        diffCalculator = TableViewDiffCalculator(tableView: tableView, initialSectionedValues: SectionedValues([("", [])]))
//        diffCalculator?.insertionAnimation = .fade
//        diffCalculator?.deletionAnimation = .fade
//
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        title = "Juul Products"
//
//        let barButtonImage = nonfavoriteImage
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: barButtonImage, style: .plain, target: self, action: #selector(rightBarButtonTapped))
//
//        view.sv([
//            tableView
//            ])
//
//        tableView.Top == view.safeAreaLayoutGuide.Top
//        tableView.Bottom == view.safeAreaLayoutGuide.Bottom
//        tableView.fillHorizontally()
//
//        load()
//    }
//
//    func load() {
////        APIManager.fetchPodProducts().then { pods -> Void in
////            let filteredPods = pods.filter { return (self.filterState == .none) ? true : $0.isFavorite }
////            self.products = filteredPods as [Product]
////            self.diffCalculator?.sectionedValues = SectionedValues([("", self.products)])
////        }
//    }
//
//    @objc func rightBarButtonTapped() {
//        var barButtonImage = favoriteImage
//
//        switch self.filterState {
//        case .favorite:
//            self.filterState = .none
//            barButtonImage = nonfavoriteImage
//        case .none:
//            self.filterState = .favorite
//        }
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: barButtonImage, style: .plain, target: self, action: #selector(rightBarButtonTapped))
//
//        load()
//    }
//}
//
//extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        guard let diffCalculator = self.diffCalculator else {
//            return 0
//        }
//        return diffCalculator.numberOfSections()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let diffCalculator = self.diffCalculator else {
//            return 0
//        }
//        let count = diffCalculator.numberOfObjects(inSection: section)
//        return count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell(style: .default, reuseIdentifier: "")
////        if let productCell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier) as? ProductCell {
////            guard let diffCalculator = self.diffCalculator else { return productCell }
////            let product = diffCalculator.value(atIndexPath: indexPath)
////            productCell.set(product: product)
////            return productCell
////        }
////        return ProductCell()
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let product = diffCalculator?.value(atIndexPath: indexPath) else {
//            return
//        }
//
////        let detailVC = DetailViewController()
////        navigationController?.pushViewController(detailVC, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//}

