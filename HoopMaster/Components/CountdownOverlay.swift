import SwiftUI

struct CountdownOverlay: View {
    
    @Binding var showCountdown: Bool
    @Binding var showCameraTarget: Bool
    
    @State private var countdown = 3
    
    var body: some View {
        VStack {
            Text("\(countdown)")
                .font(.system(size: 72))
                .foregroundColor(.white)
                .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            startCountdown()
        }
    }
    
    private func startCountdown() {
        countdown = 3
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                showCountdown = false
                showCameraTarget = true
            }
        }
    }
}
