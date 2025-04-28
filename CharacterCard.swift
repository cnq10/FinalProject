import SwiftUI

struct CharacterCard: View {
    var character: SmashCharacter
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.imageUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 5)
                } else if phase.error != nil {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
            .padding()
            
            Text(character.name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, 5)
            
            Text(character.series)
                .font(.subheadline)
                .foregroundColor(.yellow)
        }
        .frame(width: 150, height: 200)
        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}
