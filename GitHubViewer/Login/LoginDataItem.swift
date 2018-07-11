//
//  LoginDataItem.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/11/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import Foundation

class LoginDataItem: RequestHandlerModel {
    var username: String
    var userPassword: String
    
    init(username: String, userPassword: String) {
        self.username = username
        self.userPassword = userPassword
    }
}
