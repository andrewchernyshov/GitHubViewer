//
//  RepoListViewController.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/11/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import UIKit

class RepoListViewController: UIViewController {

    private let viewModel: RepoesListViewModel
    private let kCellIdentifier = "RepoCellIdentifier"
    private let kViewControllerTitle = "Repository list"

    @IBOutlet weak var tableView: UITableView!

    init(viewModel: RepoesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "RepoListViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = kViewControllerTitle
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension RepoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        if let repoName = viewModel.repoList[indexPath.row].name {
            cell.textLabel?.text = repoName
        }
        return cell
    }
}

extension RepoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
