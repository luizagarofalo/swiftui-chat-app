//
//  ChatViewModelTests.swift
//  swiftui-chat-appTests
//
//  Created by Luiza on 10/07/23.
//

import XCTest
@testable import swiftui_chat_app

final class ChatViewModelTests: XCTestCase {
    var chatViewModel: ChatViewModel!
    var mockService: MockChatService!
    
    override func setUp() {
        super.setUp()
        mockService = MockChatService()
        chatViewModel = ChatViewModel(service: mockService)
    }
    
    override func tearDown() {
        chatViewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testSend() {
        let message = "Hello"
        let expectation = XCTestExpectation(description: "Send message expectation")
        
        chatViewModel.send(message)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.chatViewModel.messages.count, 2)
            XCTAssertEqual(self.chatViewModel.messages[0].content, message)
            XCTAssertEqual(self.chatViewModel.messages[1].content, "Hi, there. How can I assist you today?")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testStartRecording() {
        chatViewModel.startRecording()
        
        XCTAssertTrue(chatViewModel.isRecording)
        XCTAssertNotNil(chatViewModel.audioRecorder)
        XCTAssertNotNil(chatViewModel.audioLevelTimer)
    }
    
    func testStopRecording() {
        let expectation = XCTestExpectation(description: "Stop recording expectation")
        chatViewModel.startRecording()
        chatViewModel.stopRecording()
                
        guard
            let audioRecorder = chatViewModel.audioRecorder,
            let audioLevelTimer = chatViewModel.audioLevelTimer else {
            return XCTFail("Start recording failed")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(audioLevelTimer.isValid)
            XCTAssertFalse(audioRecorder.isRecording)
            XCTAssertFalse(self.chatViewModel.isRecording)
            XCTAssertNotNil(self.chatViewModel.lastRecordedAudioURL)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
