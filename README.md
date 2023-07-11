# swiftui-chat-app
A messaging app that enables users to engage in conversations with an AI assistant, built with SwiftUI.

![swiftui-chat-app](https://github.com/luizagarofalo/swiftui-chat-app/assets/12313246/e76113fa-458d-4e84-bfef-f4ee1acf9767)

## Getting started
- Clone this repository and open the project in Xcode.
```
git clone https://github.com/your-username/chat-app.git
```

- Replace the URL and endpoints in the `ChatService` class with the actual API endpoints you will be using. If you don't have an API, you can use the `MockChatService` class provided to simulate the API calls.

- Build and run the application on the iOS simulator or a physical device.

## Features
- **Multiple input methods** – users can interact by typing or speaking their messages.
- **Voice mode entry** – users can enter messages by speaking, using the device's microphone.
- **Microphone input level** – the app includes an animation indicating the loudness of the microphone input.
- **Transcription of audio** – the app transcribes the spoken messages to text using the Speech library, allowing the users to edit their texts before sending it.
- **Loading animation** – when a user sends a message, a loading animation indicates the progress of the API call.
- **Mocked API** – the app includes a `MockChatService` class that can be used to simulate API calls and responses.
- **Service layer** – the `ChatService` class provides an implementation of a `URLSession`, allowing communications with real APIs.
- **Unit tests** – unit tests are included for the view model and service layers.
- **Dark mode disabled** – dark mode is disabled to maintain the designed colors and visual appearance.

## Resources
The following resources were used:

- [Audio Recording in SwiftUI MVVM with AVFoundation](https://mdcode2021.medium.com/audio-recording-in-swiftui-mvvm-with-avfoundation-an-ios-app-6e6c8ddb00cc)
- [How to convert speech to text using SFSpeechRecognizer](https://www.hackingwithswift.com/example-code/libraries/how-to-convert-speech-to-text-using-sfspeechrecognizer)
- [Detecting Microphone Input Levels in Your iOS Application](https://betterprogramming.pub/detecting-microphone-input-levels-in-your-ios-application-e5b96bf97c5c)
