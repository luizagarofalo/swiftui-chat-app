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
