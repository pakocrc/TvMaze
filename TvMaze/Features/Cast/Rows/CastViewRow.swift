//
//  CastViewRow.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 5/5/25.
//

import SwiftUI

struct CastViewRow: View {
    let cast: TvMazeCast

    var body: some View {
        HStack(alignment: .center) {
            CachedAsyncImage(stringUrl: cast.character.image?.medium ?? "")
                .frame(width: 150, alignment: .leading)

            VStack(alignment: .leading) {
                Text(cast.character.name)
                    .font(.headline)
                    .bold()
                    .multilineTextAlignment(.leading)

                Text(cast.person.name ?? "" )
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }

        Divider()
    }
}

#Preview {
    CastViewRow(cast: TvMazeStore.getCast().first!)
}
