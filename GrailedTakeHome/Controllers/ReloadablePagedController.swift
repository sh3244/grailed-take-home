//
//  ReloadablePagedController.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/29/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import Stevia
import PromiseKit

enum ReloadablePagedControllerState {
    case empty, loading, loaded, paging, finished
    case reloading // This has been added to support wet reloading for no-internet-access

    case initial

    static var allStates: [ReloadablePagedControllerState] = [empty, loading, loaded, paging, finished, initial, reloading]

    /// self == .empty
    var isLoadable: Bool {
        return self == .empty
    }

    /// self == .loaded
    var isPageable: Bool {
        return self == .loaded
    }

    /// self == .empty || self == .loaded || self == .finished
    var isReloadable: Bool {
        return self == .empty || self == .loaded || self == .finished
    }

    /// self == .loading || self == .paging
    var isUpdateable: Bool {
        return self == .loading || self == .paging
    }
}

class ReloadablePagedController<T: Any>: ViewController, UIScrollViewDelegate {
    var state: ReloadablePagedControllerState = .empty

//    var isReversed: Bool = false
    /// Determines whether reloading allows empty results...
    var allowsEmpty: Bool = false

    var items: [T] = []
    var pagination: Pagination?

    var childRefreshControl: UIRefreshControl?

    lazy var loadMoreThrottled = throttle(milliseconds: 1000, queue: DispatchQueue.main) { [weak self] in
        self?.load()
    }

    /// Contained callback method to load/page/reload
    func loadPromise(reload: Bool) -> Promise<([T], Pagination?)> {
        return Promise(value: ([], nil))
    }

    func load() {
        if state == .empty || state == .loaded {
            state = .loading
            loadPromise(reload: false).then { items, pagination in
                self.update(items: items, pagination: pagination)
                }.catch { _ in
                    self.update(items: [], pagination: nil) // Will update with nothing if errored
            }
        }
    }

    /// Contained callback method to update views
    func doUpdate(_ items: [T]) {
        assert(false, "required abstract method not implemented")
    }

    func update(items: [T], pagination: Pagination?) {
        if state == .loading || state == .paging {
            if items.isEmpty {
                state = .finished
                return
            }

            if !self.items.isEmpty {
                self.items.append(contentsOf: items)
            } else {
                self.items = items
            }

            doUpdate(self.items)

            state = .loaded
        } else if state == .reloading {
            if items.isEmpty && !allowsEmpty {
                state = .loaded
                return
            }

            self.items = items

            doUpdate(self.items)

            state = .loaded
        }

        self.pagination = pagination
    }

    func reloadPromise() -> Promise<[T]> {
        return Promise(value: [])
    }

    @objc func reload() {
        if state.isReloadable {
            state = .reloading

            loadPromise(reload: true).then { items, pagination in
                self.update(items: items, pagination: pagination)
                }.catch { _ in
                    self.update(items: [], pagination: nil)
                }.always {
                    self.endRefreshing()
            }
        } else {
            self.endRefreshing()
        }
    }

    // Using asyncAfter + viewWillAppear because UIRefreshControl will not stop refreshing if tabs are switched
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.childRefreshControl?.beginRefreshing()
        self.endRefreshing()
    }

    func endRefreshing() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            if self?.childRefreshControl?.isRefreshing == true {
                self?.childRefreshControl?.endRefreshing()
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UITableView || scrollView is UICollectionView else { return }
        let distanceToBottom = (scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.bounds.height)
        if distanceToBottom < 500 {
            loadMoreThrottled()
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
