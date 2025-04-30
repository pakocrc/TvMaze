//
//  CachedAsyncImage.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import SwiftUI

enum PlaceholderImage: String {
    case poster = "no_poster"
    case wallpaper = "no_wallpaper"
}

struct CachedAsyncImage: View {
    let stringUrl: String
    let placeholder: PlaceholderImage

    init(stringUrl: String, placeholder: PlaceholderImage = PlaceholderImage.poster) {
        self.stringUrl = stringUrl
        self.placeholder = placeholder
    }

    var body: some View {

        if let imageData = ImageCache.shared.object(for: stringUrl) {
            imageData
                .resizable()
                .scaledToFit()
                .clipped()
                .clipShape(.rect(cornerRadius: 2))
                .padding(.horizontal)

        } else {
            AsyncImage(url: URL(string: stringUrl)) { phase in
                switch phase {
                    case .empty:
                        ZStack(alignment: .center) {
                            Image(placeholder.rawValue)
                                .resizable()
                                .scaledToFit()
                                .clipped()
                                .clipShape(.rect(cornerRadius: 2))
                                .padding(.horizontal)

                            ProgressView()
                                .progressViewStyle(.circular)
                        }

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .clipShape(.rect(cornerRadius: 2))
                            .padding(.horizontal)
                            .task {
                                ImageCache.shared.setObject(image: image, for: stringUrl)
                            }
                    default:
                        Image(placeholder.rawValue)
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .clipShape(.rect(cornerRadius: 2))
                            .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    CachedAsyncImage(stringUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/544/1362267.jpg",
                     placeholder: .wallpaper)
}
