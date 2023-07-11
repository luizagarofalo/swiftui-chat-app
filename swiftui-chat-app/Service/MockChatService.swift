//
//  MockChatService.swift
//  swiftui-chat-app
//
//  Created by Luiza on 10/07/23.
//

import Foundation

class MockChatService: ChatServiceProtocol {
    private var chatHistory: [Message] = []
    
    func sendMessage(_ message: String, completion: @escaping (Result<[Message], CustomError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let response = self.generateMockResponse(for: message)
            self.updateChatHistory(with: response)
            completion(.success(self.chatHistory))
        }
    }
    
    private func generateMockResponse(for message: String) -> [Message] {
        var replyMessage: String
        
        switch message.lowercased() {
        case "hello", "hi":
            replyMessage = "Hi, there. How can I assist you today?"
            
        case "how can i best prepare for a job interview in my desired career field?":
            replyMessage = """
                Great question! Here are some tips on how you can best prepare for a job interview in your desired career field:
                
                1. Research the company and its competitors thoroughly to get a better understanding of their industry.
                
                2. Review the job description carefully and make a list of your strengths and how they can be applied to the role.
                
                3. Prepare responses to some common interview questions.  4. Dress professionally and be aware of your body language.
                
                5. Make sure to have a copy of your resume in case the interviewer does not have it on hand.
                """
            
        default:
            let randomMessage = [
                "Sorry, I didn't understand. Could you please rephrase that?",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris pharetra orci id vulputate varius. Praesent et scelerisque justo."
            ].randomElement()
            
            replyMessage = randomMessage ?? "Sorry, I didn't understand. Could you please rephrase that?"
        }
        
        return [
            Message(content: message, sender: .user),
            Message(content: replyMessage, sender: .ai)
        ]
    }
    
    private func updateChatHistory(with messages: [Message]) {
        chatHistory.append(contentsOf: messages)
    }
}
