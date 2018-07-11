//
//  Coordinator.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/11/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator, NewFlowHandler {
    var newFlowRequest: ((UINavigationController) -> Void)?
    private let presenter: UINavigationController
    private let networkManager: NetworkRequestHandler
    lazy private var childCoordinators = [Coordinator]()
    
    init(presenter: UINavigationController, networkManager: NetworkManager) {
        self.presenter = presenter
        self.networkManager = networkManager
    }
    
    func start() {
        let loginFlowCoordinator = LoginFlowCoordinator(presenter: presenter,
                                                        networkManager: networkManager,
                                                        loginOutputHandler: self)
        childCoordinators.append(loginFlowCoordinator)
        loginFlowCoordinator.start()
    }
    
    private func startRepoNavigationFlow(input: Data) {
        let repoListViewModel = RepoesListViewModel()
        repoListViewModel.updateModel(rawData: input)
        let controller = RepoListViewController(viewModel: repoListViewModel)
        newFlowRequest?(UINavigationController(rootViewController: controller))
        if !childCoordinators.isEmpty {
            childCoordinators.remove(at: (childCoordinators.count - 1))
        }
    }
}

extension AppCoordinator: LoginOutputHandler {
    func process(loginoutput: Data) {
        
        do {
            let repoURL = try JSONDecoder().decode(RepoURL.self, from: loginoutput)
            guard let stringURL = repoURL.repos_url else { return }
            
            networkManager.handle(request: .fetchRepos(stringURL)) { (result) in
                switch result {
                case .success(let data):
                    self.startRepoNavigationFlow(input: data)
                case .failure(let error):
                    print("AppCoordinator failed to parce repo list: \(error.localizedDescription)")
                }
            }
            
        } catch let error {
            print("AppCoordinator failed to parce input: \(error.localizedDescription)")
            fatalError()
        }
    }
}
