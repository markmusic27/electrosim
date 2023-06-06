import SwiftUI

struct AddParticleButton: View {
    let addElectron: () -> Void
    let addProton: () -> Void
    
    var body: some View {
        VStack {
            Button(action: {
                addProton()
            }){
                HStack {
                    Text("Add Proton")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                    Image("proton")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            
            Button(action: {
                addElectron()
            }){
                HStack {
                    Text("Add Electron")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                    Image("electron")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .frame(maxWidth: 176, maxHeight: 89)
        .background(Color.white.opacity(0.05))
        .border(Color.white.opacity(0.02), width: 3)
        .cornerRadius(10)
    }
}
