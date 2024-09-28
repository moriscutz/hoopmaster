//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            TopBarView()
            
            ScrollView {
                VStack(spacing: 20) {
                    CardTabView()
                }
                .padding()
            }
            
            Spacer()

            BottomNavigationBarView()
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color(.systemGray6))
    }
}

#Preview {
    ContentView()
}
