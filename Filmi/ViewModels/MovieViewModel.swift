//
//  MovieViewModel.swift
//  Filmi
//
//  Created by Harshil Patel on 2/11/23.
//

import SwiftUI

// MoviewViewModel - Handling the logic for presentation. Fetch data needed by the view.
@MainActor
class MovieViewModel: ObservableObject {
    
    @Published var movies: [MoviesResponse.Movie] = []
    @Published var nowPlayingMovies: [MoviesResponse.Movie] = []
    @Published var genres: [GenreDTO.Genre] = []
    @Published var isLoading: Bool = false

    private let movieService = MovieService()
    private var currentPage: Int = 1
    
    // Async/Await methods for fetching relevant data:
    
    // Fetch Upcoming Movies as the user scrolls the page. 
    func fetchUpcomingMovies() async throws {
            let newMovies = try await movieService.getUpcomingMovies(page: currentPage)
            self.movies.append(contentsOf: newMovies)
            self.currentPage += 1
    }
    func fetchNowPlayingMovies() async throws {
            let movies = try await movieService.getNowPlayingMovies(page: currentPage)
            self.nowPlayingMovies = movies
    }
    func fetchGenres() async throws {
            let genres = try await movieService.getMovieGenres()
            self.genres = genres
    }
    
    // Error Handling
    func fetchData() async {
        isLoading = true
        do {
            try await fetchUpcomingMovies()
            try await fetchNowPlayingMovies()
            try await fetchGenres()
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
