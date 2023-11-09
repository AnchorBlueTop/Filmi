//
//  NowPlayingScreenView.swift
//  Filmi
//
//  Created by Harshil Patel on 3/11/23.
//

import SwiftUI

struct NowPlayingScreenView: View {
    @ObservedObject var viewModel: MovieViewModel

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.nowPlayingMovies) { movie in
                    // Embedding navigation link so user can see additional movie details upon tap. 
                    NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                        HStack {
                            MoviePosterView(movie: movie)
                                .frame(width: 120, height: 180)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(movie.title)
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text("(\(String(movie.releaseDate.prefix(4))))")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                
                                Text(GenreTextUtil.genreText(for: movie, using: viewModel.genres))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text(movie.overview)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .lineLimit(3)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // To prevent the button from being styled.
                    .padding(.vertical, 8)
                    
                    Divider()
                    .background(Color.white)
                }
            }
        }
        .background(Color.black)
        // Fetching movie data from MovieViewModel: 
        .onAppear {
            Task {
                do {
                    if viewModel.nowPlayingMovies.isEmpty {
                        try await viewModel.fetchNowPlayingMovies()
                    }
                } catch {
                    // Additonal error handling.
                    print("Error while fetching now playing movies: \(error.localizedDescription)")
                }
            }
        }

        .navigationBarTitle("Now Playing", displayMode: .inline)
    }
}

