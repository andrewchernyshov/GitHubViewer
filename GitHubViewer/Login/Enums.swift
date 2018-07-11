//
//  LoginOutputHandler.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/11/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import Foundation

enum LoginOutputProcessingResult {
    case success
    case failure(Error)
}

enum RequestType {
    case fetchRepos(String)
    case setupConnections(RequestHandlerModel)
}

enum NetworkRequestResult {
    case success(Data)
    case failure(Error)
}
