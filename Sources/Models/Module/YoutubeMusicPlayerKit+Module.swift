import Foundation

// MARK: - YoutubeMusicPlayerKit+Module

public extension YoutubeMusicPlayerKit {
    
    /// The YouTube player module.
    struct Module: Hashable, Sendable {
        
        // MARK: Properties
        
        /// The name.
        public let name: String
        
        // MARK: Initializer
        
        /// Creates a new instance of ``YoutubeMusicPlayerKit/Module``
        /// - Parameter name: The name.
        public init(
            name: String
        ) {
            self.name = name
        }
        
    }
    
}

// MARK: - Codable

extension YoutubeMusicPlayerKit.Module: Codable {
    
    /// Creates a new instance of ``YoutubeMusicPlayerKit/Module``
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

extension YoutubeMusicPlayerKit.Module: ExpressibleByStringLiteral {
    
    /// Creates a new instance of ``YoutubeMusicPlayerKit/Module``
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

extension YoutubeMusicPlayerKit.Module: CustomStringConvertible {
    
    /// A textual representation of this instance.
    public var description: String {
        self.name
    }
    
}

// MARK: - Well Known

public extension YoutubeMusicPlayerKit.Module {
    
    /// Captions.
    static let captions: Self = "captions"
    
}
