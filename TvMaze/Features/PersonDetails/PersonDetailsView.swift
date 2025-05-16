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

                        Text("\(viewModel.person?.country?.name ?? "") \(getFlag(viewModel.person?.country?.code ?? ""))")
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

                        Text(formatDateAndAge(viewModel.person?.birthday ?? ""))
                    }

                    if let url = viewModel.person?.url {
                        Link("More information...", destination: URL(string: url)!)
                    }
                }
                .padding()
            }
            .navigationTitle(viewModel.person?.name ?? "")
            .alert("Alert", isPresented: $viewModel.displayAlert, actions: {
                Button("Close", role: .cancel) {
                    viewModel.displayAlert.toggle()
                }
            }, message: {
                Text(viewModel.alertMessage)
            })
            .task {
                await viewModel.fetchPersonDetails()
            }
            .overlay(alignment: .top) {

                if viewModel.person == nil {
                    ContentUnavailableView {
                        Label("Loading", systemImage: "arrow.down.circle.dotted")

                    } description: {
                        Text("Retrieving information...")

                    } actions: {
                        if viewModel.isReloadEnabled {
                            Button {
                                Task {
                                    await viewModel.fetchPersonDetails()
                                }
                            } label: {

                                Text("Reload")
                            }
                        }
                    }
                }
            }
        }
    }

    private func formatDateAndAge(_ stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: stringDate) {

            let age = calculateAge(date)
            let dateFormatted = date.formatted(date: .abbreviated, time: .omitted)
            return dateFormatted + age
        }

        return stringDate
    }

    private func calculateAge(_ birthDate: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)

        if let age = ageComponents.year {
            return String(" (\(age))")
        }

        return ""
    }

    private func getFlag(_ countryCode: String) -> String {
        countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}

#Preview {
    PersonDetailsView(personId: "6662", networkManager: NetworkManager())
}
