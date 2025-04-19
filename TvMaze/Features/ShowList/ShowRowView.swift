//
//  ShowRowView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import SwiftUI

struct ShowRowView: View {
    let show: TvMazeShow

    var body: some View {
        HStack(alignment: .top) {
            CachedAsyncImage(stringUrl: show.image?.medium)

            VStack(alignment: .leading) {
                Text(show.name ?? "")
                    .font(.title)
                    .multilineTextAlignment(.leading)

                if let average = show.rating?.average {
                    HStack{
                        Text("Rating:")
                            .font(.body)
                            .bold()

                        Text(String(average))
                            .font(.body)
                            .foregroundStyle(average < 5.0 ? .red : .green)
                            .bold()
                    }
                }

                Text(show.language?.capitalized ?? "")
                    .font(.body)
            }

            Spacer()
        }
    }
}

#Preview {
    ShowRowView(show: TvMazeStore.shared.getTvShow())
}
