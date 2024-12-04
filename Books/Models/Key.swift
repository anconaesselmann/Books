//  Created by Axel Ancona Esselmann on 7/26/24.
//

import Foundation

struct Key: Codable {

    enum Error: Swift.Error {
        case invalidKey
    }

    let value: String

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard let key = try container.decode(String.self).split(separator: "/").last else {
            throw Error.invalidKey
        }
        self.value = String(key)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
