//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .foregroundStyle(.yellow)
                
                VStack(alignment: .leading) {
                    Text("Andrew, 12")
                        .font(.custom("Helvetica-Bold", size: 20))
                    
                    HStack {
                        Text("Beginner")
                            .font(.custom("Helvetica-Bold", size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Text("3584")
                    .font(.custom("Helvetica-Bold", size: 22))
                    .foregroundColor(.orange)
                
                Image(systemName: "trophy.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.orange)
            }
        }
        .padding()
    }
}


#Preview {
    ProfileHeaderView()
}
