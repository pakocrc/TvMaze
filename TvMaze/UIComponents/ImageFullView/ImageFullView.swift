//
//  ImageFullView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 28/4/25.
//

import SwiftUI

struct ImageFullView: View {
    var title: String
    var imageUrl: String

    var body: some View {
        GeometryReader { proxy in
            CachedAsyncImage(stringUrl: imageUrl)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .scaledToFill()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ImageFullView(title: "Title",
                  imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/544/1362267.jpg")
}
