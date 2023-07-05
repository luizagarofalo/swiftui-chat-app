//
//  ChatViewModel.swift
//  swiftui-chat-app
//
//  Created by Luiza on 04/07/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    private let service: ChatServiceProtocol
    
    init(service: ChatServiceProtocol) {
        self.service = service
    }
        
    func send(_ message: String) {
        service.sendMessage(message) { [weak self] result in
            switch result {
            case .success(let messages):
                self?.messages = messages
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
