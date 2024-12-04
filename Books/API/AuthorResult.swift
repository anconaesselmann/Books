//  Created by Axel Ancona Esselmann on 7/11/24.
//

import Foundation

struct AuthorResult: Decodable {
    let key: Key
    let name: String

//    links
//    type
//    personal_name
    let bio: String?
    let birth_date: String?
//    alternate_names
//    remote_ids
//    key
    let photos: [Int]?
//    source_records
//    latest_revision
//    revision
//    created
//    last_modified
//    title
//    wikipedia
//    entity_type
//    fuller_name
}
