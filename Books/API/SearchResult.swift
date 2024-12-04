//  Created by Axel Ancona Esselmann on 7/9/24.
//

import Foundation

struct SearchResult: Codable {

    struct Doc: Codable {
        let key: String
    }

    let start: Int
    let numFound: Int
    let docs: [Doc]
}
