import SwiftUI
import ARKit
import Vision

class ARViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    var arView: ARSCNView!
    private let handPoseRequest = VNDetectHumanHandPoseRequest()
    var handPosition: Binding<CGPoint>?
    var targetPosition: Binding<CGPoint>?
    var isTouched: Binding<Bool>?
    var targetsTouched: Binding<Int>?
    
    var handPoints: [CGPoint] = []
    let totalTargets = 5
    
    var showEndGameOverlay: Binding<Bool>?
    var showCameraTargetOverlay: Binding<Bool>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView = ARSCNView(frame: view.bounds)
        arView.delegate = self
        arView.session.delegate = self
        view.addSubview(arView)
        
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arView.session.run(configuration)
        
        DispatchQueue.main.async {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        }
        
        self.setRandomTargetPosition()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        DispatchQueue.main.async {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let handler = VNImageRequestHandler(cvPixelBuffer: frame.capturedImage, orientation: .up, options: [:])
        
        do {
            try handler.perform([handPoseRequest])
            if let results = handPoseRequest.results?.first as? VNHumanHandPoseObservation {
                processHandPoseResults(results)
            }
        } catch {
            print("Error performing hand pose request: \(error)")
        }
    }
    
    private func processHandPoseResults(_ observation: VNHumanHandPoseObservation) {
        do {
            let wrist = try observation.recognizedPoint(.wrist)
            let thumbTip = try observation.recognizedPoint(.thumbTip)
            let indexTip = try observation.recognizedPoint(.indexTip)
            let middleTip = try observation.recognizedPoint(.middleTip)
            let ringTip = try observation.recognizedPoint(.ringTip)
            let littleTip = try observation.recognizedPoint(.littleTip)
            
            guard wrist.confidence > 0.5, thumbTip.confidence > 0.5, indexTip.confidence > 0.5,
                  middleTip.confidence > 0.5, ringTip.confidence > 0.5, littleTip.confidence > 0.5 else {
                print("Confidence too low for hand points")
                return
            }
            
            DispatchQueue.main.async {
                let screenBounds = UIScreen.main.bounds
                
                self.handPoints = [
                    CGPoint(x: wrist.location.x * screenBounds.width, y: (1 - wrist.location.y) * screenBounds.height),
                    CGPoint(x: thumbTip.location.x * screenBounds.width, y: (1 - thumbTip.location.y) * screenBounds.height),
                    CGPoint(x: indexTip.location.x * screenBounds.width, y: (1 - indexTip.location.y) * screenBounds.height),
                    CGPoint(x: middleTip.location.x * screenBounds.width, y: (1 - middleTip.location.y) * screenBounds.height),
                    CGPoint(x: ringTip.location.x * screenBounds.width, y: (1 - ringTip.location.y) * screenBounds.height),
                    CGPoint(x: littleTip.location.x * screenBounds.width, y: (1 - littleTip.location.y) * screenBounds.height)
                ]
                                
                self.handPosition?.wrappedValue = self.handPoints[0]
                
                if self.checkIfHandTouchesCircle(handPosition: self.handPoints[0]) {
                    self.isTouched?.wrappedValue = true
                    self.handleTargetTouched()
                } else {
                    self.isTouched?.wrappedValue = false
                }
            }
        } catch {
            print("Error extracting hand pose points: \(error)")
        }
    }
    
    private func checkIfHandTouchesCircle(handPosition: CGPoint) -> Bool {
        guard let circleCenter = targetPosition?.wrappedValue else { return false }
        let circleRadius: CGFloat = 70.0
        let distance = sqrt(pow(handPosition.x - circleCenter.x, 2) + pow(handPosition.y - circleCenter.y, 2))
        return distance <= circleRadius
    }
    
    private func handleTargetTouched() {
        if let currentTargetsTouched = targetsTouched?.wrappedValue {
            targetsTouched?.wrappedValue = currentTargetsTouched + 1

            if currentTargetsTouched + 1 >= totalTargets {
                print("All targets touched! Game over!")
                self.endGame()
            } else {
                self.setRandomTargetPosition()
            }
        } else {
            print("Error: targetsTouched is not set.")
        }
    }
    
    private func setRandomTargetPosition() {
        let screenBounds = UIScreen.main.bounds
        let randomX = CGFloat.random(in: 50...(screenBounds.width - 50))
        let randomY = CGFloat.random(in: 50...(screenBounds.height - 50))
        self.targetPosition?.wrappedValue = CGPoint(x: randomX, y: randomY)
        print("New target position set at: \(CGPoint(x: randomX, y: randomY))")
    }
    
    private func endGame() {
        showCameraTargetOverlay?.wrappedValue = false
        showEndGameOverlay?.wrappedValue = true
    }
}
