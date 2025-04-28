import Foundation

class CharacterViewModel: ObservableObject {
    @Published var characters: [SmashCharacter] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    func fetchCharacters() {
        // Simulate loading state
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.characters = SmashCharacterData.characters
        }
    }
}
