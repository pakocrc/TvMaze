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

    @State var screenW = 0.0
    @State var scale = 1.0
    @State var lastScale = 0.0
    @State var offset: CGSize = .zero
    @State var lastOffset: CGSize = .zero

    var body: some View {
        GeometryReader { proxy in
            CachedAsyncImage(stringUrl: imageUrl)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .scaleEffect(scale)
                .offset(offset)
                .scaledToFill()
                .gesture(
                    MagnificationGesture(minimumScaleDelta: 0)
                        .onChanged({ value in
                            withAnimation(.interactiveSpring()) {
                                scale = handleScaleChange(value)
                            }
                        })
                        .onEnded({ _ in
                            lastScale = scale
                        })
                        .simultaneously(
                            with: DragGesture(minimumDistance: 0)
                                .onChanged({ value in
                                    withAnimation(.interactiveSpring()) {
                                        offset = handleOffsetChange(value.translation)
                                    }
                                })
                                .onEnded({ _ in
                                    lastOffset = offset
                                })

                        )
                )
                .onAppear {
                    screenW = proxy.size.width
                }
        }
        .ignoresSafeArea()
    }

    private func handleScaleChange(_ zoom: CGFloat) -> CGFloat {
        lastScale + zoom - (lastScale == 0 ? 0 : 1)
    }

    private func handleOffsetChange(_ offset: CGSize) -> CGSize {
        var newOffset: CGSize = .zero

        newOffset.width = offset.width + lastOffset.width
        newOffset.height = offset.height + lastOffset.height

        return newOffset
    }
}

#Preview {
    ImageFullView(title: "Title",
                  imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/544/1362267.jpg")
}
