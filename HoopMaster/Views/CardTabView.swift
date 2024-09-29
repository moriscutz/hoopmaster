//

import SwiftUI

struct CardTabView: View {
    @State private var selectedTab = 0
    @State private var isDribblingSelected = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                
                TabView(selection: $selectedTab) {
                    DribblingCardView()
                        .tag(0)
                        .blur(radius: selectedTab == 0 ? 0 : 10)
                        .onTapGesture {
                            isDribblingSelected = true
                        }
                    
                    ShootingCardView()
                        .tag(1)
                        .blur(radius: selectedTab == 1 ? 0 : 10)
                    
                    DuelCardView()
                        .tag(2)
                        .blur(radius: selectedTab == 2 ? 0 : 10)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(width: geometry.size.width, height: geometry.size.height)
                .fullScreenCover(isPresented: $isDribblingSelected) {
                    WarmUpView()
                }
            }
        }
        .frame(height: 300)
    }
}


#Preview {
    CardTabView()
}
