//  Created by Axel Ancona Esselmann on 7/26/24.
//

import Foundation
import SwiftUIRouter

enum Route: RouteType {

    case search
    case book(String)
    case author(String)
    case editions(String)

    enum RouteNames: String { case search, works, author, editions }

    var rawValue: String {
        switch self {
        case .search:
            return RouteNames.search.rawValue
        case .book(let id):
            return "\(RouteNames.works.rawValue)/\(id)"
        case .author(let id):
            return "\(RouteNames.author.rawValue)/\(id)"
        case .editions(let id):
            return "\(RouteNames.editions.rawValue)/\(id)"
        }
    }

    init?(rawValue: String) {
        guard
            let (route, value) = Self.parts(for: rawValue),
            let value = value
        else {
            return nil
        }
        switch route {
        case RouteNames.search.rawValue: self = .search
        case RouteNames.works.rawValue: self = .book(value)
        case RouteNames.author.rawValue: self = .author(value)
        case RouteNames.editions.rawValue: self = .editions(value)
        default: return nil
        }
    }
}

extension URL {
    init?(appUrl path: String) {
        self.init(string: "\(AppLink.openlibrary.rawValue)://\(path)")
    }

    init?<R>(_ route: R) where R: RouteType {
        self.init(appUrl: route.rawValue)
    }
}

extension URL {
    static let search = URL(Route.search)

    static func book(_ value: String) -> URL? {
        URL(Route.book(value))
    }
    static func author(_ value: String) -> URL? {
        URL(Route.author(value))
    }
    static func editions(_ value: String) -> URL? {
        URL(Route.editions(value))
    }
}
