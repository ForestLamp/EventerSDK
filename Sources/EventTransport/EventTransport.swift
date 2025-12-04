import Foundation

protocol EventTransport {
    func send(event: Event)
}

final class ServerTransport: EventTransport {
    private let endpoint: URL
    
    init(endpoint: URL) {
        self.endpoint = endpoint
    }
    
    func send(event: Event) {
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "name": event.name,
            "parameters": event.parameters
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request).resume()
    }
}

final class TelegramTransport: EventTransport {
    private let token: String
    private let chatId: Int64
    
    init(token: String, chatId: Int64) {
        self.token = token
        self.chatId = chatId
    }
    
    func send(event: Event) {
        let text = "<b>\(event.name)</b>\n\(event.parameters)"
        sendMessage(text: text)
    }
    
    private func sendMessage(text: String) {
        guard let url = URL(string: "https://api.telegram.org/bot\(token)/sendMessage") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload: [String: Any] = [
            "chat_id": chatId,
            "text": text,
            "parse_mode": "HTML"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        
        URLSession.shared.dataTask(with: request).resume()
    }
}
