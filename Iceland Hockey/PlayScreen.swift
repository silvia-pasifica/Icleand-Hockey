//
//  PlayScreen.swift
//  Iceland Hockey
//
//  Created by Silvia Pasica on 21/05/23.
//

import UIKit
import SpriteKit

class PlayScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and configure the SKView
        let skView = SKView(frame: view.bounds)
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // Create the GameScene
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .resizeFill
        
        // Present the GameScene in the SKView
        skView.presentScene(scene)
        
        // Add the SKView to the view controller's view
        view.addSubview(skView)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
