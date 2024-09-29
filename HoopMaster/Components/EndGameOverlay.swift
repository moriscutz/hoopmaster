import SwiftUI

struct EndGameOverlay: View {
    
    var dismiss: () -> Void
    
    var body: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
        
        VStack {
            Text("You completed the warm-up!")
                .foregroundColor(.white)
                .font(.largeTitle)
                .bold()
                .padding()

            Button(action: {
                dismiss()
            }) {
                Text("Continue")
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }
}

