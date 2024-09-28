//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProfileHeaderView()
            
            VStack(alignment: .leading) {
                Text("Training days")
                    .font(.custom("Helvetica-Bold", size: 22))
                    .foregroundColor(.black)
                    .padding(.horizontal)

                TrainingDaysScrollView()
            }
            
            Spacer()
            
            BottomNavigationBarView() 
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
#Preview {
    ProfileView()
}
