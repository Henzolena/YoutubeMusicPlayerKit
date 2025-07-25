import Testing
import Foundation
@testable import YoutubeMusicPlayerKit

struct YoutubeMusicPlayerKitJavaScriptTests {
    
    @Test
    func emptyInitializer() {
        let javaScript = YoutubeMusicPlayerKit.JavaScript()
        #expect(javaScript.content().isEmpty)
        #expect(javaScript.description.isEmpty)
    }
    
    @Test
    func designatedInitializer() {
        let javaScriptCode = "const x = 1;"
        let javaScript = YoutubeMusicPlayerKit.JavaScript(javaScriptCode)
        #expect(javaScript.content() == javaScriptCode)
        #expect(javaScript.description == javaScriptCode)
    }
    
    @Test
    func statementTerminatorNormalization() {
        #expect(
            YoutubeMusicPlayerKit.JavaScript("const x = 1").content() == "const x = 1;"
        )
        #expect(
            YoutubeMusicPlayerKit.JavaScript("const x = 1;").content() == "const x = 1;"
        )
        #expect(
            YoutubeMusicPlayerKit.JavaScript("const x = 1;;;").content() == "const x = 1;"
        )
        #expect(
            YoutubeMusicPlayerKit.JavaScript("const x = 1;  \n  ;;  ").content() == "const x = 1;"
        )
    }
    
    @Test
    func variableInterpolation() {
        let youTubePlayerVariableName = UUID().uuidString
        let functionName = UUID().uuidString
        let javaScript: YoutubeMusicPlayerKit.JavaScript = "\(.youTubePlayer).\(functionName)()"
        #expect(
            javaScript.content(variableNames: [.youTubePlayer: youTubePlayerVariableName])
            ==
            "\(youTubePlayerVariableName).\(functionName)();"
        )
    }
    
    @Test
    func multipleVariableInterpolations() {
        let youTubePlayerVariableName = UUID().uuidString
        let javaScript: YoutubeMusicPlayerKit.JavaScript = """
        \(.youTubePlayer).play();
        \(.youTubePlayer).pause();
        """
        #expect(
            javaScript.content(variableNames: [.youTubePlayer: youTubePlayerVariableName])
            ==
            """
            \(youTubePlayerVariableName).play();
            \(youTubePlayerVariableName).pause();
            """
        )
    }
    
    @Test
    func youTubePlayerOperator() {
        let youTubePlayerVariableName = UUID().uuidString
        let functionName = UUID().uuidString
        #expect(
            YoutubeMusicPlayerKit
                .JavaScript
                .youTubePlayer(operator: "\(functionName)()")
                .content(variableNames: [.youTubePlayer: youTubePlayerVariableName])
            ==
            "\(youTubePlayerVariableName).\(functionName)();"
        )
    }
    
    @Test
    func youTubePlayerFunctionWithoutParameters() {
        let youTubePlayerVariableName = UUID().uuidString
        let functionName = UUID().uuidString
        #expect(
            YoutubeMusicPlayerKit
                .JavaScript
                .youTubePlayer(functionName: functionName)
                .content(variableNames: [.youTubePlayer: youTubePlayerVariableName])
            ==
            "\(youTubePlayerVariableName).\(functionName)();"
        )
    }
    
    @Test
    func youTubePlayerFunctionWithParameters() {
        let youTubePlayerVariableName = UUID().uuidString
        let functionName = UUID().uuidString
        let parameter = UUID().uuidString
        #expect(
            YoutubeMusicPlayerKit
                .JavaScript
                .youTubePlayer(functionName: functionName, parameters: [parameter])
                .content(variableNames: [.youTubePlayer: youTubePlayerVariableName])
            ==
            "\(youTubePlayerVariableName).\(functionName)(\(parameter));"
        )
    }
    
    @Test
    func youTubePlayerFunctionWithMultipleParameters() {
        let youTubePlayerVariableName = UUID().uuidString
        let functionName = UUID().uuidString
        let parameters = [String](repeating: UUID().uuidString, count: .random(in: 2...5))
        #expect(
            YoutubeMusicPlayerKit
                .JavaScript
                .youTubePlayer(functionName: functionName, parameters: parameters)
                .content(variableNames: [.youTubePlayer: youTubePlayerVariableName])
            ==
            "\(youTubePlayerVariableName).\(functionName)(\(parameters.joined(separator: ", ")));"
        )
    }
    
    @Test
    func youTubePlayerFunctionWithEncodableParameter() throws {
        struct Parameter: Encodable {
            var example1: Bool = .random()
            var example2: Bool = .random()
        }
        let jsonEncoder: JSONEncoder = {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
            return jsonEncoder
        }()
        let functionName = UUID().uuidString
        let parameter = Parameter()
        let parameterJSONString = String(
            decoding: try jsonEncoder.encode(parameter),
            as: UTF8.self
        )
        let javaScript = try YoutubeMusicPlayerKit.JavaScript.youTubePlayer(
            functionName: functionName,
            jsonParameter: parameter,
            jsonEncoder: jsonEncoder
        )
        let youTubePlayerVariableName = UUID().uuidString
        #expect(
            javaScript.content(variableNames: [.youTubePlayer: youTubePlayerVariableName])
            ==
            """
            \(youTubePlayerVariableName).\(functionName)(\(parameterJSONString));
            """
        )
    }
    
    @Test
    func ignoreReturnValue() {
        let youTubePlayerVariableName = UUID().uuidString
        let functionName = UUID().uuidString
        #expect(
            YoutubeMusicPlayerKit
                .JavaScript
                .youTubePlayer(functionName: functionName)
                .ignoreReturnValue()
                .content(variableNames: [.youTubePlayer: youTubePlayerVariableName])
            ==
            """
            \(youTubePlayerVariableName).\(functionName)(); null;
            """
        )
    }
    
    @Test
    func immediatelyInvokedFunctionExpression() {
        let youTubePlayerVariableName = UUID().uuidString
        let functionName = UUID().uuidString
        #expect(
            YoutubeMusicPlayerKit
                .JavaScript
                .youTubePlayer(functionName: functionName)
                .asImmediatelyInvokedFunctionExpression()
                .content(variableNames: [.youTubePlayer: youTubePlayerVariableName])
            ==
            """
            (function() {
                \(youTubePlayerVariableName).\(functionName)();
            })();
            """
        )
    }
    
    @Test
    func combinedFeatures() {
        let youTubePlayerVariableName = UUID().uuidString
        let functionName = UUID().uuidString
        let parameter = UUID().uuidString
        #expect(
            YoutubeMusicPlayerKit
                .JavaScript
                .youTubePlayer(functionName: functionName, parameters: [parameter])
                .ignoreReturnValue()
                .asImmediatelyInvokedFunctionExpression()
                .content(variableNames: [.youTubePlayer: youTubePlayerVariableName])
            ==
            """
            (function() {
                \(youTubePlayerVariableName).\(functionName)(\(parameter)); null;
            })();
            """
        )
    }
    
    @Test
    func emptyVariableNames() {
        let functionName = UUID().uuidString
        let javaScript = YoutubeMusicPlayerKit
            .JavaScript
            .youTubePlayer(functionName: functionName)
        #expect(
            javaScript.description
            ==
            "\(YoutubeMusicPlayerKit.JavaScript.Variable.youTubePlayer.placeholderRawValue).\(functionName)();"
        )
        #expect(
            javaScript.content()
            ==
            "\(YoutubeMusicPlayerKit.JavaScript.Variable.youTubePlayer.rawValue).\(functionName)();"
        )
    }
    
}
