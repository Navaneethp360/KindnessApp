//new xcode project

//Navaneeth P - 2025

import SwiftUI

struct ContentView: View {
    @State private var currentAct = "Tap anywhere for a kind act"
    
    let kindnessActs = [
        "Hold the door open for someone",
        "Compliment a stranger",
        "Send a thank-you message",
        "Help someone carry groceries",
        "Smile at someone",
        "Pick up litter",
        "Call a friend you haven't spoken to in a while"
    ]
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.purple, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Text(currentAct)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
                .transition(.opacity)
                .id(currentAct)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                currentAct = kindnessActs.randomElement() ?? ""
            }
        }
    }
}

#Preview {
    ContentView()
}
