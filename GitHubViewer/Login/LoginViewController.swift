//
//  LoginViewController.swift
//  GitHubViewer
//
//  Created by Andrei Chernyshou on 7/10/18.
//  Copyright © 2018 Andrei Chernyshou. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginDescription: UILabel!
    
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var passwordDescription: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: LoginViewModel!
    private var isPresentingKeyboard = false
    private let kSubmitButtonSpacing: CGFloat = 22
    
    @IBAction func submit(_ sender: UIButton) {
        guard let login = loginField.text, !login.isEmpty, let password = passwordField.text, !password.isEmpty else {
            return
        }
        
        sender.isHidden = true
        viewModel.process(login: login,
                          password: password) { (result) in
                            switch result {
                            case .success:
                                self.activityIndicator.stopAnimating()
                            case .failure(let error):
                                self.passwordDescription.text = nil
                                self.loginDescription.text = error.localizedDescription
                            }
        }
        activityIndicator.startAnimating()
    }

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        passwordField.isSecureTextEntry = true
        submit.setTitle("Submit", for: .normal)
        passwordDescription.text = viewModel.passwordFieldDescription
        loginDescription.text = viewModel.loginFieldDescription
        navigationController?.navigationBar.isHidden = true
        registerForNotifications()
    }

    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardFrameChaned(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardFrameChaned(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    private func unregisterFromNotificatons() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardFrameChaned(notification: NSNotification) {
        guard let endKeyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }

        switch notification.name {
        case NSNotification.Name.UIKeyboardWillShow:
            if !isPresentingKeyboard {
                containerViewTopConstraint.constant -= (endKeyboardSize.height + kSubmitButtonSpacing)
                containerViewBottomConstraint.constant += (endKeyboardSize.height + kSubmitButtonSpacing)
                isPresentingKeyboard = true
            }

        case NSNotification.Name.UIKeyboardWillHide:
            if isPresentingKeyboard {
                containerViewTopConstraint.constant += (endKeyboardSize.height + kSubmitButtonSpacing)
                containerViewBottomConstraint.constant -= (endKeyboardSize.height + kSubmitButtonSpacing)
                isPresentingKeyboard = false
            }
        default:
            break
        }

        UIView.animate(withDuration: 0.3) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }

    deinit {
        unregisterFromNotificatons()
    }
}

extension LoginViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: containerView),
            !passwordField.frame.contains(touchLocation), !loginField.frame.contains(touchLocation) {
            passwordField.resignFirstResponder()
            loginField.resignFirstResponder()
        }
    }
}
