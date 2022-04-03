//
//  ViewController.swift
//  digai
//
//  Created by Wilton Ramos on 31/03/22.
//

import UIKit

class ViewController: UIViewController {

    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("sign in to Spotify", for: .normal)
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        if !SpotifyManager.shared.isSignedIn {
            view.addSubview(signInButton)
            
            NSLayoutConstraint.activate([
                signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func didTapSignIn() {
        let viewController = SpotifySignInViewController()
        viewController.completionHandler = { [weak self] success in
            guard success else {
                self?.showAlert(title: "Could not sign in",
                                message: "We couldn't sign in to your Spotify account. Try again!")
                return
            }
            
            self?.signInButton.removeFromSuperview()
        }
        
        present(viewController, animated: true)
    }
}

