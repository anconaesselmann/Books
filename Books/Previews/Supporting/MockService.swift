//  Created by Axel Ancona Esselmann on 7/22/24.
//

import Foundation

struct MockService: ServiceType {

    var books: [String: Book] = [:]
    var authors: [String: Author] = [:]
    var editions: [String: [Edition]] = [:]

    func fetchPage(_ pageNumber: Int, for query: String) async throws -> Page {
        fatalError()
    }

    func fetchBook(id: String) async throws -> Book {
        books[id]!
    }

    func fetchAuthor(id: String) async throws -> Author {
        authors[id]!
    }

    func fetchEditions(id: String) async throws -> [Edition] {
        editions[id]!
    }

    func cancel(id: String) async { }
}
