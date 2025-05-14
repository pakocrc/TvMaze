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

    @Binding var isDownloadableImage: Bool

    init(stringUrl: String, placeholder: PlaceholderImage = PlaceholderImage.poster, isDownloadableImage: Binding<Bool>? = nil) {
        self.stringUrl = stringUrl
        self.placeholder = placeholder
        self._isDownloadableImage = isDownloadableImage ?? .constant(false)
    }

    var body: some View {

        if let imageData = ImageCache.shared.object(for: stringUrl), let uiImage = UIImage(data: imageData) {

            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .clipped()
                .clipShape(.rect(cornerRadius: 2))
                .padding(.horizontal)
                .task {
                    isDownloadableImage = true
                }

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
                                if let pngData = ImageRenderer(content: image).uiImage?.pngData() {
                                    ImageCache.shared.setObject(imageData: pngData, for: stringUrl)
                                }
                                isDownloadableImage = true
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
