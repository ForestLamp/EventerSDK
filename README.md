# EventerSDK

EventerSDK is a lightweight library for event tracking in iOS applications.  
Perfect for logging and analytics purposes.

---

## Features

- Event delivery to:
  - a server (POST)
  - a Telegram chat
  - both destinations simultaneously

Add the dependency:

```swift
.dependencies: [
 .package(url: "https://github.com/ForestLamp/EventerSDK.git", from: "1.0.0")
]
```

## Configuration

```
import EventerSDK

let config = EventerConfig(
    globalParameters: [
        "app_version": "1.0.0",
        "platform": "iOS"
    ],
    loggingEnabled: true,
    defaultDestination: .server,
    serverEndpoint: URL(string: "https://your-backend.com/events"),
    telegramToken: "123456:ABCDEF",
    telegramChatId: 123456789
)

Eventer.activate(config: config)
```

## Usage Examples

Track an event with parameters
```
Eventer.track("ButtonClick", params: [
    "id": "paywall_continue",
    "screen": "Paywall"
])
```
Send event to a specific destination
```
Eventer.track("CriticalError", destination: .telegram)
Eventer.track("PurchaseCompleted", destination: .server)
Eventer.track("UserAction", destination: .all)
```
