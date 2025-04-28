import SwiftUI

struct CharacterDetailView: View {
    let character: SmashCharacter

    var body: some View {
        ZStack {
            Color("light_tan") // Background color
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    Image(character.imageUrl)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .shadow(color: Color("light_blue").opacity(0.5), radius: 10, x: 0, y: 10)

                    Text(character.name)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color("forest_green"))

                    Text("Series: \(character.series)")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("light_blue"))

                    VStack(alignment: .leading, spacing: 15) {
                        Group {
                            Text("Stats")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(Color("forest_green"))

                            Text("Playstyle: \(character.playstyle)")
                            Text("Size: \(character.size)")
                            Text("Weight: \(character.weight)")
                            Text("Speed: \(character.speed)")
                            Text("Tier Rank: \(character.tierRank)")
                            Text("Unlockable: \(character.unlockable ? "Yes" : "No")")
                        }
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundColor(Color("forest_green"))

                        Group {
                            Text("Signature Move")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(Color("forest_green"))

                            Text(character.signatureMove)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("light_blue"))
                        }

                        Group {
                            Text("Fun Fact")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(Color("forest_green"))

                            Text(character.funFact)
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                .foregroundColor(Color("forest_green"))
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white) // Card background
                            .shadow(color: Color("light_blue").opacity(0.2), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle(character.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color("forest_green"), for: .navigationBar) // Toolbar background
        }
    }
}
