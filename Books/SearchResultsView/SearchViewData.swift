//  Created by Axel Ancona Esselmann on 7/10/24.
//

import Foundation

// Immutable view data
struct SearchResultsViewData: Equatable {
    let query: String
    let pages: [Page]
    let isFetchingMore: Bool

    private init(query: String, pages: [Page], isFetchingMore: Bool) {
        self.query = query
        self.pages = pages
        self.isFetchingMore = isFetchingMore
    }
}

extension SearchResultsViewData {
    var total: Int {
        pages.last?.totalResults ?? 0
    }

    var ids: [String] {
        pages.flatMap { $0.ids }
    }

    var hasMoreResults: Bool {
        total != ids.count
    }

    init(query: String = "") {
        self = .init(query: query, pages: [], isFetchingMore: false)
    }

    init(query: String, firstPage: Page) {
        self = .init(query: query, pages: [firstPage], isFetchingMore: false)
    }

    func fetchingMore() -> Self {
        .init(query: query, pages: pages, isFetchingMore: true)
    }

    func shouldFetchMore(for elementId: String) -> Bool {
        if
            !isFetchingMore,
            let lastPage = pages.last,
            lastPage.hasMore
        {
            let tail = Set(lastPage.ids.suffix(20))
            return tail.contains(elementId)
        }
        return false
    }

    func added(_ page: Page) -> Self {
        .init(query: query, pages: pages + [page], isFetchingMore: false)
    }
}
