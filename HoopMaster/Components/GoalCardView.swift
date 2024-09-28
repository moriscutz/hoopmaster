//

import SwiftUI

struct GoalCardView: View {
    let title: String
    let currentScore: Int
    let totalScore: Int
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Helvetica-Bold", size: 24))
                .foregroundColor(.black)
            HStack {
                VStack(alignment: .leading) {
                    Text("Score")
                        .font(.custom("Helvetica", size: 18))
                        .foregroundColor(.black)
                    Text("\(currentScore)/\(totalScore)")
                        .font(.custom("Helvetica-Bold", size: 18))
                        .foregroundColor(.orange)
                }
                Spacer()
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
#Preview {GoalCardView(title: "Test", currentScore: 10, totalScore: 100, imageName: "TwoWoman1")}
