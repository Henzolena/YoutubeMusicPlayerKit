import Foundation

// MARK: - YoutubeMusicPlayerKit+PlaybackQuality

public extension YoutubeMusicPlayerKit {
    
    /// The YouTube player playback quality.
    struct PlaybackQuality: Hashable, Sendable {
        
        // MARK: Properties
        
        /// The name.
        public let name: String
        
        // MARK: Initializer
        
        /// Creates a new instance of ``YoutubeMusicPlayerKit/PlaybackQuality``
        /// - Parameter name: The name.
        public init(
            name: String
        ) {
            self.name = name
        }
        
    }
    
}

// MARK: - Codable

extension YoutubeMusicPlayerKit.PlaybackQuality: Codable {
    
    /// Creates a new instance of ``YoutubeMusicPlayerKit/PlaybackQuality``
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

extension YoutubeMusicPlayerKit.PlaybackQuality: ExpressibleByStringLiteral {
    
    /// Creates a new instance of ``YoutubeMusicPlayerKit/PlaybackQuality``
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

extension YoutubeMusicPlayerKit.PlaybackQuality: CustomStringConvertible {
    
    /// A textual representation of this instance.
    public var description: String {
        self.name
    }
    
}

// MARK: - CaseIterable

extension YoutubeMusicPlayerKit.PlaybackQuality: CaseIterable {
    
    /// A collection of all known values of this type.
    public static let allCases: [Self] = [
        .auto,
        .small,
        .medium,
        .large,
        .hd720,
        .hd1080,
        .highResolution,
        .unknown
    ]
    
    /// Automatic.
    public static let auto: Self = "auto"
    
    /// Small.
    public static let small: Self = "small"
    
    /// Medium.
    public static let medium: Self = "medium"
    
    /// Large.
    public static let large: Self = "large"
    
    /// HD 720.
    public static let hd720: Self = "hd720"
    
    /// HD 1080.
    public static let hd1080: Self = "hd1080"
    
    /// High resolution.
    public static let highResolution: Self = "highres"
    
    /// Unknown.
    public static let unknown: Self = "unknown"
    
}
