import SwiftUI

// MARK: - YoutubeMusicPlayerKitView

/// The YouTube player SwiftUI view.
public struct YoutubeMusicPlayerKitView<Overlay: View> {
    
    // MARK: Properties
    
    /// The ``YoutubeMusicPlayerKit``.
    public let player: YoutubeMusicPlayerKit
    
    /// The The transaction to use when the ``YoutubeMusicPlayerKit/State`` changes.
    public let transaction: Transaction
    
    /// A closure which constructs the `Overlay` for a given state.
    public let overlay: (YoutubeMusicPlayerKit.State) -> Overlay
    
    /// The current ``YoutubeMusicPlayerKit/State``
    @State
    private var state: YoutubeMusicPlayerKit.State = .idle
    
    // MARK: Initializer
    
    /// Creates a new instance of ``YoutubeMusicPlayerKitView``
    /// - Parameters:
    ///   - player: The ``YoutubeMusicPlayerKit``.
    ///   - transaction: The transaction to use when the state changes. Default value `.init()`
    ///   - overlay: A view builder closure to construct an `Overlay` for the given state.
    public init(
        _ player: YoutubeMusicPlayerKit,
        transaction: Transaction = .init(),
        @ViewBuilder
        overlay: @escaping (YoutubeMusicPlayerKit.State) -> Overlay
    ) {
        self.player = player
        self.transaction = transaction
        self.overlay = overlay
    }
    
}

// MARK: - View

extension YoutubeMusicPlayerKitView: View {
    
    /// The content and behavior of the view.
    public var body: some View {
        YoutubeMusicPlayerKitWebView.Representable(
            player: self.player
        )
        .overlay(
            self.overlay(self.state)
        )
        .onReceive(
            self.player.statePublisher
        ) { state in
            withTransaction(self.transaction) {
                self.state = state
            }
        }
    }
    
}

// MARK: - YoutubeMusicPlayerKitWebView+Representable

private extension YoutubeMusicPlayerKitWebView {
    
    #if !os(macOS)
    /// The YoutubeMusicPlayerKit UIView SwiftUI Representable
    struct Representable: UIViewRepresentable {
        
        /// The YouTube Player
        let player: YoutubeMusicPlayerKit
        
        /// Make YoutubeMusicPlayerKitWebView
        /// - Parameter context: The Context
        /// - Returns: The YoutubeMusicPlayerKitWebView
        func makeUIView(
            context: Context
        ) -> YoutubeMusicPlayerKitWebView {
            self.player.webView
        }
        
        /// Update YoutubeMusicPlayerKitWebView
        /// - Parameters:
        ///   - playerWebView: The YoutubeMusicPlayerKitWebView
        ///   - context: The Context
        func updateUIView(
            _ playerWebView: YoutubeMusicPlayerKitWebView,
            context: Context
        ) {}
        
        /// Dismantle YoutubeMusicPlayerKitWebView
        /// - Parameters:
        ///   - playerWebView: The YoutubeMusicPlayerKitWebView
        ///   - coordinator: The Coordinaotr
        static func dismantleUIView(
            _ playerWebView: YoutubeMusicPlayerKitWebView,
            coordinator: Void
        ) {
            Task { [weak playerWebView] in
                try? await playerWebView?.player?.pause()
            }
        }
        
    }
    #else
    /// The YoutubeMusicPlayerKit NSView SwiftUI Representable
    struct Representable: NSViewRepresentable {
        
        /// The YouTube Player
        let player: YoutubeMusicPlayerKit
        
        /// Make YoutubeMusicPlayerKitWebView
        /// - Parameter context: The Context
        /// - Returns: The YoutubeMusicPlayerKitWebView
        func makeNSView(
            context: Context
        ) -> YoutubeMusicPlayerKitWebView {
            self.player.webView
        }
        
        /// Update YoutubeMusicPlayerKitWebView
        /// - Parameters:
        ///   - playerWebView: The YoutubeMusicPlayerKitWebView
        ///   - context: The Context
        func updateNSView(
            _ playerWebView: YoutubeMusicPlayerKitWebView,
            context: Context
        ) {}
        
        /// Dismantle YoutubeMusicPlayerKitWebView
        /// - Parameters:
        ///   - playerWebView: The YoutubeMusicPlayerKitWebView
        ///   - coordinator: The Coordinaotr
        static func dismantleNSView(
            _ playerWebView: YoutubeMusicPlayerKitWebView,
            coordinator: Void
        ) {
            Task { [weak playerWebView] in
                try? await playerWebView?.player?.pause()
            }
        }
        
    }
    #endif
    
}
