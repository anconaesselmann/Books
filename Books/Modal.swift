//  Created by Axel Ancona Esselmann on 7/26/24.
//

import SwiftUI
import SwiftUIRouter

struct Modal<Content>: View, ModalType
    where Content: View
{

    @ViewBuilder
    var content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        Sheet {
            content()
        }
        .frame(minWidth: 300, minHeight: 300)
    }
}

struct Factory: View {

    let route: Route

    var body: some View {
        switch route {
        case .search:
            SearchView()
        case .author(let id):
            AuthorView(id: id, service: Service.shared)
        case .book(let id):
            BookView(id: id, vm: BookViewModel(service: Service.shared))
        case .editions(let id):
            WorksView(id: id, service: Service.shared)
        }
    }
}
