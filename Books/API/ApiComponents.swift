//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation
import AsyncService

extension API {
    static let openLibrary = API("https://openlibrary.org")
}

extension Path {
    static let search = Path("search.json")
    
    static func works(_ id: String) -> Path {
        Path("works/\(id).json")
    }

    static func editions(_ id: String) -> Path {
        Path("works/\(id)/editions.json")
    }

    static func authors(_ id: String) -> Path {
        Path("authors/\(id).json")
    }
}

extension QueryP {
    static func query(_ value: String) -> Self {
        .init("q", value)
    }
    static func fields(_ value: String) -> Self {
        .init("fields", value)
    }
    static func page(_ value: Int) -> Self {
        .init("page", value)
    }
}
