//  Created by Axel Ancona Esselmann on 7/22/24.
//

import Foundation

protocol ServiceType {
    func fetchFirstPage(for query: String) async throws -> Page
    func fetchPage(_ pageNumber: Int, for query: String) async throws -> Page
    func fetchBook(id: String) async throws -> Book
    func fetchAuthor(id: String) async throws -> Author
    func fetchEditions(id: String) async throws -> [Edition]
    func cancel(id: String) async
}

extension ServiceType {
    func fetchFirstPage(for query: String) async throws -> Page {
        try await fetchPage(1, for: query)
    }
}
