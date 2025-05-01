//
//  PersonDetailsView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 30/4/25.
//

import SwiftUI

struct PersonDetailsView: View {

    @StateObject var viewModel: PersonDetailsViewModel

    init(personId: String, networkManager: NetworkProtocol) {
        self._viewModel = StateObject(wrappedValue: PersonDetailsViewModel(personId: personId, networkManager: networkManager))
    }

    var body: some View {
        if viewModel.person == nil {
            ContentUnavailableView("Loading...", systemImage: "arrow.down.circle.dotted", description: Text("Loading Content"))

        } else {
            GeometryReader { proxy in
                VStack(alignment: .leading) {
                    CachedAsyncImage(stringUrl: viewModel.person?.image?.medium ?? "")
                        .frame(width: proxy.size.width, height: proxy.size.height / 2, alignment: .center)
                        .onTapGesture {
                            viewModel.isPresentingImageFullView.toggle()
                        }
                        .sheet(isPresented: $viewModel.isPresentingImageFullView) {
                            ImageFullView(title: viewModel.person?.name ?? "",
                                          imageUrl: viewModel.person?.image?.original ?? "")
                        }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Person Info")
                            .font(.title)
                            .foregroundStyle(.gray)

                        HStack {
                            Text("Country:")
                                .font(.headline)
                                .bold()

                            Text(viewModel.person?.country?.name ?? "")
                        }

                        HStack {
                            Text("Gender:")
                                .font(.headline)
                                .bold()

                            Text(viewModel.person?.gender?.rawValue ?? "")
                        }

                        HStack {
                            Text("Date of birth:")
                                .font(.headline)
                                .bold()

                            Text(viewModel.person?.birthday ?? "")
                        }

                        if let url = viewModel.person?.url {
                            Link("More information...", destination: URL(string: url)!)
                        }
                    }
                    .padding()
                }
                .navigationTitle(viewModel.person?.name ?? "")
            }
        }
    }
}

#Preview {
    PersonDetailsView(personId: "6662", networkManager: NetworkManager())
}
