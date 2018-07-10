//
//  LoginViewModel.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/10/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import Foundation

protocol LoginViewModel {
    var loginFieldDescription: String { get }
    var passwordFieldDescription: String { get }
    func process(input: String)
}
