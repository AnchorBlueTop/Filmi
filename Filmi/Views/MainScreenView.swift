//
//  MainScreenView.swift
//  Filmi
//
//  Created by Harshil Patel on 2/11/23.
//


import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject var router: AppRouter // Managing views based on user action.
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        MainNavigationView {
            Group {
                if router.selectedTab == .upcomingMovies {
                    ScrollView {
                        // Displaying posters in a 2x2 format. Orginally had 3x3 but changed due to sizing constraints.
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(viewModel.movies, id: \.id) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                                    MoviePosterView(movie: movie)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                } else {
                    NowPlayingScreenView(viewModel: viewModel)
                }
            }
        }
        // Fetching movie data from the MovieViewModel
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
}
