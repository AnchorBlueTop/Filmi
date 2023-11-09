//
//  GenreTextUtil.swift
//  Filmi
//
//  Created by Harshil Patel on 8/11/23.
//

import Foundation

// Mapping the movie genre ID's to the respective genre name.
struct GenreTextUtil {
    static func genreText(for movie: MoviesResponse.Movie, using genres: [GenreDTO.Genre]) -> String {
        
        // Using compactMap to ignore nil values if the movieGenreID is does not match any genre in genre array.
        let genreNames = movie.genreIds.compactMap { id in
            
            // Finds the first genre in the movie array where movieGenreID matches a genre in genre array.
            genres.first { $0.id == id }?.name
        }
        
        // Displaying text if the movieGenreID does not match any genre in the genre Array.
        return genreNames.isEmpty ? "No genres available" : genreNames.joined(separator: ", ")
    }
}

