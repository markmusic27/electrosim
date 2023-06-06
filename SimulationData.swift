import SwiftUI
import SpriteKit

class SimulationData: ObservableObject {
    @Published var particles: [Particle] = []
    @Published var isPlaying: Bool = true
}
