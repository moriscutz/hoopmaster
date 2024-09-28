//

import SwiftUI

struct BottomNavigationBarView: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "person.3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding()

            Spacer()

            Image(systemName: "house.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:70, height: 70)
                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .white)
            Spacer()

            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding()

            Spacer()
        }
        .frame(height: 70)
        .background(Color.white)
        .shadow(radius: 10)
    }
}


#Preview {
    BottomNavigationBarView()
}
