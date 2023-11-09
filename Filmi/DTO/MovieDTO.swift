//
//  MovieDTO.swift
//  Filmi
//
//  Created by Harshil Patel on 3/11/23.
//

import Foundation

// Decoding JSON Response from the Upcoming and NowPlaying Movies API.
struct MoviesResponse: Decodable {
    let dates: Dates
    let page: Int
    let results: [Movie]
    
    // Nested struct to decode the 'dates' part of the JSON response.
    struct Dates: Decodable {
        let maximum: String
        let minimum: String
    }
    
    // Represents Movie and it's details.
    struct Movie: Decodable, Identifiable {
        let adult: Bool
        let backdropPath: String
        let genreIds: [Int]
        let id: Int
        let originalLanguage: String
        let originalTitle: String
        let overview: String
        let popularity: Double
        let posterPath: String
        let releaseDate: String
        let title: String
        let video: Bool
        let voteAverage: Double
        let voteCount: Int
        
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIds = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview
            case popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title
            case video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}

// Extension for checking if two movie ojects are the same.
// Allows movie object to be used in a set or dictionary.
// Primarly used for when I had upcoming movies in a 3x3 poster layout.
extension MoviesResponse.Movie: Hashable {
    
    // Comparing two movie objects and check if they're the same.
    static func == (lhs: MoviesResponse.Movie, rhs: MoviesResponse.Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Provides a unique hash value of each movie using their movie id.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}




