import SwiftUI

struct HomeView: View {
    @State private var ballPosition = CGSize.zero

    var body: some View {
        NavigationView {
            ZStack {
                // White Background
                Color.white
                    .ignoresSafeArea()

                VStack(spacing: 40) {
                    // Floating Smash Ball
                    Image("smash_ball")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .offset(ballPosition)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                                ballPosition = CGSize(width: 40, height: -40)
                            }
                        }

                    // App Title and Tagline (No background color)
                    VStack(spacing: 8) {
                        Text("Smash Main")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(Color("forest_green"))

                        Text("Find your perfect fighter.")
                            .font(.title3)
                            .foregroundColor(Color("light_blue"))
                    }

                    // Navigation Buttons
                    VStack(spacing: 20) {
                        NavigationLink(destination: QuizView()) {
                            HomeButton(title: "Find Your Main", color: Color("light_blue"))
                        }

                        NavigationLink(destination: CharacterListView()) {
                            HomeButton(title: "Character Log", color: Color("light_tan"))
                        }

                        NavigationLink(destination: Text("Tier Lists Coming Soon!")) {
                            HomeButton(title: "Tier Lists", color: Color("light_orange"))
                        }

                        NavigationLink(destination: Text("Settings Coming Soon!")) {
                            HomeButton(title: "Settings", color: Color("steel_navy_blue"))
                        }
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeButton: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: color.opacity(0.6), radius: 5, x: 0, y: 5)
    }
}
