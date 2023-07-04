//
//  ChatViewModel.swift
//  swiftui-chat-app
//
//  Created by Luiza on 04/07/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    func send(_ message: String) {}
}
