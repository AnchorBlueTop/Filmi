//
//  MainNavigationView.swift
//  Filmi
//
//  Created by Harshil Patel on 8/11/23.
//

import SwiftUI

// MainNavigationView - Uses segmented picker to handle the navbar and styling.
struct MainNavigationView<Content: View>: View {
    @EnvironmentObject var router: AppRouter
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    Picker("Select a tab", selection: $router.selectedTab) {
                        Text("Upcoming").tag(AppRouter.Tab.upcomingMovies)
                        Text("Now Playing").tag(AppRouter.Tab.details)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .background(Color("AccentColor"))
                    content  // Show content below the navbar
                }
            }
            .navigationBarHidden(true) // Hides extra "Now Playing" label. 
        }
    }
}

