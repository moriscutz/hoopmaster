//

import SwiftUI

struct TrainingDayCardView: View {
    var day: String
    var timeSpent: String
    var pointsMade: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(day)
                .font(.custom("Helvetica-Bold", size: 18))
                .foregroundColor(.black)
            
            VStack(alignment: .leading) {
                Text("Time spent:")
                    .font(.custom("Helvetica", size: 14))
                    .foregroundColor(.black)
                Text(timeSpent)
                    .font(.custom("Helvetica-Bold", size: 16))
                    .foregroundColor(.black)
                
                Text("Points made:")
                    .font(.custom("Helvetica", size: 14))
                    .foregroundColor(.black)
                Text("\(pointsMade)")
                    .font(.custom("Helvetica-Bold", size: 16))
                    .foregroundColor(.black)
            }
        }
        .padding()
        .frame(width: 120, height: 150)
        .background(Color.orange.opacity(0.8))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}


#Preview {
    TrainingDayCardView(day: "Monday", timeSpent: "20:13", pointsMade: 251)
}
