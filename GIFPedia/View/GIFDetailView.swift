//
//  ContentView.swift
//  GIFPediaSwiftUI
//
//  Created by USER on 2023/06/09.
//

import SwiftUI
import NukeUI
import GIFPediaPresentationLayer

struct GIFDetailView: View {
    let gif: GIF
    let doubleTapHandler: (() -> Void)?

    init(gif: GIF, doubleTapHandler: (() -> Void)? = nil) {
        self.gif = gif
        self.doubleTapHandler = doubleTapHandler
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            LazyImage(url: gif.thumbnailUrl)
                .aspectRatio(contentMode: .fit)
            if gif.isPinned {
                Image(systemName: "pin.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.red)
                    .alignmentGuide(.bottom) { dimensions in
                        dimensions.height + 24
                    }
            }
        }
        .onTapGesture(count: 2) {
            doubleTapHandler?()
        }
        .navigationTitle(gif.title)
    }
}
