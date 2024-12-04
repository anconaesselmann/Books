//  Created by Axel Ancona Esselmann on 7/10/24.
//

import SwiftUI
import LoadableView
import Combine
import Debounced

@MainActor
final class SearchResultsViewModel: IDedLoadableViewModel {

    var id: String?

    @Published
    var viewState: ViewState<SearchResultsViewData> = .notLoaded

    private(set) var overlayState: OverlayState = .none

    let service: ServiceType = Service.shared

    private var subscription: AnyCancellable?

    func load(id query: String) async throws -> SearchResultsViewData {
        guard let currentViewData = viewState.loaded, query.count >= 3 else {
            return SearchResultsViewData(query: query)
        }
        guard currentViewData.query != query else {
            throw CancellationError()
        }
        return SearchResultsViewData(
            query: query,
            firstPage: try await service.fetchFirstPage(for: query)
        )
    }

    func viewing(bookWithId elementId: String) {
        guard let query = viewState.loaded?.query else {
            return
        }
        Task {
            do {
                guard let updated = try await fetchMoreIfNeeded(query, viewing: elementId) else {
                    return
                }
                refresh(with: updated)
            } catch {
                setError(error)
            }
        }
    }

    private func fetchMoreIfNeeded(
        _ query: String,
        viewing: String
    ) async throws -> SearchResultsViewData? {
        guard
            let viewData = viewState.loaded,
            let nextPageNumber = viewData.pages.last?.nextPageNumber,
            viewData.shouldFetchMore(for: viewing)
        else {
            return nil
        }
        update(with: viewData.fetchingMore())
        let nextPage = try await service.fetchPage(
            nextPageNumber,
            for: viewData.query
        )
        guard nextPage.hasElements else {
            return nil
        }
        return viewData.added(nextPage)
    }
}
