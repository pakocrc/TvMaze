//
//  CachedAsyncImage.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL

    var body: some View {

        if (ImageCache.shared.object(for: url.description)) != nil {
            ImageCache.shared.object(for: url.description)!
                .resizable()
                .scaledToFit()
                .clipped()
                .clipShape(.rect(cornerRadius: 25))
                .padding(.horizontal)

        } else {
            AsyncImage(url: url) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(width: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .clipShape(.rect(cornerRadius: 5))
                            .padding()
                    default:
                        Image(systemName: "photo.fill")
                            .resizable()
                            .renderingMode(.original)
                            .foregroundStyle(.gray)
                            .scaledToFit()
                            .clipped()
                            .clipShape(.rect(cornerRadius: 25))
                            .frame(width: 150)
                            .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    CachedAsyncImage(url: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/544/1362267.jpg")!)
}
