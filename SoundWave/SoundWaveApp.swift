//
//  SoundWaveApp.swift
//  SoundWave
//
//  Created by Abhishek on 23/12/23.
//

import SwiftUI

@main
struct SoundWaveApp: App {
    @StateObject var vm = AudioSound()
    var body: some Scene {
        WindowGroup {
            ContentView(vm: vm)
        }
    }
}
