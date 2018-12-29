//
//  SavedSearchesViewController.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/29/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import Stevia
import Dwifft
import PromiseKit

class SavedSearchesViewController: ReloadablePagedController<SavedSearch>, UITableViewDelegate, UITableViewDataSource {

    var diffCalculator: TableViewDiffCalculator<String, SavedSearch>?

    lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(SavedSearchCell.self, forCellReuseIdentifier: SavedSearchCell.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 100
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

        title = "Saved Searches"

        childRefreshControl = refreshControl

        view.sv([
            tableView
            ])

        tableView.Top == view.safeAreaLayoutGuide.Top
        //        tableView.Bottom == view.safeAreaLayoutGuide.Bottom
        tableView.bottom(0)
        tableView.fillHorizontally()

        load()
    }

    override func loadPromise(reload: Bool) -> Promise<([SavedSearch], Pagination?)> {
        return APIManager.fetchSavedSearches().then { searches -> Promise<([SavedSearch], Pagination?)> in
            return Promise(value: (searches, nil))
        }
    }

    override func doUpdate(_ items: [SavedSearch]) {
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
        if let savedSearchCell = tableView.dequeueReusableCell(withIdentifier: SavedSearchCell.reuseIdentifier, for: indexPath) as? SavedSearchCell {
            if let savedSearch = diffCalculator?.value(atIndexPath: indexPath) {
                savedSearchCell.set(savedSearch: savedSearch)
                return savedSearchCell
            }
        }
        return SavedSearchCell()
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
