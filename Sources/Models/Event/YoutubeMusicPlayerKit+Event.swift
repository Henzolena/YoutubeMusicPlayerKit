import Foundation

// MARK: - YoutubeMusicPlayerKit+Event

public extension YoutubeMusicPlayerKit {
    
    /// A YoutubeMusicPlayerKit event.
    struct Event: Codable, Hashable, Sendable {
        
        // MARK: Properties
        
        /// The name.
        public var name: Name
        
        /// The data.
        public var data: Data?
        
        // MARK: Initializer
        
        /// Creates a new instance of ``YoutubeMusicPlayerKit/Event``
        /// - Parameters:
        ///   - name: The name.
        ///   - data: The data. Default value `nil`
        public init(
            name: Name,
            data: Data? = nil
        ) {
            self.name = name
            self.data = data
        }
        
    }
    
}

// MARK: - CustomStringConvertible

extension YoutubeMusicPlayerKit.Event: CustomStringConvertible {
    
    /// A textual representation of this instance.
    public var description: String {
        """
        Name: \(self.name.rawValue)
        Data: \(self.data?.value ?? "nil")
        """
    }
    
}
