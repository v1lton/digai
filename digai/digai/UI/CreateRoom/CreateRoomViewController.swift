//
//  CreateRoomViewController.swift
//  digai
//
//  Created by Morgana Galamba on 04/05/22.
//

import UIKit

class CreateRoomViewController: UIViewController {
    
    private var socketManager: GameSocketManager?
    
    var viewModel: CreateRoomViewModel = CreateRoomViewModel()
    var player: String
    var roomName: String
    
    init(player: String , roomName: String){
        
        self.player = player
        self.roomName = roomName
        
        super.init(nibName: nil, bundle: nil)
        
        //self.socketManager = GameSocketManager(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var CreateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Criar Sala", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapCreateButton(_:)), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(CreateButton)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        CreateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        CreateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        CreateButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        CreateButton.widthAnchor.constraint(equalToConstant: 106).isActive = true
    }
    
    @objc private func didTapCreateButton(_ sender: UIButton) {
//        socketManager?.joinRoom(player: self.player, roomName: self.roomName)
        //self.navigationController?.pushViewController(WaitingRoomViewController(roomName: self.roomName), animated: false)
    }

}
