//
//  ChatService.swift
//  swiftui-chat-app
//
//  Created by Luiza on 04/07/23.
//

import Foundation

protocol ChatServiceProtocol {
    func sendMessage(_ message: String, completion: @escaping (Result<[Message], Error>) -> Void)
}

class ChatService: ChatServiceProtocol {
    func sendMessage(_ message: String, completion: @escaping (Result<[Message], Error>) -> Void) {}
}

class MockChatService: ChatServiceProtocol {
    func sendMessage(_ message: String, completion: @escaping (Result<[Message], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let response = self.generateMockResponse(for: message)
            completion(.success(response))
        }
    }
    
    private func generateMockResponse(for message: String) -> [Message] {
        switch message.lowercased() {
        case "hello", "hi":
            let messages = [
                Message(content: message, sender: .user),
                Message(content: "Hi! How can I assist you today?", sender: .ai)
            ]
            
            return messages
            
        default:
            let messages = [
                Message(content: message, sender: .user),
                Message(content: "Sorry, I didn't understand. Can you please rephrase?", sender: .ai)
            ]
            
            return messages
        }
    }
}
