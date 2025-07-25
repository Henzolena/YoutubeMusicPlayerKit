import Foundation

// MARK: - YoutubeMusicPlayerKit+Module+Options

public extension YoutubeMusicPlayerKit.Module {
    
    /// A YouTube player module option.
    struct Option: Hashable, Sendable {
        
        // MARK: Properties
        
        /// The name.
        public let name: String
        
        // MARK: Initializer
        
        /// Creates a new instance of ``YoutubeMusicPlayerKit/Module/Option``
        /// - Parameter name: The name.
        public init(
            name: String
        ) {
            self.name = name
        }
        
    }
    
}

// MARK: - Codable

extension YoutubeMusicPlayerKit.Module.Option: Codable {
    
    /// Creates a new instance of ``YoutubeMusicPlayerKit/Module/Option``
    /// - Parameter decoder: The decoder.
    public init(
        from decoder: Decoder
    ) throws {
        let container = try decoder.singleValueContainer()
        self.init(
            name: try container.decode(String.self)
        )
    }
    
    /// Encode.
    /// - Parameter encoder: The encoder.
    public func encode(
        to encoder: Encoder
    ) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.name)
    }
    
}

// MARK: - ExpressibleByStringLiteral

extension YoutubeMusicPlayerKit.Module.Option: ExpressibleByStringLiteral {
    
    /// Creates a new instance of ``YoutubeMusicPlayerKit/Module/Option``
    /// - Parameter name: The name.
    public init(
        stringLiteral name: String
    ) {
        self.init(
            name: name
        )
    }
    
}

// MARK: - CustomStringConvertible

extension YoutubeMusicPlayerKit.Module.Option: CustomStringConvertible {
    
    /// A textual representation of this instance.
    public var description: String {
        self.name
    }
    
}

// MARK: - Well Known

public extension YoutubeMusicPlayerKit.Module.Option {
    
    /// The captions module font size option.
    static let fontSize: Self = "fontSize"
    
    /// The captions module reload option.
    static let reload: Self = "reload"
    
    /// The captions module track option.
    static let track: Self = "track"
    
    /// The captions module tracklist option.
    static let tracklist: Self = "tracklist"
    
    /// The captions module translation languages option.
    static let translationLanguages: Self = "translationLanguages"
    
}
