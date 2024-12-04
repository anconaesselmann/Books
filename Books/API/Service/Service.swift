//  Created by Axel Ancona Esselmann on 7/8/24.
//

import Foundation
import AsyncService

class Service: ServiceType {

    static let shared = Service()

    private let api: API = .openLibrary

    func fetchPage(_ page: Int, for query: String) async throws -> Page {
        try await cached(String(ids: query, page), group: "search") { [unowned self] in
            try await api
                .fetch(
                    SearchResult.self,
                    for: .search, [.query(query), .fields("key"), .page(page)],
                    cancelWith: "fetchPage"
                )
                .map(Page.init)
        }
    }

    func fetchBook(id: String) async throws -> Book {
        try await cached(id, group: "book") { [unowned self] in
            try await self.api
                .fetch(
                    BookResult.self,
                    for: .works(id),
                    cancelWith: id
                )
                .mapResponse(Book.init)
                .value
        }
    }

    func fetchAuthor(id: String) async throws -> Author {
        try await cached(id, group: "author") { [unowned self] in
            try await self.api
                .fetch(
                    AuthorResult.self,
                    for: .authors(id), []
                )
                .mapResponse(Author.init)
                .value
        }
    }

    // TODO: Currently only fetches first page (first 50 results)
    func fetchEditions(id: String) async throws -> [Edition] {
        try await cached(id, group: "editions") { [unowned self] in
            try await self.api
                .fetch(
                    EditionsResult.self,
                    for: .editions(id),
                    cancelWith: id
                )
                .mapResponse(Array<Edition>.init)
                .value
        }
    }

    func cancel(id: String) async {
        await api.cancel(id)
    }
}
