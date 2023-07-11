//
//  ChatViewModel.swift
//  swiftui-chat-app
//
//  Created by Luiza on 04/07/23.
//

import AVFoundation
import Foundation
import Speech

class ChatViewModel: ObservableObject {
    @Published var currentAudioLevel: Float = 0.0
    @Published var isEditing: Bool = false
    @Published var isRecording: Bool = false
    @Published var messages: [Message] = []
    @Published var transcriptedMessage: String?
    
    private(set) var audioLevelTimer: Timer?
    private(set) var audioRecorder: AVAudioRecorder?
    private(set) var lastRecordedAudioURL: URL?
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
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Can not setup the recording")
            return
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("swiftui-chat-app-\(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder?.prepareToRecord()
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            isRecording = true
            
            audioLevelTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
                guard let self = self, let audioRecorder = self.audioRecorder else { return }
                audioRecorder.updateMeters()
                let averagePower = audioRecorder.averagePower(forChannel: 0)
                self.currentAudioLevel = self.normalizeAudioLevel(averagePower)
            }
        } catch {
            print("Failed to setup the recording")
        }
    }
    
    func stopRecording() {
        lastRecordedAudioURL = audioRecorder?.url
        audioRecorder?.stop()
        audioLevelTimer?.invalidate()
        isRecording = false
        
        if let audioURL = lastRecordedAudioURL {
            transcribeAudio(url: audioURL)
        }
    }
    
    private func normalizeAudioLevel(_ power: Float) -> Float {
        let minDb: Float = -60.0
        let maxDb: Float = 0.0
        let rangeDb = maxDb - minDb
        let meterLevel = max(power, minDb)
        let normalizedLevel = (meterLevel - minDb) / rangeDb
        return normalizedLevel
    }
    
    private func transcribeAudio(url: URL) {
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: url)
        
        recognizer?.recognitionTask(with: request) { [weak self] (result, error) in
            guard let result = result else {
                print("Recognition failed with error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if result.isFinal {
                self?.transcriptedMessage = result.bestTranscription.formattedString
            }
        }
    }
}
