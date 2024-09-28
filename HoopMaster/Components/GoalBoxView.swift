//

import SwiftUI

struct GoalBoxView: View {
    let currentScore: Int
    let totalScore: Int
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Score")
                        .font(.custom("Helvetica", size: 24))
                        .foregroundColor(.black)
                    
                    Text("30 shots")
                        .font(.custom("Helvetica-Bold", size: 26))
                        .foregroundColor(.black)
                    
                    Text("\(currentScore)/\(totalScore)")
                        .font(.custom("Helvetica-Bold", size: 24))
                        .foregroundColor(.orange)
                }
                Spacer()
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(28)
        .shadow(radius: 5)
        .frame(width: 350, height: 180)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    GoalBoxView(currentScore: 12, totalScore: 30, imageName: "TwoWoman1")
}
