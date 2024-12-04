//  Created by Axel Ancona Esselmann on 7/23/24.
//

import Foundation
import LoadableView

@MainActor
final class BookViewModel: IDedLoadableViewModel {

    @Published
    var viewState: ViewState<Book> = .notLoaded

    var overlayState: OverlayState = .none

    var id: String?

    let service: ServiceType

    init(service: ServiceType) {
        self.service = service
    }

    func load(id: String) async throws -> Book {
        try await service.fetchBook(id: id)
    }

    func cancel(id: String) async {
        await service.cancel(id: id)
    }
}
