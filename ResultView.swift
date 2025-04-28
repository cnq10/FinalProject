import SwiftUI

struct ResultView: View {
    let topCharacters: [(character: SmashCharacter, matchPercentage: Double)]
    let onRetakeQuiz: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Top Fighters")
                .font(.title)
                .foregroundColor(Color("forest_green"))
                .padding()

            ForEach(topCharacters, id: \.character.id) { result in
                HStack {
                    Image(result.character.imageUrl)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .shadow(radius: 5)

                    VStack(alignment: .leading) {
                        Text(result.character.name)
                            .font(.headline)
                        Text(result.character.series)
                            .font(.subheadline)
                        Text("Match: \(String(format: "%.1f", result.matchPercentage))%")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                .background(Color("light_tan"))
                .cornerRadius(10)
                .shadow(radius: 5)
            }

            Spacer()

            Button(action: onRetakeQuiz) {
                Text("Retake Quiz")
                    .font(.headline)
                    .padding()
                    .background(Color("light_red"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
