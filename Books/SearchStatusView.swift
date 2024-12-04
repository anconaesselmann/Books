//  Created by Axel Ancona Esselmann on 7/21/24.
//

import SwiftUI

struct SearchStatusView: View {

    var total: Int
    var idCount: Int

    var body: some View {
        HStack {
            Text("Total: \(total)")
            Text("Ids: \(idCount)")
        }
        .padding(4)
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.3))
    }
}
