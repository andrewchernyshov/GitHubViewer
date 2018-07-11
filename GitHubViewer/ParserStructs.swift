//
//  ParserStructs.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/11/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import Foundation

struct RepoURL: Decodable {
    var repos_url: String?
}

struct Repo: Decodable {
    var name: String?
    var url: String?
}
