//
//  EventerConfig.swift
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

public struct EventerConfig {
    public let globalParameters: [String: Any]
    public let loggingEnabled: Bool
    public let defaultDestination: EventDestination

    public let serverEndpoint: URL?
    public let telegramToken: String?
    public let telegramChatId: Int64?

    public init(
        globalParameters: [String: Any] = [:],
        loggingEnabled: Bool = true,
        defaultDestination: EventDestination = .server,
        serverEndpoint: URL? = nil,
        telegramToken: String? = nil,
        telegramChatId: Int64? = nil
    ) {
        self.globalParameters = globalParameters
        self.loggingEnabled = loggingEnabled
        self.defaultDestination = defaultDestination
        self.serverEndpoint = serverEndpoint
        self.telegramToken = telegramToken
        self.telegramChatId = telegramChatId
    }
}
