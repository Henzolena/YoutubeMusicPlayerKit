#if os(macOS)
import AppKit
#else
import UIKit
#endif

// MARK: - YoutubeMusicPlayerKit+OpenURLAction

public extension YoutubeMusicPlayerKit {
    
    /// A YouTube player open url action.
    struct OpenURLAction: Sendable {
        
        // MARK: Typealias
        
        /// An OpenURLAction Handler typealias representing a closure
        /// which takes in a URL which should be opened
        public typealias Handler = @MainActor (URL, YoutubeMusicPlayerKit) async -> Void
        
        // MARK: Properties
        
        /// The Handler
        private let handler: Handler
        
        // MARK: Initializer
        
        /// Creates a new instance of ``YoutubeMusicPlayerKit/OpenURLAction``
        /// - Parameter handler: The handler closure which takes in a URL which should be opened
        public init(
            handler: @escaping Handler
        ) {
            self.handler = handler
        }
        
    }
    
}

// MARK: - Call as Function

public extension YoutubeMusicPlayerKit.OpenURLAction {
    
    /// Opens the URL.
    /// - Parameters:
    ///   - url: The URL to open.
    ///   - player: The ``YoutubeMusicPlayerKit`` instance.
    func callAsFunction(
        url: URL,
        player: YoutubeMusicPlayerKit
    ) async {
        await self.handler(url, player)
    }
    
}

// MARK: - Equatable

extension YoutubeMusicPlayerKit.OpenURLAction: Equatable {
    
    /// Returns a Boolean value indicating whether two `YoutubeMusicPlayerKit.State` are equal
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (
        lhs: Self,
        rhs: Self
    ) -> Bool {
        true
    }
    
}

// MARK: - Hashable

extension YoutubeMusicPlayerKit.OpenURLAction: Hashable {
    
    /// Hashes the essential components of this value by feeding them into the given hasher.
    /// - Parameter hasher: The hasher to use when combining the components of this instance.
    public func hash(
        into hasher: inout Hasher
    ) {}
    
}

// MARK: - Default

public extension YoutubeMusicPlayerKit.OpenURLAction {
    
    /// The default OpenURLAction
    static let `default` = Self { url, player in
        // Check if YouTube player source can be initialize from url
        // and it was successfully loaded
        if let source = YoutubeMusicPlayerKit.Source(url: url),
           (try? await player.load(source: source)) != nil  {
            // Return out of function
            return
        }
        // Open url externally
        #if os(macOS)
        _ = try? await NSWorkspace
            .shared
            .open(
                url,
                configuration: .init()
            )
        #else
        await UIApplication.shared.open(url)
        #endif
    }
    
}
