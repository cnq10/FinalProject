import SwiftUI

struct CharacterListView: View {
    var body: some View {
        ZStack {
            Color.white // White background for readability
                .ignoresSafeArea()

            List(SmashCharacterData.characters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    HStack {
                        Image(character.imageUrl)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(color: Color("light_blue").opacity(0.5), radius: 5, x: 0, y: 5)

                        VStack(alignment: .leading, spacing: 5) {
                            Text(character.name)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("forest_green"))
                            Text(character.series)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                }
                .listRowBackground(Color.white) // Ensure rows have a white background
            }
            .scrollContentBackground(.hidden) // Hides the default list background
            .navigationTitle("Character Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color("forest_green"), for: .navigationBar) // Toolbar matches the theme
        }
    }
}
