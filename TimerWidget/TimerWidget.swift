//
//  TimerWidget.swift
//  TimerWidget
//
//  Created by madar on 08/10/2024.
//

import WidgetKit
import SwiftUI
struct WidgetCircleTimerView: View {

  var progress: Double
  var duration: String

  var body: some View {
    ZStack {
      Circle()
        .stroke(lineWidth: 4)
        .opacity(0.25)
        .foregroundColor(.white)
        .frame(width: 20, height: 20)

      Circle()
        .trim(from: 0.0, to: progress)
        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        .rotationEffect(.degrees(270.0))
        .foregroundColor(Color.green)
        .frame(width: 20, height: 20)
    }
  }
}

struct LiveActivityView: View {
    let state: TimerAttributes.ContentState

    var body: some View {
        HStack {
            Button {
                //TODO: End the activity
            } label: {
                Label("Stop", systemImage: "stop.circle")
                    .font(.body.bold())
            }
            .foregroundColor(Color.white)
            .background(Color.green)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.vertical, 8)
            .transition(.identity)

            Spacer()

            HStack(alignment: .center, spacing: 16) {
                WidgetCircleTimerView(
                    progress: state.progress,
                    duration: state.duration
                )

                Text(state.duration)
                    .font(.largeTitle.monospacedDigit())
                    .minimumScaleFactor(0.8)
                    .contentTransition(.numericText())
            }
        }
        .id(state)
        .padding()
        .foregroundColor(Color.accentColor)
    }
}

@DynamicIslandExpandedContentBuilder
func expandedContent(state: TimerAttributes.ContentState) -> DynamicIslandExpandedContent<some View> {
    DynamicIslandExpandedRegion(.leading) {
        Image(systemName: "timer.circle.fill")
            .resizable()
            .frame(width: 44.0, height: 44.0)
            .foregroundColor(Color.green)
    }
    DynamicIslandExpandedRegion(.center) {
        VStack {
            Text(state.duration + " remaining")
                .font(.title)
                .minimumScaleFactor(0.8)
                .contentTransition(.numericText())
            Spacer()
            Button {
                //TODO: End the activity
            } label: {
                Label("Stop", systemImage: "stop.circle")
                    .font(.body.bold())
            }
            .foregroundColor(Color.gray)
            .background(Color.green)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.vertical, 8)
            .lineLimit(1)
        }
        .id(state)
        .transition(.identity)
    }
}
