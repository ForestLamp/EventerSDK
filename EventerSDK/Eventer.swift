import Foundation

public final class Eventer {

    public static let shared = Eventer()

    private var config: EventerConfig?
    private var transports: [EventDestination: EventTransport] = [:]

    private init() {}

    public func activate(config: EventerConfig) throws {
        self.config = config
        
        transports.removeAll()

        if let endpoint = config.endpointURL {
            transports[.server] = ServerTransport(endpoint: endpoint)
        }
        
        if let token = config.telegramToken,
           let chat = config.telegramChatId {
            transports[.telegram] = TelegramTransport(token: token, chatId: chat)
        }
        
        if config.loggingEnabled {
            print("Eventer activated")
        }
    }

    public func track(_ event: Event, destination: EventDestination? = nil) {
        guard let config else { return }

        let target = destination ?? config.defaultDestination
        
        switch target {
        case .server:
            transports[.server]?.send(event: event)
        case .telegram:
            transports[.telegram]?.send(event: event)
        case .all:
            transports[.server]?.send(event: event)
            transports[.telegram]?.send(event: event)
        case .none:
            break
        }
    }
}
