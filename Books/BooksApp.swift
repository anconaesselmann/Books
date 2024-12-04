//  Created by Axel Ancona Esselmann on 7/8/24.
//

import SwiftUI
import SwiftUIRouter

typealias RootRouter = Router<Route>

enum AppLink: String {
    case openlibrary
}

@main
struct BooksApp: App {

    @StateObject
    var rootRouter = RootRouter()

    var body: some Scene {
        WindowGroup {
            NavigationTarget(Route.search, content: Factory.init)
                .onDeeplink(
                    with: AppLink.openlibrary.rawValue,
                    use: rootRouter
                )
                .presentModal(for: rootRouter) { route in
                    Modal {
                        Factory(route: route)
                    }
                }
        }
    }
}
