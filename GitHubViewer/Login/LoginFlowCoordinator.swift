//
//  LoginCoordinator.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/11/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import UIKit

class LoginFlowCoordinator: Coordinator {
    fileprivate let presenter: UINavigationController
    fileprivate let networkManager: NetworkRequestHandler
    fileprivate let loginOutputHandler: LoginOutputHandler
    
    var viewController: UIViewController?
    
    init(presenter: UINavigationController,
         networkManager: NetworkRequestHandler,
         loginOutputHandler: LoginOutputHandler) {
        
        self.presenter = presenter
        self.networkManager = networkManager
        self.loginOutputHandler = loginOutputHandler
    }
    
    func start() {
        let dataSource = LoginViewControllerDataSource(outputHandler: self)
        let controller = LoginViewController(viewModel: dataSource)
        viewController = controller
        presenter.pushViewController(controller, animated: true)
    }
}

extension LoginFlowCoordinator: OutputHandler {
    func process(outPut: RequestHandlerModel, completion: @escaping (LoginOutputProcessingResult) -> Void) {
        networkManager.login(userData: outPut) { [weak self] (networkResponse) in
            switch networkResponse {
            case .success(let data):
                self?.loginOutputHandler.process(loginoutput: data)
                print("data loaded: \(data)")
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
