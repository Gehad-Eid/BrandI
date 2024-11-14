//
//  SplashAnimation.swift
//  Challange1
//
//  Created by sumaiya on 12/11/2567 BE.
//

import SwiftUI
import SpriteKit


class AnimationScene: SKScene {
    override func didMove(to view: SKView) {
        
        createAnimation()
    }

    func createAnimation() {
        
        let sprite = SKSpriteNode(imageNamed: "1")
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        sprite.size = CGSize(width: size.width * 1, height: size.height * 1)
           sprite.setScale(1.0)
   
               
        addChild(sprite)

        let textures = [
            SKTexture(imageNamed: "1"),
            SKTexture(imageNamed: "2"),
            SKTexture(imageNamed: "3"),
            SKTexture(imageNamed: "4"),
            SKTexture(imageNamed: "5"),
            SKTexture(imageNamed: "6"),
            SKTexture(imageNamed: "7"),
            SKTexture(imageNamed: "8"),
            SKTexture(imageNamed: "9"),
            SKTexture(imageNamed: "10"),
        
            
        ]

        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.6)
           animation.timingMode = .easeInEaseOut

           let repeatAnimation = SKAction.repeatForever(animation)
           
           sprite.run(repeatAnimation)
       
    }
}


struct SpriteKitAnimationView: View {
    var scene: SKScene {
           let scene = AnimationScene()
           scene.size = UIScreen.main.bounds.size
        scene.scaleMode =  .aspectFit
           return scene
       }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
          
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpriteKitAnimationView()
    }
}
