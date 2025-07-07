import Combine
import Foundation
import OSLog

// MARK: - Event Publisher

public extension YoutubeMusicPlayerKit {
    
    /// A Publisher that emits a received ``YoutubeMusicPlayerKit/Event``
    var eventPublisher: some Publisher<Event, Never> {
        self.webView
            .eventSubject
            .compactMap(\.playerEvent)
            .receive(on: DispatchQueue.main)
    }
    
}

// MARK: - Evaluate

public extension YoutubeMusicPlayerKit {
    
    /// Evaluates the JavaScript and converts its response.
    /// - Parameters:
    ///   - javaScript: The JavaScript to evaluate.
    ///   - converter: The response converter.
    func evaluate<Response>(
        javaScript: JavaScript,
        converter: JavaScriptEvaluationResponseConverter<Response>
    ) async throws(APIError) -> Response {
        try await self.webView.evaluate(
            javaScript: javaScript,
            converter: converter
        )
    }
    
    /// Evaluates the JavaScript.
    /// - Parameter javaScript: The JavaScript to evaluate.
    func evaluate(
        javaScript: JavaScript
    ) async throws(APIError) {
        try await self.evaluate(
            javaScript: javaScript,
            converter: .void
        )
    }
    
}

// MARK: - Reload

public extension YoutubeMusicPlayerKit {
    
    /// Reloads the YouTube player.
    func reload() async throws(Swift.Error) {
        // Destroy the player and discard the error
        try? await self.evaluate(
            javaScript: .youTubePlayer(
                functionName: "destroy"
            )
        )
        // Send idle state
        self.stateSubject.send(.idle)
        // Reload
        try self.webView.load()
        // Await new ready or error state
        for await state in self.stateSubject.dropFirst().values {
            // Swithc on state
            switch state {
            case .ready:
                // Success return out of function
                return
            case .error(let error):
                // Throw error
                throw error
            default:
                // Continue with next state
                continue
            }
        }
    }
    
}

// MARK: - Logger

public extension YoutubeMusicPlayerKit {
    
    /// Returns a new logger instance if logging is enabled via ``YoutubeMusicPlayerKit/isLoggingEnabled``
    func logger() -> Logger? {
        guard self.isLoggingEnabled else {
            return nil
        }
        return .init(
            subsystem: "YoutubeMusicPlayerKit",
            category: .init(describing: self.id)
        )
    }
    
}
