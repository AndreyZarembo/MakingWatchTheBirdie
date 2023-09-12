//
//  ContentSource.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.09.2023.
//

import Foundation

enum ContentState {
    case loading
    case hasMore
    case done
}

protocol ContentSource: AnyObject {
    func loadMore(after mediaItem: MediaItem?, batchSize: Int) async throws -> [MediaItem]
}

class Content: ObservableObject {

    var contentSource: ContentSource
    init(contentSource: ContentSource) {
        self.contentSource = contentSource
    }
        
    @Published var images: [MediaItem] = []
    @Published var state: ContentState = .hasMore
    
    func loadMore(_ batchSize: Int) async {
        self.state = .loading
        let nextImages = (try? await contentSource.loadMore(after: images.last, batchSize: batchSize)) ?? []
        images += nextImages
        state = nextImages.count == 0 ? .done : .hasMore
    }
}
