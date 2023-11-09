//
//  MovieService.swift
//  Filmi
//
//  Created by Harshil Patel on 3/11/23.
//

import SwiftUI

// Works with NetWorkManager to make network calls.
struct MovieService {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
    
    // Fetching Upcoming movies list.
    func getUpcomingMovies(page: Int = 1) async throws -> [MoviesResponse.Movie] {
        try await networkManager.getMovies(from: "movie/upcoming", page: page)
    }
    
    // Fetching Now Playing movies list.
    func getNowPlayingMovies(page: Int = 1) async throws -> [MoviesResponse.Movie] {
        try await networkManager.getMovies(from: "movie/now_playing", page: page)
    }
    
    // Fetching Movie Genre list.
    func getMovieGenres() async throws -> [GenreDTO.Genre] {
        try await networkManager.getMovieGenres()
    }
}
