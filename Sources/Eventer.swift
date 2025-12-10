//
//  Eventer.swift
//  EventerSDK
//
//  Created by Alex on 12/10/25.
//  Copyright © 2025 Alex. All rights reserved.
//
//  License: CC BY-NC 4.0 (Non-Commercial)
//  This software is free for personal and non-commercial use.
//  Commercial use requires a separate paid license.
//

import Foundation

public final class Eventer {
    
    private static let shared = Eventer()
    private var config: EventerConfig?
    private var transports: [EventDestination: TransportProtocol] = [:]
    private let queue = DispatchQueue(label: "eventer.queue")

    public static func activate(config: EventerConfig) {
        shared.configure(config)
    }
    
    public static func track(_ event: EventModel, destination: EventDestination? = nil) {
        shared.track(event, destination: destination)
    }
    
    public static func track(_ name: String, params: [String: Any] = [:], destination: EventDestination? = nil) {
        let event = EventModel(name: name, parameters: params)
        shared.track(event, destination: destination)
    }

    private init() {}
}

private extension Eventer {

    func configure(_ config: EventerConfig) {
        queue.sync {
            self.config = config
            transports.removeAll()

            if let endpoint = config.serverEndpoint {
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
    }

    func track(_ event: EventModel, destination: EventDestination?) {
        queue.async {
            guard let config = self.config else { return }

            let target = destination ?? config.defaultDestination

            switch target {
            case .server:
                self.transports[.server]?.send(event: event, globalParams: config.globalParameters, loggingEnabled: config.loggingEnabled)

            case .telegram:
                self.transports[.telegram]?.send(event: event, globalParams: config.globalParameters, loggingEnabled: config.loggingEnabled)

            case .all:
                self.transports[.server]?.send(event: event, globalParams: config.globalParameters, loggingEnabled: config.loggingEnabled)
                self.transports[.telegram]?.send(event: event, globalParams: config.globalParameters, loggingEnabled: config.loggingEnabled)
            }
        }
    }
}
