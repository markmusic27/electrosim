import SwiftUI

struct PlayButton: View {
    let togglePlay: () -> Void
    @State private var isPlaying = true;
    
    var body: some View {
        Button(action: {
            isPlaying = !isPlaying
            togglePlay()
        }){
            
            VStack {
                Image(isPlaying ? "pause" : "play")
                    .resizable()
                    .frame(width: 29, height: 29)
            }
            .frame(maxWidth: 47, maxHeight: .infinity)
            .background(Color.white.opacity(0.05))
            .border(Color.white.opacity(0.02), width: 3)
            .cornerRadius(10)
        }
        
    }
}
