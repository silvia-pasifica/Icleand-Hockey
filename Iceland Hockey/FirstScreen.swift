//
//  FirstScreen.swift
//  Iceland Hockey
//
//  Created by Silvia Pasica on 21/05/23.
//
import UIKit

class FirstScreen: UIViewController {
    let playButton = UIButton()
    let howToPlayButton = UIButton()
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    let imageView = UIImageView(image: UIImage(named: "titles"))
    let imageBackground1 = UIImageView(image: UIImage(named: "attribute1"))
    let imageBackground2 = UIImageView(image: UIImage(named: "attribute2"))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.layer.zPosition = -1
        backgroundImage.layer.opacity = 0.44
        
        view.addSubview(backgroundImage)
        setupView()
        setupConstrain()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupView(){
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        setupButton()
//        setupHowToPlayButton()
        view.addSubview(imageBackground2)
        view.addSubview(imageBackground1)
        imageBackground2.contentMode = .scaleAspectFit
        imageBackground2.translatesAutoresizingMaskIntoConstraints = false
        imageBackground1.contentMode = .scaleAspectFit
        imageBackground1.translatesAutoresizingMaskIntoConstraints = false
       
    }
    
    func setupConstrain(){
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
//            playButton.bottomAnchor.constraint(equalTo: view.centerYAnchor.bot)
            playButton.widthAnchor.constraint(equalToConstant: 200),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            
//            howToPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            howToPlayButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
//            howToPlayButton.widthAnchor.constraint(equalToConstant: 200),
//            howToPlayButton.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            imageView.widthAnchor.constraint(equalToConstant: 512.46),
            imageView.heightAnchor.constraint(equalToConstant: 329.94),
            
            imageBackground2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageBackground2.widthAnchor.constraint(equalToConstant: 500),
            imageBackground2.heightAnchor.constraint(equalToConstant: 500),
            
            imageBackground1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageBackground1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageBackground1.widthAnchor.constraint(equalToConstant: 500),
            imageBackground1.heightAnchor.constraint(equalToConstant: 500),
            
        ])
    }
    
    func setupButton() {
        view.addSubview(playButton)
        let buttonTitleAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30.0, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let attributedTitle = NSAttributedString(string: "Play", attributes: buttonTitleAttributes)
        
        playButton.backgroundColor = UIColor(red: 0.23, green: 0.26, blue: 0.38, alpha: 1.0)
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.setAttributedTitle(attributedTitle, for: .normal)
        
        playButton.layer.cornerRadius = 10
        playButton.layer.masksToBounds = true
        playButton.layer.shadowColor = UIColor.black.cgColor
        playButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        playButton.layer.shadowOpacity = 0.5
        playButton.layer.shadowRadius = 4
        
        playButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
//    func setupHowToPlayButton() {
//        view.addSubview(howToPlayButton)
//        howToPlayButton.backgroundColor = .systemBlue
//        howToPlayButton.setTitle("How to Play", for: .normal)
//        howToPlayButton.setTitleColor(.white, for: .normal)
//
//        howToPlayButton.layer.cornerRadius = 10
//        howToPlayButton.layer.masksToBounds = true
//
//        howToPlayButton.translatesAutoresizingMaskIntoConstraints = false
//
//    }
    
    @objc func goToNextScreen() {
        let nextScreen = PlayScreen()
        nextScreen.title = ""
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}
