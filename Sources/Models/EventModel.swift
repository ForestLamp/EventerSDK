//
//  EventModel.swift
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

public enum EventDestination {
    case server
    case telegram
    case all
}

public struct EventModel {
    public let name: String
    public let parameters: [String: Any]

    public init(name: String, parameters: [String: Any] = [:]) {
        self.name = name
        self.parameters = parameters
    }
}
