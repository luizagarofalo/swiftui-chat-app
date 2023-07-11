//
//  ChatServiceTests.swift
//  swiftui-chat-appTests
//
//  Created by Luiza on 11/07/23.
//

import XCTest
@testable import swiftui_chat_app

final class ChatServiceTests: XCTestCase {
    var chatService: ChatServiceProtocol!
    
    override func setUp() {
        super.setUp()
        chatService = MockChatService()
    }
    
    override func tearDown() {
        chatService = nil
        super.tearDown()
    }
    
    func testSendMessage() {
        let expectation = XCTestExpectation(description: "Send message expectation")
        let message = "Hello"
        let aiMessage = "Hi, there. How can I assist you today?"
        
        chatService.sendMessage(message) { result in
            switch result {
            case .success(let messages):
                XCTAssertEqual(messages.count, 2)
                XCTAssertEqual(messages[0].content, message)
                XCTAssertEqual(messages[0].sender, .user)
                XCTAssertEqual(messages[1].content, aiMessage)
                XCTAssertEqual(messages[1].sender, .ai)
                expectation.fulfill()
            case .failure:
                XCTFail("Sending message failed")
            }
        }
        
        wait(for: [expectation], timeout: 1.5)
    }
}
