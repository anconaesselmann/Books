//  Created by Axel Ancona Esselmann on 7/8/24.
//

import Foundation

struct Book: Identifiable, Codable {
    let id: String
    let title: String
    let authorIds: [String]
    let description: String?
    let coverUrls: [URL]
}
