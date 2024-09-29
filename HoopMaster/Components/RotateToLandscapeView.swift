import SwiftUI

struct RotateToLandscapeView: View {
    
    @State private var rotationAngle: Double = 0.0
    @Binding var isLandscape: Bool
    @Binding var warmupStartIsShowing: Bool
        
    var body: some View {
            VStack {
                Image(systemName: "iphone")
                    .resizable()
                    .frame(width: 100, height: 200)
                    .rotationEffect(.degrees(rotationAngle))
                    .onAppear {
                        checkOrientation()
                        startRotating()
                    }
                
                Text("Rotate your phone to landscape to start the training session")
                    .font(.title)
                    .padding()
            }
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                }
                checkOrientation()
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
            }
    }
    
    private func startRotating() {
        rotateToLandscape()
    }
    
    private func rotateToLandscape() {
        withAnimation(Animation.easeInOut(duration: 1)) {
            rotationAngle = -90
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            rotateToPortrait()
        }
    }
    
    private func rotateToPortrait() {
        withAnimation(Animation.easeInOut(duration: 1)) {
            rotationAngle = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            rotateToLandscape()
        }
    }
    
    func checkOrientation() {
        if UIDevice.current.orientation.isLandscape {
            withAnimation {
                rotationAngle = 90
                isLandscape = true
                warmupStartIsShowing = true
                print("Landscape mode ON")
            }
        } else if UIDevice.current.orientation.isPortrait {
            withAnimation {
                rotationAngle = 0
                isLandscape = false
                print("Landscape mode OFF")
            }
        }
    }
}

