//

import SwiftUI

struct TrainingDaysScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                TrainingDayCardView(day: "Monday", timeSpent: "20:13", pointsMade: 251)
                TrainingDayCardView(day: "Tuesday", timeSpent: "20:13", pointsMade: 251)
                TrainingDayCardView(day: "Wednesday", timeSpent: "20:13", pointsMade: 251)
            }
            .padding()
        }
    }
}


#Preview {
    TrainingDaysScrollView()
}
