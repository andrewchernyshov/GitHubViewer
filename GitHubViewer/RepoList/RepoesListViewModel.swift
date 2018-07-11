//
//  RepoesListViewModel.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/11/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import Foundation

class RepoesListViewModel {

    private let logTag = "RepoesListViewModel"
    lazy var repoList = [Repo] ()

    func updateModel(rawData: Data) {
        do {
            self.repoList = try JSONDecoder().decode([Repo].self, from: rawData)
        } catch let error {
            print(logTag + ": \(error.localizedDescription)")
            fatalError()
        }
    }
}
