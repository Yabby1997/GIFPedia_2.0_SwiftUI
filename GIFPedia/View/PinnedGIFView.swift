//
//  PinnedGIFView.swift
//  GIFPediaSwiftUI
//
//  Created by USER on 2023/06/09.
//

import SwiftUI
import NukeUI
import GIFPediaPresentationLayer

struct PinnedGIFView: View {

    @StateObject private var viewModel: PinnedGIFViewModel

    init(viewModel: PinnedGIFViewModel) {
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
                        }
                    }
                }
            }
            .navigationTitle("GIFPedia but SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
