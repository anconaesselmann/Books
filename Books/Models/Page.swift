//  Created by Axel Ancona Esselmann on 7/9/24.
//

import Foundation

struct Page: Equatable, Codable {
    let totalResults: Int
    let pageNumber: Int
    let ids: [String]
    let hasMore: Bool
}

extension Page {
    var hasElements: Bool {
        !ids.isEmpty
    }

    var nextPageNumber: Int? {
        guard hasMore else {
            return nil
        }
        return pageNumber + 1
    }
}
