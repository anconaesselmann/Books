//  Created by Axel Ancona Esselmann on 7/21/24.
//

import SwiftUI
import LoadableView
import SwiftUIMarkdownView

struct SearchResultsView: IDedDefaultLoadableView {

    let id: String

    @StateObject
    var vm = SearchResultsViewModel()

    init(query: String) {
        id = query
    }

    func loaded(_ viewData: SearchResultsViewData) -> some View {
        VStack(spacing: 0) {
            List {
                ForEach(viewData.ids, id: \.self) { bookId in
                    BookView(id: bookId, vm: BookViewModel(service: vm.service))
                    // Note: task {} doesn't work here because it doesn't finish on refresh
                        .onAppear { vm.viewing(bookWithId: bookId) }
                        .frame(maxWidth: .infinity)
                }
                if viewData.hasMoreResults {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                }
            }
            .environment(\.defaultMinListRowHeight, 150)
            SearchStatusView(
                total: viewData.total,
                idCount: viewData.ids.count
            )
        }
        .scrollContentBackground(.hidden)
    }

    func notLoaded() -> some View {
        VStack {
            Spacer()
        }
    }
}
