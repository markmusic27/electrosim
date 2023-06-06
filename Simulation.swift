import SpriteKit
import Foundation
import SwiftUI

class Simulation: SKScene {
    
    // Bindings
    @Binding var particles: [Particle]
    @Binding var isPlaying: Bool
    
    // State
    var isBuilding = false
    let puck = Puck()
    var pathArray: [CGPoint] = []
    let trail = SKShapeNode();
    
    init(particles: Binding<[Particle]>, isPlaying: Binding<Bool>) {
        _particles = particles
        _isPlaying = isPlaying
        
        super.init(size: UIScreen.main.bounds.size)
        self.scaleMode = .resizeFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func settleDifference() {
        if (particles.isEmpty) {
            removeAllChildren();
            
            // Add Trail
            pathArray = []
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x:1, y:1))
            
            updateTrial(path: path, isPlaceholder: true)
            
            // Add Puck
            addPuck()
            return;
        }
        
        let newParticle = particles.last!
        addChild(newParticle)
        
        return;
    }
    
    func addPuck () {
        let centerX = size.width / 2
        let centerY = size.height / 3
        puck.position = CGPoint(x: centerX, y: centerY)
        puck.physicsBody = SKPhysicsBody(circleOfRadius: puck.frame.width / 2)
        puck.physicsBody?.allowsRotation = false
        puck.physicsBody?.mass = 1;
        puck.physicsBody?.friction = 0;
        puck.physicsBody?.restitution = 0;
        puck.physicsBody?.affectedByGravity = false
        puck.physicsBody?.angularDamping = 0
        puck.physicsBody?.linearDamping = 0
        
        addChild(puck)
    }
    
    func updateTrial(path: CGMutablePath, isPlaceholder: Bool) {
        trail.path = path
        
        trail.lineWidth = 2
        trail.lineCap = .round
        trail.fillColor = .clear
        
        if isPlaceholder {
            trail.strokeColor = .clear
            addChild(trail)
            
            return
        }
        
        trail.strokeColor = .white
        trail.glowWidth = 0
    }
    
    // Creates a trail behind the puck
    func createTrail() {
        
        let pathLen: Int = 50
        
        // Start trail
        if (pathArray.isEmpty) {
            pathArray.append(puck.position)
            return;
        }
        
        // Don't add if puck has not moved
        if (puck.position == pathArray.last){
            return;
        }
        
        pathArray.append(puck.position)
        
        let path = CGMutablePath();
        
        if (pathArray.count < pathLen + 1) {
            path.move(to: pathArray[0])
            
            for point in pathArray {
                path.addLine(to: point)
            }
        } else {
            let trunc = pathArray[(pathArray.count - pathLen)..<pathArray.count]
            
            path.move(to: trunc.first!)
            
            for point in trunc {
                path.addLine(to: point)
            }
        }
        
        

        updateTrial(path: path, isPlaceholder: false)
    }
    
    // Handles the acceleration of the puck
    
    func engine() {
        if children.count == 1 {
            return;
        }

        let speed: Double = 10000000; // Used to speed up or slow down animation
        let speedLim: Double = 10000
        let puckCharge: Double = -1; // Puck is an electron by default

        // Force components
        var fdx: Double = 0;
        var fdy: Double = 0;


        // Get particles
        var tempP = children
        tempP.removeFirst(2) // Removes puck and trail
        let p: [Particle] = tempP.map { $0 as! Particle } // Converts to particles

        // Calculate x, y forces each particle has on the puck
        for particle in p {
            let dx = (puck.position.x - particle.position.x)
            let dy = (puck.position.y - particle.position.y)

            // Calculate attrative or repulsive constant
            let charge: Double = puckCharge * (particle.isProton ? 1.0 : -1.0)

            // Calculate local forces
            let distanceSquared: Double = (minLimit(a: dx*dx, b: speedLim) + minLimit(a: dy*dy, b: speedLim))
            
            let angle: Double = atan2(dy, dx)
            let lfdx: Double = (charge*cos(angle))/distanceSquared
            let lfdy: Double = (charge*sin(angle))/distanceSquared




            // Add them to total forces
            fdx = fdx + lfdx*speed
            fdy = fdy + lfdy*speed
        }


        // Apply force
        if (isPlaying) {
            createTrail()
            puck.physicsBody?.applyForce(CGVector(dx: fdx, dy: fdy))
        }

    }
    
    func minLimit(a: Double, b:Double) -> Double {
        return a < b ? b : a
    }
    
   
    
    // Game Logic
        
    override func didMove(to view: SKView) {
        // Set Environment Physics Properties
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        // Add trail
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:1, y:1))
        
        updateTrial(path: path, isPlaceholder: true)
        
        // Add Puck
        addPuck()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        // Sync with Environmental Values
        if (particles.count != (children.count - 2) && !isBuilding){
            isBuilding = true;
            settleDifference()
            isBuilding = false
            
        }
        
        // Add pause functionality
        
        if (!isPlaying) {
            puck.physicsBody?.velocity = CGVectorMake(0, 0)
        }
        
        engine()
        
    }
    

}

