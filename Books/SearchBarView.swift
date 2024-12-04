//  Created by Axel Ancona Esselmann on 7/21/24.
//

import SwiftUI

struct SearchBarView: View {

    let isDebouncing: Bool

    @Binding
    var query: String

    var body: some View {
        HStack(spacing: 0) {
            if isDebouncing {
                ProgressView()
                    .scaleEffect(0.5)
                    .frame(width: 50, height: 50)
            } else {
                Image(systemName: "magnifyingglass")
                    .frame(width: 50, height: 50)
            }
            TextField("Search", text: $query)
                .padding([.vertical, .trailing], 8)
        }
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.3))
    }
}
