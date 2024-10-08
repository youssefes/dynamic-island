//
//  CircleTimerView.swift
//  dynamic-island
//
//  Created by madar on 08/10/2024.
//

import SwiftUI

struct CircleTimerView: View {
    @Binding var progress: Double
    @Binding var duration: TimeInterval
    var body: some View {
        ZStack{
            Circle()
              .stroke(lineWidth: 20)
              .opacity(0.08)
              .foregroundColor(.black)
              .frame(width: 200, height: 200)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(270.0))
                .foregroundColor(Color.green)
                .frame(width: 200, height: 200)
            
            Text(duration.format(using: [.minute, .second]))
              .font(.title2.bold())
              .foregroundColor(Color.gray)
              .contentTransition(.numericText())
        }
    }
}
#Preview {
    CircleTimerView(progress: .constant(0.4), duration: .constant(100))
}


extension View {
  func timerButtonStyle(isValid: Bool = true) -> some View {
    self
      .font(.title2)
      .padding()
      .background(Color.green.opacity(isValid ? 1.0 : 0.2))
      .foregroundColor(Color.gray)
      .cornerRadius(10)
      .shadow(radius: 5)
  }
}
