//
//  GIFSearchView.swift
//  GIFPediaSwiftUI
//
//  Created by USER on 2023/06/09.
//

import SwiftUI
import NukeUI
import GIFPediaPresentationLayer

struct GIFSearchView: View {

    @StateObject private var viewModel: GIFSearchViewModel

    init(viewModel: GIFSearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    let columns = [
        GridItem(.flexible(), spacing: 0.5),
        GridItem(.flexible(), spacing: 0.5)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVGrid(columns: columns, spacing: 1) {
                        ForEach(viewModel.gifs, id: \.id) { gif in
                            NavigationLink {
                                GIFDetailView(gif: gif) {
                                    viewModel.didDoubleTap(for: gif)
                                }
                            } label: {
                                GIFCellView(gif: gif)
                            }
                            .onAppear {
                                viewModel.didScroll(to: gif)
                            }
                        }
                    }
                    .onReceive(viewModel.$scrollTo) { firstGif in
                        guard let firstGif else { return }
                        withAnimation {
                            proxy.scrollTo(firstGif.id)
                        }
                    }
                }
            }
            .navigationTitle("GIFPedia but SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $viewModel.queryText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "GIF 검색"
            )
            .onSubmit(of: .search) {
                viewModel.didTapSearchButton()
            }
        }
    }
}
