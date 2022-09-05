//
//  LocalNotificationsWithPickerApp.swift
//  LocalNotificationsWithPicker
//
//  Created by João Victor Ferreira Pimenta on 05/09/22.
//

import SwiftUI

@main
struct LocalNotificationsWithPickerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NotificationListView()
            }
            .accentColor(.primary)
        }
    }
}
