//
//  GenreDTO.swift
//  Filmi
//
//  Created by Harshil Patel on 3/11/23.
//


import Foundation

// Decoding JSON Response from the Genre API. 
struct GenreDTO: Decodable {
    let genres: [Genre]
    
    struct Genre: Decodable, Identifiable {
        let id: Int
        let name: String
    }
}
