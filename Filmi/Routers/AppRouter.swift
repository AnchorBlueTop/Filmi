//
//  AppRouter.swift
//  Filmi
//
//  Created by Harshil Patel on 3/11/23.
//

import SwiftUI

// Used with MainNavigationView for handling routing.
class AppRouter: ObservableObject {
    enum Tab: String {
        case upcomingMovies = "upcomingMovies"
        case details = "details"
    }
    
    @Published var selectedTab: Tab = .upcomingMovies
}