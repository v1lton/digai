//
//  GameViewController.swift
//  digai
//
//  Created by Wilton Ramos on 31/03/22.
//

import AVFoundation
import SDWebImage
import UIKit

class GameViewController: UIViewController {
    
    //MARK: PUBLIC PROPERTIES
    
    var audioPlayer: AVAudioPlayer?
    
    // MARK: - PRIVATE PROPERTIES
    
    private var viewModel: GameViewModel
    //private lazy var socketManager = GameSocketManager(delegate: self)
    
    init(room: CreateRoomResponse, socket: GameSocketManager){
        
        self.viewModel = GameViewModel(room: room, socket: socket)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var albunsCarousel: iCarousel = {
        let carousel = iCarousel(frame: CGRect(x: 0,
                                               y: view.frame.midY - 400,
                                               width: view.frame.size.width,
                                               height: 400))
        carousel.dataSource = self
        carousel.delegate = self
        carousel.type = .coverFlow2
        return carousel
    }()
    
    private lazy var songTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = viewModel.getTextFieldPlaceHolder()
        textField.textAlignment = .center
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 2
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "buttonImage"), for: .normal)
        button.addTarget(self, action: #selector(didTapStopButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - INITIALIZERS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupView()
        buildViewHierarchy()
        constraintUI()
    }
    
    // MARK: - SETUP
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func buildViewHierarchy() {
        view.addSubview(albunsCarousel)
        view.addSubview(songTextField)
        view.addSubview(stopButton)
    }
    
    private func constraintUI() {
        NSLayoutConstraint.activate([
            songTextField.topAnchor.constraint(equalTo: albunsCarousel.bottomAnchor, constant: 64),
            songTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            songTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            songTextField.heightAnchor.constraint(equalToConstant: 60),
            
            stopButton.topAnchor.constraint(equalTo: songTextField.bottomAnchor, constant: 32),
            stopButton.widthAnchor.constraint(equalToConstant: 135),
            stopButton.heightAnchor.constraint(equalToConstant: 60),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: PRIVATE FUNCTIONS
    
    private func bindSongTitlesToTextField(forIndex index: Int) {
        if let title = viewModel.getSongTitleGuess(at: index) {
            songTextField.text = title
        } else {
            songTextField.text = nil
            songTextField.placeholder = viewModel.getTextFieldPlaceHolder()
        }
    }
    
    private func playSong(atIndex index: Int) {
        guard let audioTrack = viewModel.getAudioTrack(at: index) else { return }
        Player.shared.play(audioTrack)
    }
    
    // MARK: - ACTIONS
    
    @objc private func didTapStopButton(_ sender: UIButton) {
        print("STOP!")
        //socketManager.requestStop()
    }
    
    public func reloadCarouselData() {
        albunsCarousel.reloadData()
    }
}

// MARK: - GameViewModelDelegate

extension GameViewController: GameViewModelDelegate {
    func didSetTracks() {
        albunsCarousel.reloadData()
    }
}

// MARK: - iCarouselDelegate

extension GameViewController: iCarouselDelegate {
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        viewModel.updateIndex(carousel.currentItemIndex)
        bindSongTitlesToTextField(forIndex: viewModel.getIndex())
        playSong(atIndex: viewModel.getIndex())
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
       playSong(atIndex: index)
    }
}

// MARK: - iCarouselDataSource

extension GameViewController: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return viewModel.getNumberOfItens()
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let imageView: UIImageView
        
        if view != nil {
            imageView = view as! UIImageView
        } else {
            imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: self.view.frame.size.width/1.2,
                                                  height: 300))
        }
        
        if let albumURL = viewModel.getAlbumURL(at: index) {
            imageView.sd_setImage(with: URL(string: albumURL))
        }
        
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        
        return imageView
    }
}

extension GameViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.updateSongGuess(at: viewModel.getIndex(), with: textField.text)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
