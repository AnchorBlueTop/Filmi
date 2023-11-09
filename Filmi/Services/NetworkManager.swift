//
//  NetWorkManager.swift
//  Filmi
//
//  Created by Harshil Patel on 3/11/23.
//

import SwiftUI

// Handles Networking layer/logic. Sends requests, receives respones, and handles errors.
class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    
    // Headers for API containing API Read Access Token.
    private let headers = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NjYwOGU3NGQ2NzE4Zjk0YjQ1YmQ0NzVhNjhkZWZhZCIsInN1YiI6IjY1NDM2NjU1NDFhNTYxMzM2Yjc2MmI0NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._yC2gOsdkwD6A0Ny19v5F1xsCgObrX00NjY19ZKPS_k"
    ]
    
    private let baseAPIURL = "https://api.themoviedb.org/3/" // Base URL of API.
    
    // GET Request for Upcoming and Now Playing Movies. URL changes depending on endpoint.
    func getMovies(from endpoint: String, page: Int) async throws -> [MoviesResponse.Movie] {
        guard let url = URL(string: "\(baseAPIURL)\(endpoint)?language=en-US&page=\(page)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Decode Movie JSON Response.
        let decodedData = try JSONDecoder().decode(MoviesResponse.self, from: data)
        return decodedData.results
    }
    
    // GET Request for Movie Genres.
    func getMovieGenres() async throws -> [GenreDTO.Genre] {
            let urlEndpoint = "genre/movie/list"
            guard let url = URL(string: "\(baseAPIURL)\(urlEndpoint)?language=en-US") else {
                throw URLError(.badURL)
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            // Decode Genre JSON Respose.
            let decodedResponse = try JSONDecoder().decode(GenreDTO.self, from: data)
            return decodedResponse.genres
        }
    
}



