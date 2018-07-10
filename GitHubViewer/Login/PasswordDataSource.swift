//
//  PasswordDataSource.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/10/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import Foundation

class PasswordDataSource: LoginViewModel {
    var loginFieldDescription: String {
        return "Username or email address"
    }
    
    var passwordFieldDescription: String {
        return "Password"
    }
    
    func process(input: String) {
        print(input)
    }
}
