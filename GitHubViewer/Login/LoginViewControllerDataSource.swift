//
//  PasswordDataSource.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/10/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import Foundation

class LoginViewControllerDataSource: LoginViewModel {
    
    private let outputHandler: OutputHandler
    
    init(outputHandler: OutputHandler) {
        self.outputHandler = outputHandler
    }
    
    var loginFieldDescription: String {
        return "Username or email address"
    }
    
    var passwordFieldDescription: String {
        return "Password"
    }
    
    func process(login: String, password: String, completion: @escaping (LoginOutputProcessingResult) -> Void) {
        outputHandler.process(outPut: LoginDataItem(username: login, userPassword: password)) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success:
                completion(.success)
            }
        }
    }
}
