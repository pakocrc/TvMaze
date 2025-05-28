//
//  CustomContentUnavailableView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 28/5/25.
//

import SwiftUI

struct CustomContentUnavailableView: View {
    var action: () -> Void

    @Binding var isReloadEnabled: Bool

    var body: some View {
        ContentUnavailableView {
            Label(isReloadEnabled ? "Loading failed" : "Loading",
                  systemImage: isReloadEnabled ? "arrow.counterclockwise" : "arrow.down.circle.dotted"
            )
            .font(.title2)

        } description: {
            Text(isReloadEnabled ? "Please reload..." : "Retrieving information...")
                .font(.subheadline)

        } actions: {
            if isReloadEnabled {
                Button {
                    action()
                } label: {
                    Text("Reload")
                        .font(.title)
                }
            }
        }
    }
}

#Preview {
    CustomContentUnavailableView(action: { }, isReloadEnabled: .constant(true))
}
