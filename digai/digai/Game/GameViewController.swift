//
//  GameViewController.swift
//  digai
//
//  Created by Wilton Ramos on 31/03/22.
//

import AVFoundation
import UIKit

class GameViewController: UIViewController {
    
    //MARK: PUBLIC PROPERTIES
    
    var audioPlayer: AVAudioPlayer?
    
    // MARK: - PRIVATE PROPERTIES
    
    private let viewModel: GameViewModel = GameViewModel()
    
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
        textField.text = viewModel.getTextFieldPlaceHolder()
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
        button.setTitle("STOP", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(didTapStopButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - INITIALIZERS
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let title = viewModel.getSongTitle(at: index) {
            songTextField.text = title
        } else {
            songTextField.text = viewModel.getTextFieldPlaceHolder()
        }
    }
    
    private func playSong(atIndex index: Int) {
        let pathToSound = Bundle.main.path(forResource: "teste", ofType: "m4a")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            return
        }
    }
    
    // MARK: - ACTIONS
    
    @objc private func didTapStopButton(_ sender: UIButton) {
        print("STOP!")
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
        
        imageView.image = UIImage(named: "example")
        
        return imageView
    }
}

extension GameViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.updateSongTitle(at: viewModel.getIndex(), with: textField.text)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
