//
//  ServerTransport.swift
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

public final class ServerTransport: TransportProtocol {

    private let endpoint: URL

    public init(endpoint: URL) {
        self.endpoint = endpoint
    }

    public func send(event: EventModel, globalParams: [String : Any], loggingEnabled: Bool) {
        var payload = [
            "event_name": event.name,
            "event_params": event.parameters,
            "timestamp": Date().timeIntervalSince1970
        ] as [String : Any]

        globalParams.forEach { payload[$0.key] = $0.value }

        guard let data = try? JSONSerialization.data(withJSONObject: payload) else { return }

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error, loggingEnabled {
                print("ServerTransport error:", error)
            }
        }.resume()
    }
}

