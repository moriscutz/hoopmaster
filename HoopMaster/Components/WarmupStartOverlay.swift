import SwiftUI

struct WarmupStartOverlay: View {
    
    @Binding var showWarmupStart: Bool
    @Binding var showCountdown: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("For the warm up, try to reach the green targets with your hand while dribbling. Take 4 steps back from the phone after pressing 'Start'")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()

                Button(action: {
                    showWarmupStart = false
                    showCountdown = true
                }) {
                    Text("Start")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}
