//
//  JoinRoomViewController.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import UIKit

class JoinRoomViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: JoinRoomViewModel = JoinRoomViewModel()

    lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.text = "Jogaço"
        label.font = UIFont(name: "Rubik-Bold" , size: 40)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTexfieldTitle: UILabel = {
        let label = UILabel()
        label.text = "Nome"
        label.font = UIFont(name: "Rubik-Bold" , size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.placeholder = "nome maneiro"
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 2
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    lazy var codeTexfieldTitle: UILabel = {
        let label = UILabel()
        label.text = "Código da Sala"
        label.font = UIFont(name: "Rubik-Bold" , size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
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
        button.setTitle("Entrar", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapJoinRoomButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var createRoomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Criar Sala", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapCreateRoomButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .white
        view.addSubview(viewTitle)
        view.addSubview(nameTexfieldTitle)
        view.addSubview(nameTextField)
        view.addSubview(codeTexfieldTitle)
        view.addSubview(codeTextField)
        view.addSubview(codeTextField)
        view.addSubview(joinRoomButton)
        view.addSubview(createRoomButton)
        
        setupConstraints()        
    }
    
    func setupConstraints(){
        viewTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 97).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        
        nameTexfieldTitle.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 29).isActive = true
        nameTexfieldTitle.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: nameTexfieldTitle.bottomAnchor, constant: 5).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 327).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        codeTexfieldTitle.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 54).isActive = true
        codeTexfieldTitle.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor).isActive = true
        
        codeTextField.topAnchor.constraint(equalTo: codeTexfieldTitle.bottomAnchor, constant: 5).isActive = true
        codeTextField.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor).isActive = true
        codeTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        codeTextField.widthAnchor.constraint(equalToConstant: 327).isActive = true
        codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        joinRoomButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 29).isActive = true
        joinRoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        joinRoomButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        joinRoomButton.widthAnchor.constraint(equalToConstant: 106).isActive = true
        
        createRoomButton.topAnchor.constraint(equalTo: joinRoomButton.bottomAnchor, constant: 10).isActive = true
        createRoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createRoomButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        createRoomButton.widthAnchor.constraint(equalToConstant: 106).isActive = true
    }
    
    @objc private func didTapJoinRoomButton(_ sender: UIButton) {
        viewModel.joinRoom(id: codeTextField.text, playerName: nameTextField.text)
    }

    
    @objc private func didTapCreateRoomButton(_ sender: UIButton) {
        viewModel.createRoom(playerName: nameTextField.text)
    }
}

extension JoinRoomViewController : JoinRoomDelegate {
    func didStopGame() {
        navigationController?.pushViewController(ResultViewController(), animated: false)
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

