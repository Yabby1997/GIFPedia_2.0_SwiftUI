//
//  GIFCell.swift
//  GIFPediaSwiftUI
//
//  Created by USER on 2023/06/09.
//

import SwiftUI
import NukeUI
import GIFPediaPresentationLayer

struct GIFCellView: View {
    let gif: GIF

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            LazyImage(url: gif.thumbnailUrl)
                .aspectRatio(contentMode: .fit)
            if gif.isPinned {
                Image(systemName: "pin.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
                    .alignmentGuide(.bottom) { dimensions in
                        dimensions.height + 12
                    }
            }
        }
    }
}
