//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation

extension Book {
    init(_ result: BookResult) throws {
        let authorIds = result.authors?
            .compactMap { $0.author.key.split(separator: "/").last }
            .map { String($0) } ?? []
        self = Book(
            id: result.key.value,
            title: result.title,
            authorIds: authorIds,
            description: result.description,
            coverUrls: result.covers
                .compactMap { URL(string: "https://covers.openlibrary.org/b/id/\($0)-M.jpg") }
        )
    }
}
