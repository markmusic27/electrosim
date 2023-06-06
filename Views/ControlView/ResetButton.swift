import SwiftUI

struct ResetButton: View {
    let reset: () -> Void
    
    var body: some View {
        Button(action: {
            reset()
        }){
            
            VStack {
                Text("Reset")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
            }
            .frame(maxWidth: 118, maxHeight: .infinity)
            .background(Color.white.opacity(0.05))
            .border(Color.white.opacity(0.02), width: 3)
            .cornerRadius(10)
        }
        
    }
}

