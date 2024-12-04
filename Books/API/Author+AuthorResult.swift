//  Created by Axel Ancona Esselmann on 7/26/24.
//

import Foundation

extension Author {
    init(_ result: AuthorResult) throws {
        id = result.key.value
        name = result.name
        bio = result.bio
        birthDate = result.birth_date
        photoIds = result.photos?.filter { $0 > 0} ?? []
    }
}
