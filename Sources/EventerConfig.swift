import Foundation

public struct EventerConfig {
    public let licenseKey: String
    public let endpointURL: URL?
    public let globalParameters: [String: Any]
    public let loggingEnabled: Bool
    public let defaultDestination: EventDestination
    public let telegramToken: String?
    public let telegramChatId: Int64?
    
    public init(
        licenseKey: String,
        endpointURL: URL? = nil,
        globalParameters: [String : Any] = [:],
        loggingEnabled: Bool = false,
        defaultDestination: EventDestination = .server,
        telegramToken: String? = nil,
        telegramChatId: Int64? = nil
    ) {
        self.licenseKey = licenseKey
        self.endpointURL = endpointURL
        self.globalParameters = globalParameters
        self.loggingEnabled = loggingEnabled
        self.defaultDestination = defaultDestination
        self.telegramToken = telegramToken
        self.telegramChatId = telegramChatId
    }
}
