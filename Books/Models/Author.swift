//  Created by Axel Ancona Esselmann on 7/11/24.
//

import Foundation

struct Author: Identifiable, Codable {
    let id: String
    let name: String
    let bio: String?
    let birthDate: String?
    let photoIds: [Int]
}

extension Author {
    var mediumPhotos: [URL] {
        photoIds.compactMap { URL(string: "https://covers.openlibrary.org/a/id/\($0)-M.jpg") }
    }
}
