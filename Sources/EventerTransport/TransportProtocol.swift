//
//  TransportProtocol.swift
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

public protocol TransportProtocol {
    func send(event: EventModel, globalParams: [String: Any], loggingEnabled: Bool)
}
