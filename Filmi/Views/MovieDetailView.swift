//
//  MovieDetailView.swift
//  Filmi
//
//  Created by Harshil Patel on 2/11/23.
//

import SwiftUI

// Movie Detail Screen with relevant movie data upon user tap.
struct MovieDetailView: View {
    
    var movie: MoviesResponse.Movie
    @ObservedObject var viewModel: MovieViewModel
    @State private var backdropImage: UIImage?
    
    var body: some View {
        ScrollView {
            VStack {
                if let image = backdropImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    // Displaying black placeholder color while the image is loading
                    Color.black
                        // Keeps the rest of the content static while img loads.
                        .aspectRatio(16/9, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    // Movie Title
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(GenreTextUtil.genreText(for: movie, using: viewModel.genres))
                        .foregroundColor(.white)
                    
                    // Formatted releaste date from YYYY-MM-DD to Weekday-Date-Month-Year
                    Text("Release date: \(DateFormatterUtil.formattedDateFromString(dateString: movie.releaseDate) ?? "Not available")")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    // Movie Overview
                    Text("Overview")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(movie.overview)
                        .font(.body)
                        .lineSpacing(5)
                        .foregroundColor(.white)
                    
                    // Rating is rounded to 1 S.F. Also shows number of votes.
                    Text("Rating: \(String(format: "%.1f/10", movie.voteAverage)) (\(movie.voteCount) votes)")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.top, 100)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            // Fetch image from ImageLoader. 
            Task {
                backdropImage = await ImageLoader.shared.load(imageForKey: movie.backdropPath, withURL: "https://image.tmdb.org/t/p/original\(movie.backdropPath)")
                }
            }
        }
    
}
