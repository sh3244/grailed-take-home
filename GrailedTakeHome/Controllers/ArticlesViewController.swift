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

        tableView.estimatedRowHeight = 270
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension

        diffCalculator = TableViewDiffCalculator(tableView: tableView, initialSectionedValues: SectionedValues([("", [])]))
        diffCalculator?.insertionAnimation = .fade
        diffCalculator?.deletionAnimation = .fade

        tableView.refreshControl = refreshControl

        return tableView
    }()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        title = "Grailed Articles"

        childRefreshControl = refreshControl

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Searches", style: .plain, target: self, action: #selector(rightTapped))

        view.sv([
            tableView
            ])

        tableView.Top == view.safeAreaLayoutGuide.Top
        tableView.Bottom == view.safeAreaLayoutGuide.Bottom
        tableView.fillHorizontally()

        load()
    }

    @objc func rightTapped() {
        let savedSearchesVC = SavedSearchesViewController()
        navigationController?.pushViewController(savedSearchesVC, animated: true)
    }

    override func loadPromise(reload: Bool) -> Promise<([Article], Pagination?)> {
        return APIManager.fetchArticles(pagination: (reload ? nil : pagination))
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
        if let articleCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseIdentifier, for: indexPath) as? ArticleCell {
            if let article = diffCalculator?.value(atIndexPath: indexPath) {
                articleCell.set(article: article)
                return articleCell
            }
        }
        return ArticleCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = diffCalculator?.value(atIndexPath: indexPath) else {
            return
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
