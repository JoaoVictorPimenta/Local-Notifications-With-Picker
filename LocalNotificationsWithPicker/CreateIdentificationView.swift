//
//  CreateIdentificationView.swift
//  LocalNotificationsWithPicker
//
//  Created by João Victor Ferreira Pimenta on 05/09/22.
//

import SwiftUI

struct CreateIdentificationView: View {
    @ObservedObject var notificationManager: NotificationManager
    @State private var title = ""
    @State private var date = Date()
    @Binding var isPresented: Bool
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    HStack {
                        TextField("Notification Title", text: $title)
                        Spacer()
                        DatePicker("", selection:  $date, displayedComponents: [.hourAndMinute])
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .cornerRadius(5)
                    Button {
                        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
                        guard let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
                        notificationManager.createLocalNotification(title: title, hour: hour, minute: minute) { error in
                            if error == nil {
                                DispatchQueue.main.async {
                                    self.isPresented = false
                                }
                            }
                        }
                    } label: {
                        Text("Create")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .buttonStyle(PlainButtonStyle())
                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onDisappear {
            notificationManager.reloadLocalNotifications()
        }
        .navigationTitle("Create")
        .navigationBarItems(trailing: Button {
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .imageScale(.large)
        })
    }
}

struct CreateIdentificationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIdentificationView(
            notificationManager: NotificationManager(),
            isPresented: .constant(false))
    }
}
