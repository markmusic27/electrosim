import SwiftUI
import SpriteKit


class Puck: SKSpriteNode {

    
    init() {
        let texture = SKTexture(imageNamed: "puck")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        size = CGSize(width: 30, height: 30)
                
        // Enable touch events for the particle
        isUserInteractionEnabled = false
        
        // Set the z-position so particles appear above the background
        zPosition = 2
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


