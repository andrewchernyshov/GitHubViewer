//
//  Protocols.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/11/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import UIKit

protocol RequestHandlerModel {
    var username: String { get }
    var userPassword: String { get }
}

protocol NetworkRequestHandler {
    func login(userData: RequestHandlerModel, completion: @escaping (NetworkRequestResult)->())
    func handle(request: RequestType, completion: @escaping (NetworkRequestResult)->())
}

protocol OutputHandler {
    func process(outPut: RequestHandlerModel, completion: @escaping (LoginOutputProcessingResult)->Void)
}

protocol LoginOutputHandler {
    func process(loginoutput: Data)
}
protocol Coordinator {
    func start()
}

protocol NewFlowHandler {
    var newFlowRequest: ((_ presenter: UINavigationController) -> Void)? { get set }
}

protocol LoginViewModel {
    var loginFieldDescription: String { get }
    var passwordFieldDescription: String { get }
    func process(login: String, password: String, completion: @escaping (LoginOutputProcessingResult) -> Void)
}
