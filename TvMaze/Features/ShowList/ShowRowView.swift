//
//  ShowRowView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import SwiftUI

struct ShowRowView: View {
    let show: TvShow

    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: show.image?.medium ?? "")!, transaction: .init(animation: .easeIn)) { phase in
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

            VStack(alignment: .leading) {
                Text(show.name ?? "")
                    .font(.title)

                Text(show.network?.name ?? "Unknown")
                    .font(.body)

                Text(show.language ?? "")
                    .font(.body)

                Text(String(show.rating?.average ?? 0.0))
                    .font(.body)
            }

            Spacer()
        }
    }
}

#Preview {
    ShowRowView(show: TvShow(id: 43, url: "https://www.tvmaze.com/shows/43/outlander", name: "Outlander", type: "scripted", language: "english", genres: ["adventure", "romance", "scienceFiction"], status: "running", runtime: Optional(60), averageRuntime: 61, premiered: "2014-08-09", ended: nil, officialSite: Optional("https://www.starz.com/us/en/series/outlander/21796"), schedule: Schedule(time: "20:00", days: [TvMaze.Day.friday]), rating: Rating(average: Optional(7.9)), weight: 99, network: Optional(TvMaze.Network(id: 17, name: "STARZ", country: Optional(TvMaze.Country(name: "United States", code: "us", timezone: "America/New_York")), officialSite: Optional("https://www.starz.com/us/en/"))), webChannel: nil, dvdCountry: nil, externals: Externals(tvrage: 36202, thetvdb: Optional(270408), imdb: Optional("tt3006802")), image: TvShowImage(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/544/1362267.jpg", original: "https://static.tvmaze.com/uploads/images/original_untouched/544/1362267.jpg"), summary: "<p><b>Outlander </b>follows the story of Claire Randall, a married combat nurse from 1945 who is mysteriously swept back in time to 1743, where she is immediately thrown into an unknown world where her life is threatened. When she is forced to marry Jamie, a chivalrous and romantic young Scottish warrior, a passionate affair is ignited that tears Claire\'s heart between two vastly different men in two irreconcilable lives.</p><p>The <i>Outlander</i> series, adapted from Diana Gabaldon\'s international best-selling books, spans the genres of romance, science fiction, history and adventure into one epic tale.</p>", updated: 1737502204, links: Links(linksSelf: SelfClass(href: "https://api.tvmaze.com/shows/43"), previousepisode: Episode(href: "https://api.tvmaze.com/episodes/3049195", name: "A Hundred Thousand Angels"), nextepisode: nil)))
}
