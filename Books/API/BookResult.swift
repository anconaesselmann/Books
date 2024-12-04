//  Created by Axel Ancona Esselmann on 7/9/24.
//

import Foundation

struct BookResult: Codable {

    struct AuthorStub: Codable {
        struct AuthorKey: Codable {
            let key: String
        }
        let author: AuthorKey
    }

    struct Description: Codable {
        let value: String
        let type: String
    }

    let key: Key
    let title: String
    let authors: [AuthorStub]?
    let description: String?
    let covers: [String]

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(Key.self, forKey: .key)
        self.title = try container.decode(String.self, forKey: .title)
        self.authors = try container.decodeIfPresent([BookResult.AuthorStub].self, forKey: .authors)
        if let description = try? container.decodeIfPresent(BookResult.Description.self, forKey: .description) {
            self.description = description.value
        } else if let description = try? container.decodeIfPresent(String.self, forKey: .description) {
            self.description = description
        } else {
            self.description = nil
        }
        self.covers = (try? container.decodeIfPresent([Int].self, forKey: .covers))?.map { String($0) } ?? []
    }
}
