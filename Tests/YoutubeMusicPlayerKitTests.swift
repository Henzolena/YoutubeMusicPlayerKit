import Testing
import Foundation
@testable import YoutubeMusicPlayerKitKit

@MainActor
struct YoutubeMusicPlayerKitTests {
    
    @Test
    func customInitialization() async {
        let source: YoutubeMusicPlayerKit.Source = .video(id: UUID().uuidString)
        let parameters = YoutubeMusicPlayerKit.Parameters(
            autoPlay: .random(),
            loopEnabled: .random(),
            startTime: Bool.random() ? .init(value: .random(in: 1...10), unit: .seconds) : nil,
            endTime: Bool.random() ? .init(value: .random(in: 40...60), unit: .seconds) : nil,
            showControls: .random(),
            showFullscreenButton: .random(),
            progressBarColor: YoutubeMusicPlayerKit.Parameters.ProgressBarColor.allCases.randomElement(),
            keyboardControlsDisabled: .random(),
            language: UUID().uuidString,
            captionLanguage: UUID().uuidString,
            showCaptions: .random(),
            restrictRelatedVideosToSameChannel: .random(),
            originURL: Bool.random() ? .init(string: "https://\(UUID().uuidString)") : nil,
            referrerURL: Bool.random() ? .init(string: "https://\(UUID().uuidString)") : nil
        )
        let configuration = YoutubeMusicPlayerKit.Configuration(
            fullscreenMode: YoutubeMusicPlayerKit.FullscreenMode.allCases.randomElement() ?? .system,
            allowsInlineMediaPlayback: .random(),
            allowsPictureInPictureMediaPlayback: .random(),
            useNonPersistentWebsiteDataStore: .random(),
            automaticallyAdjustsContentInsets: .random(),
            customUserAgent: UUID().uuidString,
            openURLAction: .default
        )
        let isLoggingEnabled: Bool = .random()
        let youTubePlayer = YoutubeMusicPlayerKit(
            source: source,
            parameters: parameters,
            configuration: configuration,
            isLoggingEnabled: isLoggingEnabled
        )
        #expect(youTubePlayer.source == source)
        #expect(youTubePlayer.parameters == parameters)
        #expect(youTubePlayer.configuration == configuration)
        #expect(youTubePlayer.isLoggingEnabled == isLoggingEnabled)
        #expect(youTubePlayer.state == .idle)
        #expect(youTubePlayer.playbackState == nil)
    }
    
    @Test
    func stringLiteralInitialization() async {
        let videoID = UUID().uuidString
        let youTubePlayer = YoutubeMusicPlayerKit(stringLiteral: "https://youtube.com/watch?v=\(videoID)")
        #expect(youTubePlayer.source == .video(id: videoID))
        #expect(youTubePlayer.parameters == .init())
        #expect(youTubePlayer.configuration == .init())
        #expect(!youTubePlayer.isLoggingEnabled)
    }
    
}
