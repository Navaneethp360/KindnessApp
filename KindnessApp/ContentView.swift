import SwiftUI

struct ContentView: View {
    @State private var currentAct = "Tap anywhere for a kind act"
    @State private var colorIndex = 0
    @State private var gradientCenter = CGPoint(x: 0.5, y: 0.5)
    @State private var floatTarget = CGPoint(x: 0.5, y: 0.5)

let kindnessActs = [
    "Hold the door open for someone.",
    "Compliment a stranger's outfit."s,
    "Leave a positive review for a small business you like.",
    "Write a kind note for a coworker.",
    "Pay for the coffee of the person behind you in line.",
    "Leave an extra large tip for good service.",
    "Send a thank-you message to a friend.",
    "Listen intently to a friend who is having a tough day.",
    "Introduce yourself to a new neighbor.",
    "Give up your seat on public transport for someone who needs it more.",
    "Share a funny video to make someone laugh.",
    "Offer to take a photo for a tourist.",
    "Say 'thank you' to a service worker.",
    "Compliment a person on their sense of style.",
    "Let someone with only a few items go ahead of you in the checkout line.",
    "Hold an elevator door for someone.",
    "Write a kind comment on a friend's social media post.",
    "Offer to help a colleague with a simple task.",
    "Be patient with someone who is struggling.",
    "Share a useful skill with someone.",
    "Say a kind word to someone who looks sad.",
    "Be a good sport and give credit to an opponent.",
    "Give away a book you have finished reading.",
    "Let someone go in front of you in a queue.",
    "Leave a kind note on a public mirror.",
    "Help a neighbor carry their groceries.",
    "Donate old clothes or books to a local charity.",
    "Send a postcard to a loved one.",
    "Bring treats to the office or to a school.",
    "Offer a genuine compliment to a stranger.",
    "Write a letter to a family member.",
    "Offer to take a new coworker to lunch.",
    "Write a positive review for a book or movie you enjoyed.",
    "Offer to help a friend or neighbor with a simple errand.",
    "Smile at everyone you see.",
    "Take a moment to listen without judgment.",
    "Give up a great parking spot for someone else.",
    "Leave a water bowl outside for pets on a hot day.",
    "Clean up a mess you didn't make.",
    "Be a mentor to someone, even in a small way.",
    "Send a handwritten letter just to say hello.",
    "Thank a teacher, police officer, or firefighter.",
    "Offer a ride to someone who needs one.",
    "Write a message to a former teacher who impacted you.",
    "Help someone with their luggage.",
    "Offer your jacket to someone who is cold.",
    "Offer a kind word to a person struggling.",
    "Help a family member with a chore they don't enjoy.",
    "Let someone else have the last cookie.",
    "Help someone with their grocery bags.",
    "Help a neighbor with their garbage cans.",
    "Bring a hot meal to someone who is sick.",
    "Offer to walk a friend's dog.",
    "Give a genuine hug to a loved one.",
    "Clean up a public space, like a park.",
    "Donate to a charity you believe in.",
    "Offer a seat to an elderly person on a bench.",
    "Be the last one to leave to help a coworker finish a project.",
    "Bake cookies or a dessert for a neighbor.",
    "Offer a ride to a friend who needs one.",
    "Send a postcard to a friend you haven't seen in a while.",
    "Leave an uplifting message on a sticky note for a stranger.",
    "Leave a flower on a stranger's car.",
    "Send a text to an old friend to tell them you're thinking of them.",
    "Offer a simple apology, even if you weren't entirely at fault.",
    "Leave a good book in a public space with a note to pass it on.",
    "Offer to assist someone with their luggage at an airport or train station."
];
    
    let colorSets: [[Color]] = [
        [.red.opacity(1.0), .red.opacity(0.8), .red.opacity(0.6), .red.opacity(0.4), .red.opacity(0.2), .black],
        [.blue.opacity(1.0), .blue.opacity(0.8), .blue.opacity(0.6), .blue.opacity(0.4), .blue.opacity(0.2), .black],
        [.purple.opacity(1.0), .purple.opacity(0.8), .purple.opacity(0.6), .purple.opacity(0.4), .purple.opacity(0.2), .black],
        [.green.opacity(1.0), .green.opacity(0.8), .green.opacity(0.6), .green.opacity(0.4), .green.opacity(0.2), .black],
        [.orange.opacity(1.0), .orange.opacity(0.8), .orange.opacity(0.6), .orange.opacity(0.4), .orange.opacity(0.2), .black],
        [.pink.opacity(1.0), .pink.opacity(0.8), .pink.opacity(0.6), .pink.opacity(0.4), .pink.opacity(0.2), .black]
    ]
    
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: colorSets[colorIndex]),
                center: UnitPoint(x: gradientCenter.x, y: gradientCenter.y),
                startRadius: 100,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            ParticleField()
                .ignoresSafeArea()
            
            Text(currentAct)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.85))
                .multilineTextAlignment(.center)
                .padding()
        }
        .onReceive(timer) { _ in
            updateGradientCenter()
        }
        .onTapGesture {
            currentAct = kindnessActs.randomElement() ?? ""
            colorIndex = (colorIndex + 1) % colorSets.count
            
            // Set a new float target for tap
            floatTarget = CGPoint(x: CGFloat.random(in: 0.0...1.0),
                                  y: CGFloat.random(in: 0.0...1.0))
        }
    }
    
    private func updateGradientCenter() {
        // Smooth interpolation towards the target
        let dx = (floatTarget.x - gradientCenter.x) * 0.005
        let dy = (floatTarget.y - gradientCenter.y) * 0.005
        gradientCenter.x += dx
        gradientCenter.y += dy
        
        // Pick a new random float target once we are close
        if abs(gradientCenter.x - floatTarget.x) < 0.001 &&
           abs(gradientCenter.y - floatTarget.y) < 0.001 {
            floatTarget = CGPoint(x: CGFloat.random(in: 0.0...1.0),
                                  y: CGFloat.random(in: 0.0...1.0))
        }
    }
}

// MARK: - Particle Field
struct ParticleField: View {
    let particleCount = 150
    let maxSize: CGFloat = 4
    
    var body: some View {
        GeometryReader { geo in
            Canvas { context, size in
                for _ in 0..<particleCount {
                    let x = CGFloat.random(in: 0...size.width)
                    let y = CGFloat.random(in: 0...size.height)
                    let particleSize = CGFloat.random(in: 1...maxSize)
                    let opacity = Double.random(in: 0.6...1.0)
                    context.fill(
                        Path(ellipseIn: CGRect(x: x, y: y, width: particleSize, height: particleSize)),
                        with: .color(.white.opacity(opacity))
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
