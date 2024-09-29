import SwiftUI

struct content: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var rotationAngle: Double = 0.0
    @State private var isLandscape: Bool = false
    @State private var isAnimating = false
    @State private var navigateToNextView = false
    
    @State private var isShowingCamera = false
    @State private var handPosition: CGPoint = .zero
    @State private var isTouched: Bool = false
    @State private var targetPosition: CGPoint = CGPoint(x: 225, y: 315)
    @State private var handPoints: [CGPoint] = Array(repeating: .zero, count: 6)
    @State private var showStartOverlay = true
    @State private var countdown = 3
    @State private var showCountdown = false
    @State private var showCameraTargetOverlay = false
    @State private var showEndGameOverlay = false
    @State private var targetsTouched: Int = 0

    var body: some View {
        NavigationStack{
            VStack {
                if isLandscape {
                    Text("Landscape Mode Detected!")
                        .font(.largeTitle)
                        .bold()
                        .transition(.opacity)
                } else {
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
                }
            }
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                    checkOrientation()
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
            }
            .fullScreenCover(isPresented: $navigateToNextView) {
                ZStack {
                    HandTrackingController(handPosition: $handPosition, isTouched: $isTouched, targetPosition: $targetPosition, showEndGameOverlay: $showEndGameOverlay, showCameraTargetOverlay: $showCameraTargetOverlay, targetsTouched: $targetsTouched)
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                            AppDelegate.orientationLock = .landscape
                        }
                        .onDisappear {
                            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                            AppDelegate.orientationLock = .allButUpsideDown
                        }
                    
                    if showStartOverlay {
                        Color.black.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)

                        VStack {
                            Text("For the warm up, try to reach the green targets with your hand while dribbling. Take 4 steps back from the phone after pressing 'Start'")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()

                            Button(action: {
                                startCountdown()
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
                    
                    if showCountdown {
                        VStack {
                            Text("\(countdown)")
                                .font(.system(size: 72))
                                .foregroundColor(.white)
                                .bold()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)
                    }
                    
                    if showCameraTargetOverlay {
                        CameraTargetOverlayView(
                            targetPosition: $targetPosition,
                            handPosition: $handPosition,
                            isTouched: $isTouched,
                            targetsTouched: $targetsTouched, handPoints:  handPoints, totalTargets: 5
                        )
                        .edgesIgnoringSafeArea(.all)
                    }
                    if showEndGameOverlay {
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
            }
        }
    }
    
    private func startCountdown() {
        showStartOverlay = false
        showCountdown = true
        countdown = 3
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                showCountdown = false
                showCameraTargetOverlay = true
            }
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
    
    private func checkOrientation() {
        if UIDevice.current.orientation.isLandscape {
            withAnimation {
                rotationAngle = 90
                isLandscape = true
                navigateToNextView = true
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




