//
//  GIFPediaApp.swift
//  GIFPedia
//
//  Created by USER on 2023/06/09.
//

import SwiftUI
import GIFPediaService
import GiphyRepository
import TenorRepository
import PinnedGIFPersistence
import SHURLSessionNetworkService
import SHUserDefaultsPersistenceService
import GIFPediaPresentationLayer

@main
struct GIFPediaApp: App {
    private var gifPinService: GIFFlagService = {
        let persistenceService = SHUserDefaultsPersistenceService()
        let pinnedGIFPersistence = PinnedGIFPersistence(persistenceService: persistenceService)
        return GIFFlagService(gifPersistence: pinnedGIFPersistence)
    }()

    var body: some Scene {
        WindowGroup {
            TabView {
                GIFSearchView(
                    viewModel: GIFSearchViewModel(
                        searchService: GIFPediaSearchService(
                            gifRepository: GiphyRepository(
                                networkService: SHURLSessionNetworkService(),
                                apiKey: "7FckdoA95APjXjzIPCRm9he4wpaa6DFC"
                            )
                        ),
                        pinService: gifPinService
                    )
                )
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Giphy")
                }
                GIFSearchView(
                    viewModel: GIFSearchViewModel(
                        searchService: GIFPediaSearchService(
                            gifRepository: TenorRepository(
                                networkService: SHURLSessionNetworkService(),
                                apiKey: "AIzaSyAyqL6ZgYRj60GIMveovpSLqAsmyGp2BRE"
                            )
                        ),
                        pinService: gifPinService
                    )
                )
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Tenor")
                }
                PinnedGIFView(
                    viewModel: PinnedGIFViewModel(
                        pinService: gifPinService
                    )
                )
                .tabItem {
                    Image(systemName: "pin.circle")
                    Text("Pinned")
                }
            }
        }
    }
}
