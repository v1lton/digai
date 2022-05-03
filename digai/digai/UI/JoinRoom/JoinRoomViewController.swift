//
//  JoinRoomViewController.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import UIKit

class JoinRoomViewController: UIViewController, UITextFieldDelegate {
    
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
    
    private lazy var createRoomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "buttonImage"), for: .normal)
        button.addTarget(self, action: #selector(didTapStopButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(viewTitle)
        view.addSubview(nameTexfieldTitle)
        view.addSubview(nameTextField)
        view.addSubview(codeTexfieldTitle)
        view.addSubview(codeTextField)
        view.addSubview(codeTextField)
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
        
        codeTexfieldTitle.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 54).isActive = true
        codeTexfieldTitle.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor).isActive = true
        
        codeTextField.topAnchor.constraint(equalTo: codeTexfieldTitle.bottomAnchor, constant: 5).isActive = true
        codeTextField.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor).isActive = true
        codeTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        codeTextField.widthAnchor.constraint(equalToConstant: 327).isActive = true
        
        createRoomButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 29).isActive = true
        createRoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func didTapStopButton(_ sender: UIButton) {
        
    }

}
