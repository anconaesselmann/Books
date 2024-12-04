//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation

extension Page {
    init(result: SearchResult) {
        let pageNumber = result.start / 100 + 1
        let ids = result.docs.compactMap { $0.key.split(separator: "/").last }.map { String($0) }
        self = Page(
            totalResults: result.numFound,
            pageNumber: pageNumber,
            ids: ids,
            hasMore: result.start + ids.count < result.numFound
        )
    }
}
