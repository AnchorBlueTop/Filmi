//
//  FilmiApp.swift
//  Filmi
//
//  Created by Harshil Patel on 2/11/23.
//

import SwiftUI

@main
struct FilmiApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .environmentObject(AppRouter()) // Providing AppRouter to MainScreenView. 
        }
    }
}
