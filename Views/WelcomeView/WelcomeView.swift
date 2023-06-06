import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcome: Bool
    @State private var isShowingMessage = false
    
    
    init(showWelcome: Binding<Bool>) {
        _showWelcome = showWelcome;
    }

    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                
                // Color Blur
                Image("blue_blur")
                    .frame(width: 545, height: 440)
                    .offset(x: -(geometry.size.width * 0.22), y: -geometry.size.height * 0.3)
                    .scaleEffect(isShowingMessage ? 1.2 : 0.8)
                    .opacity(isShowingMessage ? 1 : 0)
                    .animation(Animation.easeIn(duration: 3), value: isShowingMessage)
            
                
                Image("pink_blur")
                    .frame(width: 545, height: 440)
                    .offset(x: (geometry.size.width * 0.2), y: -geometry.size.height * 0.15)
                    .scaleEffect(isShowingMessage ? 1.2 : 0.8)
                    .opacity(isShowingMessage ? 1 : 0)
                    .animation(Animation.easeIn(duration: 4).delay(0.2), value: isShowingMessage)

                    
                
                VStack {
                    // Equalizes spacer below
                    Spacer()
                    
                    // Header
                    LinearGradient(
                        colors: [
                            Color(uiColor: UIColor(rgb: 0xffFFE2FE)),
                            Color(uiColor: UIColor(rgb: 0xff8572FF))
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                        .mask(
                            Text("The Electric Charge Simulator")
                                .font(.system(size: 30))
                                .fontWeight(.black)
                                .multilineTextAlignment(.center)
                        )
                        .frame(height: 35)
                        .padding(.bottom, 16)
                        .scaleEffect(isShowingMessage ? 1 : 0.8)
                        .opacity(isShowingMessage ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 1), value: isShowingMessage
                    )
                    
                    // Subheader
                    Text("Experience the mesmerizing dynamics of charged particles through an interactive visualization")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(uiColor: UIColor(rgb: 0xff7967AD)))
                        .frame(width: 591)
                        .scaleEffect(isShowingMessage ? 1 : 0.8)
                        .opacity(isShowingMessage ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 1).delay(0.1), value: isShowingMessage)
                        .padding(.bottom, 76)
                    
                    // Open Button
                    Button(action: {
                        withAnimation {
                            showWelcome = false
                        }
                    }) {
                        OpenSimulatorButton()
                    }
                    .frame(width: 275, height: 68)
                    .opacity(isShowingMessage ? 1 : 0)
                    .cornerRadius(40)
                    .animation(Animation.easeInOut(duration: 1).delay(0.5), value: isShowingMessage)
                    .padding(.bottom, 9)
                    
                    Spacer()
                    
                    Text("Made with  ❤️  by Mark Music")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color(uiColor: UIColor(rgb: 0xff818181)))
                        .scaleEffect(isShowingMessage ? 1.2 : 1)
                        .opacity(isShowingMessage ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 1).delay(0.5), value: isShowingMessage)
                        .padding(.bottom, 40)
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }.onAppear {
                withAnimation {
                    isShowingMessage = true
                }
            }
        }
        .opacity(showWelcome ? 1 : 0)
        .animation(Animation.easeOut(duration: 3), value: true)
        
    }
}
