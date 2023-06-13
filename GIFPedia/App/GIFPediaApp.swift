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

    // https://developers.giphy.com/dashboard/?create=true
    private let giphyAPIKey = "ENTER_YOUR_GIPHY_API_KEY_FROM_ABOVE_LINK"

    // https://developers.google.com/tenor/guides/quickstart#:~:text=login-,Get%20a,Tenor%20API%20key,-You%20can%20sign
    private let tenorAPIKey = "ENTER_YOUR_TENOR_API_KEY_FROM_ABOVE_LINK"

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
                                apiKey: giphyAPIKey
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
                                apiKey: tenorAPIKey
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
