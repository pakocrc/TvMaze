//
//  ImageFullView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 28/4/25.
//

import SwiftUI

struct ImageFullView: View {
    @Environment(\.dismiss) var dismiss
    var title: String
    var imageUrl: String

    @State var screenW = 0.0
    @State var scale = 1.0
    @State var lastScale = 0.0
    @State var offset: CGSize = .zero
    @State var lastOffset: CGSize = .zero

//    @State var isZoomed = false

    init(title: String, imageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
    }

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                CachedAsyncImage(stringUrl: imageUrl)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .scaleEffect(scale)
                    .offset(offset)
                    .scaledToFill()
                    .onTapGesture(count: 2, perform: { coordinates in
//                        if !isZoomed {
//                            debugPrint("Zooming to Coordinates:", coordinates)
//
//                            withAnimation(.interactiveSpring()) {
//
//                                scale = 3.0
//                                offset = handleOffsetChange(CGSize(width: 600, height: 600))
//
////                                let newOffset = CGSize(width: coordinates.x, height: coordinates.y)
////                                offset = handleOffsetChange(newOffset)
//                            }
//                        } else {
                            withAnimation(.interactiveSpring()) {
                                scale = 1.0
                                offset = .zero
                            }
//                        }

//                        isZoomed.toggle()
                    })
                    .gesture(
                        MagnificationGesture(minimumScaleDelta: 0)
                            .onChanged({ value in
                                withAnimation(.interactiveSpring()) {
                                    scale = handleScaleChange(value)
                                }
                            })
                            .onEnded({ _ in
                                lastScale = min(max(scale, 1.0), 4.0)
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
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.primary)
                    }
                }

                ToolbarItem(placement: .primaryAction) {
                    Button {
                        savePhoto()
                    } label: {
                        Image(systemName: "arrow.down.circle")
                            .foregroundStyle(Color.primary)
                    }
                }
            }
        }
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

    private func savePhoto() {
        guard let imageData = ImageCache.shared.object(for: imageUrl), let uiImage = UIImage(data: imageData) else { return }
        UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
    }
}

#Preview {
    ImageFullView(title: "Title",
                  imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/544/1362267.jpg")
}
