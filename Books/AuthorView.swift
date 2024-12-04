//  Created by Axel Ancona Esselmann on 7/11/24.
//

import SwiftUI
import LoadableView
import LoadableImageView
import SwiftUIMarkdownView

struct AuthorView: IDedDefaultLoadableView {

    let id: String

    @StateObject
    var vm: AuthorViewModel

    init(id: String, service: ServiceType) {
        self.id = id
        let vm = AuthorViewModel(service: service)
        self._vm = StateObject(wrappedValue: vm)
    }

    func loaded(_ author: Author) -> some View {
        VStack {
            LoadableImageView(url: author.mediumPhotos.first, cache: DiscImageCache.shared)
            Text(author.name)
            if let bio = author.bio {
                MarkdownView(markdown: bio)
            }
            if let birthDate = author.birthDate {
                Text(birthDate)
            }
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
