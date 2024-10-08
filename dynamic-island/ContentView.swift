//
//  ContentView.swift
//  dynamic-island
//
//  Created by madar on 08/10/2024.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State var activity: Activity<TimerAttributes>?
    @State var isTimerRunning = false
    @State var startTime = Date()

    // The interval difference between total and remaining duration.
    @State var interval = TimeInterval()

    // The actual total duration.
    @State var totalDuration: TimeInterval = 2 * 60

    // The remaining duration.
    @State var duration: TimeInterval = 2 * 60

    // Timer progress.
    @State var progress = 1.0

    // Timer which will publish update every one second.
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack(spacing: 24) {
                Button {
                    //TODO: 1. Add start action
                    startTime = Date()
                    startTimer()
                } label: {
                    Text("Start")
                    Image(systemName: "stopwatch")
                }
                .timerButtonStyle(isValid: !isTimerRunning)
                .disabled(isTimerRunning)
                
                Button {
                    //TODO: 2. Add stop action
                    stopTimer()
                } label: {
                    Text("Stop")
                    Image(systemName: "stop.circle")
                }
                .timerButtonStyle(isValid: isTimerRunning)
                .disabled(!isTimerRunning)
            }
            
            Spacer()

            if isTimerRunning {
                CircleTimerView(progress: $progress, duration: $duration)
            }

            Spacer()
        }
        .padding()
        .onReceive(timer) { time in
            if (isTimerRunning) {
                interval = Date().timeIntervalSince(startTime)
                duration = totalDuration - interval
                progress = (duration / totalDuration)
                if duration <= 0 {
                    stopTimer()
                } else {
                    guard let id = activity?.id else { return }
                    print(time)
                    LiveActivityManager().updateActivity(
                        activity: id,
                        duration: duration,
                        progress: progress
                    )
                }
            }
        }
    }
    
    
    func resetTimer() {
      totalDuration = 120
      duration = 120
      progress = 1.0
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        // Insert the following line here to start the activity.
        
        activity = LiveActivityManager().startActivity(duration: duration, progress: progress)
        isTimerRunning.toggle()
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
        // Insert the following line here to end the activity.
        LiveActivityManager().endActivity()
        resetTimer()
        isTimerRunning.toggle()
    }
}

#Preview {
    ContentView()
}
