import SwiftUI
import AVFoundation

// MARK: - App

/// The App
@main
struct App {
    
    init() {
        // Set the audio session category to playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category.")
        }
    }
}

// MARK: - SwiftUI.App

extension App: SwiftUI.App {
    
    /// The content and behavior of the app
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
