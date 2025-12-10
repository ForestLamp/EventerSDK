//
//  TelegramTransport.swift
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

public final class TelegramTransport: TransportProtocol {

    private let token: String
    private let chatId: Int64

    public init(token: String, chatId: Int64) {
        self.token = token
        self.chatId = chatId
    }

    public func send(event: EventModel, globalParams: [String : Any], loggingEnabled: Bool) {
        let text = formatMessage(event: event, globalParams: globalParams)

        let urlString = "https://api.telegram.org/bot\(token)/sendMessage"
        guard let url = URL(string: urlString) else { return }

        let body: [String: Any] = [
            "chat_id": chatId,
            "text": text
        ]

        guard let data = try? JSONSerialization.data(withJSONObject: body) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error, loggingEnabled {
                print("TelegramTransport error:", error)
            }
        }.resume()
    }

    private func formatMessage(event: EventModel, globalParams: [String: Any]) -> String {
        var text = "Event: \(event.name)"
        if !event.parameters.isEmpty {
            text += "\nParams: \(event.parameters)"
        }
        if !globalParams.isEmpty {
            text += "\nGlobal: \(globalParams)"
        }
        return text
    }
}
