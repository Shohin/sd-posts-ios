//
//  PostListController.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import UIKit

final public class PostListController: TemplateListController, UITableViewDataSource, UITableViewDelegate {
    private let refreshControl = UIRefreshControl()
    private let tableView: UITableView = UITableView()
    private let newPostsButton: UIButton = UIButton()
    private let emptyView: CEmptyView = CEmptyView()
    private let reloadView: CReloadView = CReloadView()
    
    public var presenter: PostListPresenter!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Posts"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(clearAction))
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50
        self.view.addSubview(self.tableView)
        
        self.reloadView.title = "Ooops,something is\nwrong. Please, try again"
        self.reloadView.reload = {
            self.reloadView.removeFromSuperview()
            self.navigationController?.navigationBar.isHidden = false
            self.load()
        }
        self.view.addSubview(self.reloadView)
        
        self.emptyView.isHidden = true
        self.emptyView.text = "No posts yet"
        self.view.addSubview(self.emptyView)
        
        self.newPostsButton.addTarget(self, action: #selector(newPostsAction), for: .touchUpInside)
        self.newPostsButton.setTitleColor(UIColor.black, for: .normal)
        self.newPostsButton.layer.cornerRadius = 5
        self.newPostsButton.clipsToBounds = true
        self.newPostsButton.layer.borderWidth = 1
        self.newPostsButton.layer.borderColor = UIColor.gray.cgColor
        self.newPostsButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.newPostsButton.backgroundColor = UIColor.white
        self.view.addSubview(self.newPostsButton)
        
        self.hideNewPostsButton()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let topArea = self.view.safeAreaInsets.top
        let size = self.view.frame.size
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = size.width
        var h: CGFloat = size.height - y
        self.tableView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = 90
        h = 30
        x = (size.width - w) / 2
        y = topArea + 10
        self.newPostsButton.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = 0
        y = 0
        w = size.width
        h = size.height
        self.reloadView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = 0
        y = 0
        w = size.width
        h = size.height
        self.emptyView.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    private func hideNewPostsButton() {
        self.newPostsButton.isHidden = true
    }
    
    private func showNewPostsButton() {
        self.newPostsButton.isHidden = false
    }
    
    private func clear() {
        self.hideNewPostsButton()
        self.presenter.clear {
            self.reload()
        }
    }
    
    private func load() {
        self.presenter.load {
            self.reload()
            self.presenter.inserEverySecond(completion: { (newCnt) in
                self.newPostsButton.setTitle("\(newCnt) new posts", for: .normal)
                self.showNewPostsButton()
            })
        }
    }
    
    private func loadNext() {
        self.presenter.loadNext {
            self.reload()
        }
    }
    
    private func reload() {
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
        
        self.emptyView.isHidden = self.presenter.isFull
    }
    
    private func loadNewPosts() {
        self.hideNewPostsButton()
        self.presenter.loadNew {
            self.reload()
            //scroll to top
            self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    //MARK: actions
    @objc
    private func clearAction() {
        self.clear()
    }
    
    @objc
    private func newPostsAction() {
        self.loadNewPosts()
    }
    
    @objc
    private func pullToRefreshAction() {
        self.loadNewPosts()
    }
    
    //MARK: tableview data source
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.itemsCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if self.presenter.canShowLoadMoreCell(index: row) {
            let loadingReuseCellId = String(describing: CLoadMoreDataTableViewCell.self)
            var cell = tableView.dequeueReusableCell(withIdentifier: loadingReuseCellId) as? CLoadMoreDataTableViewCell
            if cell == nil {
                cell = CLoadMoreDataTableViewCell(reuseIdentifier: loadingReuseCellId)
            }
            cell?.startAnimating()
            self.loadNext()
            return cell!
        }

        let reuseCellId = String(describing: PostTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseCellId) as? PostTableViewCell
        if cell == nil {
            cell = PostTableViewCell(reuseIdentifier: reuseCellId)
        }

        let item = self.presenter.item(at: indexPath.row)
        cell?.populate(with: item, indexPath: indexPath)
        return cell!
        
    }
    
    //MARK: tableview delegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
