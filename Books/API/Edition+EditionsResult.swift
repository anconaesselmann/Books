//  Created by Axel Ancona Esselmann on 7/26/24.
//

import Foundation

extension Edition {
    init(_ result: EditionsResult.Entry) {
        self.title = result.title
        self.id = result.key.value
    }
}

extension Array where Element == Edition {
    init(_ result: EditionsResult) {
        self = result.entries.map { Edition($0) }
    }
}
