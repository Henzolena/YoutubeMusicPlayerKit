#if os(macOS)
import AppKit
#else
import UIKit
#endif

// MARK: - YoutubeMusicPlayerKitBaseViewController

#if os(macOS)
/// The YoutubeMusicPlayerKitBase NSViewController
public class YoutubeMusicPlayerKitBaseViewController: NSViewController {}
#else
/// The YoutubeMusicPlayerKitBase UIViewController
public class YoutubeMusicPlayerKitBaseViewController: UIViewController {}
#endif

// MARK: - YoutubeMusicPlayerKitViewController

/// The YouTube player view controller.
public final class YoutubeMusicPlayerKitViewController: YoutubeMusicPlayerKitBaseViewController {
    
    // MARK: Properties
    
    /// The YoutubeMusicPlayerKit
    public let player: YoutubeMusicPlayerKit
    
    // MARK: Initializer
    
    /// Creates a new instance of ``YoutubeMusicPlayerKitViewController``
    /// - Parameters:
    ///   - player: The YoutubeMusicPlayerKit
    public init(
        player: YoutubeMusicPlayerKit
    ) {
        self.player = player
        super.init(nibName: nil, bundle: nil)
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
    
    // MARK: View-Lifecycle
    
    /// View did load
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.player.webView)
        self.player.webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.player.webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.player.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.player.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.player.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
}
