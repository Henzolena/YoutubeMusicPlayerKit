import Foundation

// MARK: - YoutubeMusicPlayerKitWebView+Event

extension YoutubeMusicPlayerKitWebView {
    
    /// A YoutubeMusicPlayerKitWebView Event
    enum Event: Sendable {
        /// Received ``YoutubeMusicPlayerKit/Event``
        case receivedPlayerEvent(YoutubeMusicPlayerKit.Event)
        /// Did fail provisional navigation
        case didFailProvisionalNavigation(Error)
        /// Did fail navigation
        case didFailNavigation(Error)
        /// Web content process did terminate
        case webContentProcessDidTerminate
    }
    
}

// MARK: - Player Event

extension YoutubeMusicPlayerKitWebView.Event {
    
    /// The received ``YoutubeMusicPlayerKit/Event``, if available.
    var playerEvent: YoutubeMusicPlayerKit.Event? {
        if case .receivedPlayerEvent(let playerEvent) = self {
            return playerEvent
        } else {
            return nil
        }
    }
    
}
