import SwiftUI

struct OpenSimulatorButton: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [
                        Color(uiColor: UIColor(rgb: 0xff282248)),
                        Color(uiColor: UIColor(rgb: 0xffD456D0)),
                        Color(uiColor: UIColor(rgb: 0xff282248))
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .frame(height: 68)
                .cornerRadius(37)
            
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [
                        Color(uiColor: UIColor(rgb: 0xff08070E)),
                        Color(uiColor: UIColor(rgb: 0xff2B122A)),
                        Color(uiColor: UIColor(rgb: 0xff08070E))
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .frame(width: 269, height: 62)
                .cornerRadius(37)
            
            
            Text("Open Charge Simulator")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(.white)
                
        }
    }
}
