import SwiftUI

struct CameraTargetOverlayView: View {
    @Binding var targetPosition: CGPoint
    @Binding var handPosition: CGPoint
    @Binding var isTouched: Bool
    @Binding var targetsTouched: Int
    var handPoints: [CGPoint]

    let targetRadius: CGFloat = 50
    var totalTargets: Int

    var body: some View {
        VStack {
            Text("\(targetsTouched)/\(totalTargets) Targets Touched")
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            ZStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: targetRadius * 2, height: targetRadius * 2)
                    .position(targetPosition)
                
                ForEach(0..<handPoints.count, id: \.self) { index in
                    if handPoints[index] != .zero {
                        Circle()
                            .fill(index == 0 ? Color.purple : Color.blue)
                            .frame(width: 50, height: 50)
                            .position(handPoints[index])
                            .onAppear {
                                print("Rendering hand point at index \(index): \(handPoints[index])")
                            }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
