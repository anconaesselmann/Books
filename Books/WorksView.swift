//  Created by Axel Ancona Esselmann on 7/26/24.
//

import SwiftUI
import LoadableView

struct WorksView: IDedDefaultLoadableView {
    let id: String

    @StateObject
    var vm: WorksViewModel

    init(id: String, service: ServiceType) {
        self.id = id
        let vm = WorksViewModel(service: service)
        self._vm = StateObject(wrappedValue: vm)
    }

    func loaded(_ viewData: [Edition]) -> some View {
        List {
            ForEach(viewData) {
                Text($0.title)
            }
        }
    }
}

@MainActor
final class WorksViewModel: IDedLoadableViewModel {

    @Published
    var viewState: ViewState<[Edition]> = .notLoaded

    var overlayState: OverlayState = .none

    var id: String?

    private let service: ServiceType

    init(service: ServiceType) {
        self.service = service
    }

    func load(id: String) async throws -> [Edition] {
        try await service.fetchEditions(id: id)
    }
}

