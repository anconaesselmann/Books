//  Created by Axel Ancona Esselmann on 7/8/24.
//

import SwiftUI
import Debounced

struct SearchView: View {

    @Debounced(for: .seconds(0.3))
    private var query: String = ""

    var body: some View {
        VStack(spacing: 0) {
            SearchBarView(isDebouncing: _query.isDebouncing, query: $query)
            SearchResultsView(query: query.trimmingCharacters(in: .whitespaces))
        }
    }
}
