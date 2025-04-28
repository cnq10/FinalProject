import SwiftUI

struct QuizView: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswers: [String] = []
    @State private var showResult = false
    @State private var topCharacters: [(character: SmashCharacter, matchPercentage: Double)] = []

    let questions: [QuizQuestion] = [
        QuizQuestion(
            question: "What kind of playstyle do you prefer?",
            options: ["Tricky", "Heavy", "Speed", "All-Rounder", "Zoner", "Grappler"]
        ),
        QuizQuestion(
            question: "Do you prefer speed or power?",
            options: ["Speed", "Power", "A mix of both"]
        ),
        QuizQuestion(
            question: "What is your favorite series?",
            options: [
                "Super Mario", "The Legend of Zelda", "Metroid", "Donkey Kong",
                "Star Fox", "Pokémon", "Kirby", "Fire Emblem", "Kid Icarus",
                "Street Fighter", "Final Fantasy", "Persona", "Minecraft",
                "Sonic the Hedgehog", "Bayonetta", "Duck Hunt", "Animal Crossing",
                "EarthBound" // Added for Ness and Lucas
            ]
        ),
        QuizQuestion(
            question: "Do you like projectile-based characters?",
            options: ["Yes", "No", "Sometimes"]
        ),
        QuizQuestion(
            question: "What is your experience level?",
            options: ["Beginner", "Intermediate", "Expert"]
        ),
        QuizQuestion(
            question: "What character size do you prefer?",
            options: ["Small", "Medium", "Large"]
        ),
        QuizQuestion(
            question: "Do you want a DLC character?",
            options: ["Yes", "No", "Doesn't matter"]
        )
    ]

    var body: some View {
        VStack {
            if showResult {
                ResultView(
                    topCharacters: topCharacters,
                    onRetakeQuiz: resetQuiz
                )
            } else {
                VStack(spacing: 20) {
                    Text(questions[currentQuestionIndex].question)
                        .font(.title2)
                        .foregroundColor(Color("forest_green"))
                        .padding()

                    if questions[currentQuestionIndex].question == "What is your favorite series?" {
                        VStack(spacing: 10) {
                            // First three series as visible buttons
                            ForEach(["Super Mario", "Pokémon", "The Legend of Zelda"], id: \.self) { option in
                                Button(action: {
                                    handleAnswer(option)
                                }) {
                                    Text(option)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color("steel_navy_blue"))
                                        .cornerRadius(10)
                                }
                            }

                            // Dropdown for the rest
                            Menu {
                                ForEach(questions[currentQuestionIndex].options.filter {
                                    !["Super Mario", "Pokémon", "The Legend of Zelda"].contains($0)
                                }, id: \.self) { option in
                                    Button(action: {
                                        handleAnswer(option)
                                    }) {
                                        Text(option)
                                    }
                                }
                            } label: {
                                Text("More Series")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color("steel_navy_blue"))
                                    .cornerRadius(10)
                            }
                        }
                    } else {
                        ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                            Button(action: {
                                handleAnswer(option)
                            }) {
                                Text(option)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color("steel_navy_blue"))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color.white.ignoresSafeArea())
    }

    private func handleAnswer(_ answer: String) {
        selectedAnswers.append(answer)
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            calculateResult()
            showResult = true
        }
    }

    private func resetQuiz() {
        currentQuestionIndex = 0
        selectedAnswers.removeAll()
        topCharacters.removeAll()
        showResult = false
    }

    private func calculateResult() {
        guard selectedAnswers.count == questions.count else { return }

        let playstylePref   = selectedAnswers[0]
        let speedPowerPref  = selectedAnswers[1]
        let seriesPref      = selectedAnswers[2]
        let likesProjectiles = selectedAnswers[3] == "Yes"
        let experiencePref  = selectedAnswers[4]
        let sizePref        = selectedAnswers[5]
        let tierPref        = selectedAnswers[6]

        let totalCriteria = 7

        let results = SmashCharacterData.characters.map { char -> (SmashCharacter, Double) in
            var matchCount = 0

            if char.playstyle == playstylePref { matchCount += 1 }

            switch speedPowerPref {
            case "Speed":
                if char.speed >= 8 { matchCount += 1 }
            case "Power":
                if char.weight == "Heavy" { matchCount += 1 }
            default:
                if (5...7).contains(char.speed) && char.weight == "Mid" { matchCount += 1 }
            }

            if char.series == seriesPref { matchCount += 1 }

            if likesProjectiles == char.hasProjectiles { matchCount += 1 }

            if char.difficulty == experiencePref { matchCount += 1 }

            if char.size == sizePref { matchCount += 1 }

            switch tierPref {
            case "Yes":
                if ["S", "A"].contains(char.tierRank) { matchCount += 1 }
            case "No":
                if ["B", "C", "D"].contains(char.tierRank) { matchCount += 1 }
            default:
                matchCount += 1
            }

            let percentage = (Double(matchCount) / Double(totalCriteria)) * 100
            return (char, percentage)
        }

        topCharacters = results
            .sorted { $0.1 > $1.1 }
            .prefix(3)
            .map { ($0.0, $0.1) }
    }
}
