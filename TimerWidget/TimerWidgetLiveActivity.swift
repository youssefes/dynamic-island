//
//  TimerWidgetLiveActivity.swift
//  TimerWidget
//
//  Created by madar on 08/10/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            LiveActivityView(state: context.state)
                .activitySystemActionForegroundColor(Color.green)

        } dynamicIsland: { context in
            DynamicIsland {
                expandedContent(state: context.state)
            } compactLeading: {
                HStack{
                    WidgetCircleTimerView(
                        progress: context.state.progress,
                        duration: context.state.duration)
                }
                .padding(8)
            } compactTrailing: {
                HStack{
                    Text(context.state.duration)
                        .minimumScaleFactor(0.8)
                        .contentTransition(.numericText())
                        .monospacedDigit()
                        .foregroundColor(Color.green)
                }
                .padding(8)
            } minimal: {
                HStack{
                    Text(context.state.duration)
                        .minimumScaleFactor(0.8)
                        .contentTransition(.numericText())
                        .monospacedDigit()
                        .foregroundColor(Color.green)
                }
                .padding(8)
            }
        }
    }
}
