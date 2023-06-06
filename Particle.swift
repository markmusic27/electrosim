import SwiftUI
import SpriteKit

class Particle: SKSpriteNode {
    
    let isProton: Bool
    
    init(isProton: Bool) {
        self.isProton = isProton
        
        let texture = SKTexture(imageNamed: isProton ? "proton" : "electron")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        size = CGSize(width: 30, height: 30)
                
        // Enable touch events for the particle
        isUserInteractionEnabled = true
        
        // Set the z-position so particles appear above the background
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: parent!)
        position = location
    }
}

