//
//  AudioSound.swift
//  SoundWave
//
//  Created by Abhishek on 23/12/23.
//

import Foundation
import AVFoundation

class AudioSound: ObservableObject{
    let audioSession = AVAudioSession.sharedInstance()
    var audioEngine: AVAudioEngine!
    var audioPlayer: AVPlayer!
    var audioBuffer = [Float]()
    @Published var isPlaying = true
    
    func setupAudioSession() {
        do {
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
            // Observe the AVPlayerItemDidPlayToEndTime notification
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerDidFinishPlaying),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: nil)
        } catch {
            print("Audio session setup error: \(error.localizedDescription)")
        }
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { }
    }

    func setupAudioEngine() {
        configureAudioSession()
        audioEngine = AVAudioEngine()
        let inputNode = audioEngine.inputNode

        let outputFormat = inputNode.inputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: outputFormat) { buffer, _ in
            let bufferPointer = buffer.floatChannelData?[0]
            let bufferLength = Int(buffer.frameLength)

            self.audioBuffer = Array(UnsafeBufferPointer(start: bufferPointer, count: bufferLength))
        }

        do {
            try audioEngine.start()
        } catch {
            print("Audio engine start error: \(error.localizedDescription)")
        }
    }



    func setupAudioPlayer() {
        guard let audioURL = Bundle.main.url(forResource: "Song5", withExtension: "mp3") else {
            fatalError("Audio file not found")
        }

        audioPlayer = AVPlayer(url: audioURL)
        audioPlayer.play()

    }
    
    @objc func playerDidFinishPlaying() {
          // Handle audio playback completion
          isPlaying = false
      }
}
