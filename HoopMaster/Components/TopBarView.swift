//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Text("Goals")
                    .font(.custom("Helvetica-Bold", size: 40))
                    .foregroundColor(.black)
                    .position(x:70, y:30)
                
                Spacer()
            }
            .padding(.top, 40)
            HStack {
                Spacer()
                GoalBoxView(currentScore: 12, totalScore: 30, imageName: "TwoWoman1")
                    .frame(width: 300, height: 180)
                Spacer()
            }
            .padding(.top, 20)
        }
        .frame(height: 280)
        .background(Color.yellow)
        .cornerRadius(40, corners: [.bottomLeft, .bottomRight]) 
        .padding(.bottom, 10)
    }
}



#Preview {
    TopBarView()
}
