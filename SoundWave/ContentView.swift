//
//  ContentView.swift
//  SoundWave
//
//  Created by Abhishek on 23/12/23.
//

import SwiftUI

struct ContentView: View {
 
    @State private var drawingHeight = true
    @ObservedObject var vm: AudioSound
 
    var animation: Animation {
        return .linear(duration: 0.5).repeatForever()
    }
 
    var body: some View {
        if vm.isPlaying{
            VStack(alignment: .leading) {
                Text("Audio")
                    .bold()
                HStack {
                    bar(low: 0.4)
                        .animation(animation.speed(1.5), value: drawingHeight)
                    bar(low: 0.3)
                        .animation(animation.speed(1.2), value: drawingHeight)
                    bar(low: 0.5)
                        .animation(animation.speed(1.0), value: drawingHeight)
                    bar(low: 0.3)
                        .animation(animation.speed(1.7), value: drawingHeight)
                    bar(low: 0.5)
                        .animation(animation.speed(1.0), value: drawingHeight)
                }
                .frame(width: 80)
                .onAppear{
                    vm.setupAudioSession()
                    vm.setupAudioEngine()
                    vm.setupAudioPlayer()
                    drawingHeight.toggle()
                }
            }
        }else{
           Text("Please excute code again")
        }
    }
 
    func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(.green.gradient)
            .frame(height: (drawingHeight ? high : low) * 64)
            .frame(height: 64, alignment: .bottom)
    }

}

#Preview {
    ContentView(vm: AudioSound())
}
