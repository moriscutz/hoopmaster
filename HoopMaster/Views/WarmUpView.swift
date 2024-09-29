import SwiftUI

struct WarmUpView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var isLandscape: Bool = false
    @State private var warmupStartIsShowing = false
    @State private var showCameraTargetOverlay: Bool = false
    @State private var showEndGameOverlay: Bool = false
    
    @State private var showStartOverlay: Bool = true
    @State private var showCountdown = false
    
    @State private var targetPosition: CGPoint = CGPoint(x: 225, y: 315)
    @State private var handPosition: CGPoint = .zero
    @State private var isTouched: Bool = false
    @State private var handPoints: [CGPoint] = Array(repeating: .zero, count: 6)
    
    @State private var targetsTouched: Int = 0
    
    
    var body: some View {
        NavigationStack{
            VStack {
                if !isLandscape {
                    RotateToLandscapeView(isLandscape: $isLandscape, warmupStartIsShowing: $warmupStartIsShowing)
                }
                else {
                    Text("Landscape Mode Detected!")
                        .font(.largeTitle)
                        .bold()
                        .transition(.opacity)
                        .onAppear {
                            print("warmup show : \(warmupStartIsShowing)")
                        }
                }
                    
            }
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                    checkOrientation()
                    
                    UIApplication.shared.isIdleTimerDisabled = true
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
                UIApplication.shared.isIdleTimerDisabled = false
            }
            .fullScreenCover(isPresented: $warmupStartIsShowing) {
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
                        WarmupStartOverlay(showWarmupStart: $showStartOverlay, showCountdown: $showCountdown)
                    }
                    if showCountdown {
                        CountdownOverlay(showCountdown: $showCountdown, showCameraTarget: $showCameraTargetOverlay)
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
                        EndGameOverlay(dismiss: dismissView)
                    }
                }
            }
        }
    }
    
    func dismissView() {
        dismiss()
    }
    
    private func checkOrientation() {
        if UIDevice.current.orientation.isLandscape {
            withAnimation {
                isLandscape = true
                warmupStartIsShowing = true
                print("Landscape mode ON")
            }
        } else if UIDevice.current.orientation.isPortrait {
            withAnimation {
                isLandscape = false
                print("Landscape mode OFF")
            }
        }
    }
}

