//
//  CachedAsyncImage.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    let stringUrl: String?

    var body: some View {

        if let image = ImageCache.shared.object(for: stringUrl ?? "") {
            image
                .resizable()
                .scaledToFit()
                .clipped()
                .clipShape(.rect(cornerRadius: 25))
                .padding(.horizontal)

        } else {
            AsyncImage(url: URL(string: stringUrl ?? "")) { phase in
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
                            .clipShape(.rect(cornerRadius: 2))
                            .padding(.horizontal)
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
    CachedAsyncImage(stringUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/544/1362267.jpg")
}
