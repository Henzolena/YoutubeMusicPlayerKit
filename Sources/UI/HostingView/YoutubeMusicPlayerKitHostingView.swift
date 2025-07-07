#if os(macOS)
import AppKit
#else
import UIKit
#endif

// MARK: - YoutubeMusicPlayerKitHostingBaseView

#if os(macOS)
/// The YoutubeMusicPlayerKitHostingBase NSView
public class YoutubeMusicPlayerKitHostingBaseView: NSView {}
#else
/// The YoutubeMusicPlayerKitHostingBase UIView
public class YoutubeMusicPlayerKitHostingBaseView: UIView {}
#endif

// MARK: - YoutubeMusicPlayerKitHostingView

/// The YouTube player hosting view.
public final class YoutubeMusicPlayerKitHostingView: YoutubeMusicPlayerKitHostingBaseView {
    
    // MARK: Properties
    
    /// The YoutubeMusicPlayerKit
    public let player: YoutubeMusicPlayerKit
    
    // MARK: Initializer
    
    /// Creates a new instance of ``YoutubeMusicPlayerKitHostingView``
    /// - Parameters:
    ///   - player: The YoutubeMusicPlayerKit
    public init(
        player: YoutubeMusicPlayerKit
    ) {
        self.player = player
        super.init(frame: .zero)
        self.addSubview(self.player.webView)
        self.player.webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.player.webView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.player.webView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.player.webView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.player.webView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    /// Initializer with NSCoder is unavailable.
    /// Use `init(player:)`
    @available(*, unavailable)
    public required init?(
        coder aDecoder: NSCoder
    ) { nil }
    
    /// Deinit
    deinit {
        Task { [weak player] in
            try? await player?.pause()
        }
    }
    
}
