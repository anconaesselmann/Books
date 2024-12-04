//  Created by Axel Ancona Esselmann on 7/26/24.
//

import Foundation

struct EditionsResult: Decodable {

    struct Entry: Decodable {
        let key: Key
        let title: String
    }
    
    let size: Int
    let entries: [Entry]
}
