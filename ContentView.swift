import SwiftUI
import SpriteKit
import AVFoundation

struct ContentView: View {
    
    // State
    @EnvironmentObject var data: SimulationData
    @State private var showWelcome = true
    
    // Handle Control Logic
    func addProton() {
        let particle = Particle(isProton: true)
        data.particles.append(particle)
        let centerX = scene.size.width / 2
        let centerY = scene.size.height / 2
        particle.position = CGPoint(x: centerX, y: centerY)
    }
    
    func addElectron() {
        let particle = Particle(isProton: false)
        data.particles.append(particle)
        let centerX = scene.size.width / 2
        let centerY = scene.size.height / 2
        particle.position = CGPoint(x: centerX, y: centerY)
    }
    
    func togglePlay() {
        data.isPlaying = !data.isPlaying
    }
    
    func reset() {
        data.particles = []
    }
    
    // Play background music
    var audioPlayer: AVAudioPlayer?

    init() {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.ambient, mode: .default)
            try audioSession.setActive(true)
            guard let audioFilePath = Bundle.main.path(forResource: "background", ofType: "mp3") else {
                print("Could not find audio file")
                return
            }


            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFilePath))
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }

    // Create Simulation
    var scene: SKScene {
        let scene = Simulation(
            particles: $data.particles,
            isPlaying: $data.isPlaying
        )
        
        scene.size = UIScreen.main.bounds.size
        scene.scaleMode = .resizeFill
        scene.backgroundColor = UIColor.black
        
        return scene
    }
    
    
    var body: some View {
        ZStack {
            if showWelcome {
                GeometryReader {geometry in
                    WelcomeView(showWelcome: $showWelcome)
                        .transition(.move(edge: .leading))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .edgesIgnoringSafeArea(.all)
                        .background(Color.black)
                }
            } else {
                GeometryReader { geometry in
                    ZStack(alignment: .bottomLeading) {
                        SpriteView(scene: scene)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .edgesIgnoringSafeArea(.all)
                            .background(Color.black)
                        
                        ControlView(
                            addProton: addProton,
                            addElectron: addElectron,
                            reset: reset,
                            togglePlay: togglePlay
                        )
                        
                        // Tutorial text
                        Text("Try adding and dragging protons and electrons around. Enjoy :)")
                            .foregroundColor(Color(uiColor: UIColor(rgb: 0xff2E2E2E)))
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .position(x: geometry.size.width/2, y: 0)
                            .padding(.top, 35)
                        
                        Button(action: {
                            withAnimation {
                                showWelcome = true
                            }
                        }) {
                            Text("Close")
                                .foregroundColor(Color(uiColor: UIColor(rgb: 0xff6B6B6B)))
                                .fontWeight(.semibold)
                                .font(.system(size: 16))
                                .frame(width: 50, height: 40, alignment: .topLeading)
                                .padding(.top, 35)
                                .padding(.leading, 30)
                        }
                            .position(x: 35, y: 26)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}




