//

import SwiftUI

struct DribblingCardView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Dribbling")
                    .font(.custom("Helvetica-Bold", size: 24))
                    .foregroundColor(.black)
                Spacer()
            }
            HStack {
                ProgressView(value: 0.4)
                    .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                    .frame(width: 150)
                Spacer()
                Image("Woman1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding()
    }
}

struct ShootingCardView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Shooting")
                    .font(.custom("Helvetica-Bold", size: 24))
                    .foregroundColor(.black)
                Spacer()
            }
            HStack {
                ProgressView(value: 0.6)
                    .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                    .frame(width: 150)
                Spacer()
                Image("Woman2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding()
    }
}

struct DuelCardView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Duel")
                    .font(.custom("Helvetica-Bold", size: 24))
                    .foregroundColor(.black)
                Spacer()
            }
            HStack {
                Text("Challenge a friend or battle with a random player")
                    .font(.custom("Helvetica", size: 18))
                    .foregroundColor(.black)
                Spacer()
                Image("TwoMen1") 
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding()
    }
}

#Preview {
    DribblingCardView()
}
