//  Created by Axel Ancona Esselmann on 7/11/24.
//

import SwiftUI
import LoadableView
import SwiftUIRouter

struct InlineAuthorView: IDedDefaultLoadableView {

    @EnvironmentObject
    private var router: AppRouter

    let id: String

    @StateObject
    var vm: AuthorViewModel

    init(id: String, service: ServiceType) {
        self.id = id
        let vm = AuthorViewModel(service: service)
        self._vm = StateObject(wrappedValue: vm)
    }

    func loaded(_ author: Author) -> some View {
        Text(author.name)
            .onTapGesture {
                router.present(.author(id), style: .modal)
            }
    }

    @ViewBuilder
    func errorView(_ error: Error) -> some View {
        Image(systemName: "wifi.exclamationmark")
    }

    @ViewBuilder
    func notLoaded() -> some View {
        Text("loading...")
    }
}

@MainActor
final class AuthorViewModel: IDedLoadableViewModel {

    @Published
    var viewState: ViewState<Author> = .notLoaded

    var overlayState: OverlayState = .none

    var id: String?

    private let service: ServiceType

    init(service: ServiceType) {
        self.service = service
    }

    func load(id: String) async throws -> Author {
        try await service.fetchAuthor(id: id)
    }
}

