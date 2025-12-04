import Foundation

public enum EventDestination {
    case server
    case telegram
    case all
    case none
}

public struct Event {
    public let name: String
    public let parameters: [String: Any]
    
    public init(name: String, parameters: [String: Any] = [:]) {
        self.name = name
        self.parameters = parameters
    }
}
