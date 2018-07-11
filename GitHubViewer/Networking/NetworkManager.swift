//
//  NetworkManager.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/11/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import Foundation

class NetworkManager: NetworkRequestHandler {

    private let loginURLString = "https://api.github.com/user"

    private let logTag = "[NetworkManager]"

    private var session: URLSession?

    func login(userData: RequestHandlerModel, completion: @escaping (NetworkRequestResult)->()) {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = ["Authorization": encode(credentials: userData)]
        session = URLSession(configuration: sessionConfiguration)
        let loginTask = session?.dataTask(with: loginRequest(userData: userData),
                          completionHandler: { (data, response, error) in
                            if let error = error {
                                completion(NetworkRequestResult.failure(error))
                            }
                            
                            if let data = data {
                                DispatchQueue.main.async {
                                    completion(NetworkRequestResult.success(data))
                                }
                            }
        })
        loginTask?.resume()
    }

    func handle(request: RequestType, completion: @escaping (NetworkRequestResult) -> ()) {
        switch request {
        case .fetchRepos(let fetchURLString):
            guard let session = session else {
                print(logTag + "URLSession was not created")
                fatalError()
            }
            fetchRepos(session: session, fetchURLString: fetchURLString, completion: completion)
        default:
            break
        }
    }

    private func fetchRepos(session: URLSession, fetchURLString: String, completion: @escaping (NetworkRequestResult) -> ()) {
        guard let repoURL = URL(string: fetchURLString) else {
            print(logTag + ": failed to create repoURL")
            fatalError()
        }
        let repoRequest = URLRequest(url: repoURL)
        let fetchRepoTask = session.dataTask(with: repoRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            if let data = data {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        }
        fetchRepoTask.resume()

    }

    private func loginRequest(userData: RequestHandlerModel) -> URLRequest {
        guard let url = URL(string: loginURLString) else {
            print(logTag + ": failed to create login request")
            fatalError()
        }
        return URLRequest(url: url)
    }

    private func encode(credentials: RequestHandlerModel) -> String {
        let userCredentialsString = "\(credentials.username):\(credentials.userPassword)"
        guard let userCredentialsAsData = userCredentialsString.data(using: String.Encoding.utf8) else {
            print(logTag + ": failed to convert credentials to Data")
            fatalError()
        }

        let encodedString = userCredentialsAsData.base64EncodedString()
        return "Basic \(encodedString)"
    }

}
