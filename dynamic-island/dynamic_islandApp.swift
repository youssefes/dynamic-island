//
//  dynamic_islandApp.swift
//  dynamic-island
//
//  Created by madar on 08/10/2024.
//

import SwiftUI
import UIKit
import BackgroundTasks

@main
struct dynamic_islandApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Register the background task when the app launches
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.dynamic-island.dynamic-island", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        scheduleAppRefresh()  // Schedule background task on app launch
        
        return true
    }
    
    // Function to handle the background refresh task
    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()  // Reschedule the next background task
        // Your logic to update the timer in the background
        task.setTaskCompleted(success: true)
    }
    
    // Function to schedule a background refresh task
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.dynamic-island.dynamic-island")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)  // 15 minutes later (set as needed)
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
}

