import Foundation

final class EventSender {

    static let shared = EventSender()
    private init() {}

    func send(event: Event, config: EventerConfig) {
        var payload: [String: Any] = [
            "event_name": event.name,
            "event_params": event.parameters,
            "timestamp": Date().timeIntervalSince1970
        ]

        // добавляем глобальные параметры
        config.globalParameters.forEach { key, value in
            payload[key] = value
        }

        // Добавляем ключ (полезно для серверной валидации)
        payload["license_key"] = config.licenseKey

        guard let data = try? JSONSerialization.data(withJSONObject: payload) else {
            return
        }

        var request = URLRequest(url: config.endpointURL!)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error, config.loggingEnabled {
                print("Eventer Error:", error)
            }
        }.resume()
    }
}
