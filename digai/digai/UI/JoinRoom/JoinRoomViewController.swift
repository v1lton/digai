//
//  JoinRoomViewController.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import UIKit

class JoinRoomViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - PRIVATE PROPERTIES
    
    var viewModel: JoinRoomViewModel = JoinRoomViewModel()

    // MARK: - UI
    
    lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Jogaço"
        label.font = UIFont(name: "Rubik-Bold" , size: 40)
        label.textColor = .black
        return label
    }()
    
    lazy var nameTexfieldTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome"
        label.font = UIFont(name: "Rubik-Bold" , size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "nome maneiro"
        textField.textAlignment = .center
        
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 2
        textField.returnKeyType = .done
        
        textField.delegate = self
        return textField
    }()
    
    lazy var codeTexfieldTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Código da Sala"
        label.font = UIFont(name: "Rubik-Bold" , size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "74acd"
        textField.textAlignment = .center
        
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 2
        textField.returnKeyType = .done
        
        textField.delegate = self
        return textField
    }()
    
    private lazy var joinRoomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 14)

        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        
        button.addTarget(self, action: #selector(didTapJoinRoomButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var createRoomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar Sala", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 14)

        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        
        button.addTarget(self, action: #selector(didTapCreateRoomButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupView()
    }
    
    // MARK: - ACTIONS
    
    @objc private func didTapJoinRoomButton(_ sender: UIButton) {
        viewModel.joinRoom(id: codeTextField.text, playerName: nameTextField.text)
    }

    
    @objc private func didTapCreateRoomButton(_ sender: UIButton) {
        viewModel.createRoom(playerName: nameTextField.text)
    }
}

// MARK: - JoinRoomDelegate

extension JoinRoomViewController : JoinRoomDelegate {
    func didStopGame() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(ResultViewController(), animated: false)
        }
    }
    
    func didCreateRoom(_ joinRoomResponse: JoinRoomResponse) {
        let controller = WaitingRoomViewController(joinRoomResponse, socketManager: viewModel.socketManager)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: false)
        }
    }
    
    func didJoinRoom(_ joinRoomResponse: JoinRoomResponse) {
        let controller = WaitingRoomViewController(joinRoomResponse, socketManager: viewModel.socketManager)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: false)
        }
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - ViewCode

extension JoinRoomViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(viewTitle)
        view.addSubview(nameTexfieldTitle)
        view.addSubview(nameTextField)
        view.addSubview(codeTexfieldTitle)
        view.addSubview(codeTextField)
        view.addSubview(codeTextField)
        view.addSubview(joinRoomButton)
        view.addSubview(createRoomButton)
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 97),
            viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            nameTexfieldTitle.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 29),
            nameTexfieldTitle.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameTexfieldTitle.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            nameTextField.widthAnchor.constraint(equalToConstant: 327),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            codeTexfieldTitle.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 54),
            codeTexfieldTitle.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor),
            
            codeTextField.topAnchor.constraint(equalTo: codeTexfieldTitle.bottomAnchor, constant: 5),
            codeTextField.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor),
            codeTextField.heightAnchor.constraint(equalToConstant: 60),
            codeTextField.widthAnchor.constraint(equalToConstant: 327),
            codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            joinRoomButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 29),
            joinRoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joinRoomButton.heightAnchor.constraint(equalToConstant: 36),
            joinRoomButton.widthAnchor.constraint(equalToConstant: 106),
            
            createRoomButton.topAnchor.constraint(equalTo: joinRoomButton.bottomAnchor, constant: 10),
            createRoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createRoomButton.heightAnchor.constraint(equalToConstant: 36),
            createRoomButton.widthAnchor.constraint(equalToConstant: 106),
        ])
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .white
    }
}
