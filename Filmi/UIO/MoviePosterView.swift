//
//  MoviePosterView.swift
//  Filmi
//
//  Created by Harshil Patel on 3/11/23.
//

import SwiftUI

// MoviePosterView - UI Object that is re-used across different views. 
struct MoviePosterView: View {
    var movie: MoviesResponse.Movie
    @State private var posterImage: UIImage?
    
    var body: some View {
        Group {
            if let image = posterImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                // Display blank placeholder image from the asset folder while img loads. 
                Image("PlaceHolder")
                    .resizable()
                    .scaledToFit()
                    .onAppear {
                        Task {
                            posterImage = await ImageLoader.shared.load(imageForKey: movie.posterPath, withURL: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
                            }
                    }
            }
        }
        .cornerRadius(8)
        .shadow(radius: 5)
        .padding(4)
    }
    
}
