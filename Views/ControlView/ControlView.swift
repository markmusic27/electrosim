import SwiftUI

struct ControlView: View {
    let addProton: () -> Void
    let addElectron: () -> Void
    let reset: () -> Void
    let togglePlay: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                AddParticleButton(addElectron: addElectron, addProton: addProton)

                HStack {
                    PlayButton(togglePlay: togglePlay)
                    ResetButton(reset: reset)
                }.frame(maxWidth: .infinity, maxHeight: 47)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(uiColor: UIColor(rgb: 0xff06060C)),
                        Color(uiColor: UIColor(rgb: 0xff2B122A)),
                        Color(uiColor: UIColor(rgb: 0xff06060C)),
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(15)
            .padding(5)

        }
        .frame(maxWidth: 224, maxHeight: 195)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(uiColor: UIColor(rgb: 0xff8774FF)).opacity(0.2),
                    Color(uiColor: UIColor(rgb: 0xffEC5EE6)).opacity(0.9),
                    Color(uiColor: UIColor(rgb: 0xff8774FF)).opacity(0.2)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(20)
        .padding(.bottom, 30)
        .padding(.leading, 30)
    }
}
