//  Created by Axel Ancona Esselmann on 7/8/24.
//

import SwiftUI
import LoadableView
import LoadableImageView
import SwiftUIMarkdownView
import LoadableView
import SwiftUIRouter

struct BookView: IDedDefaultLoadableView {

    let id: String

    @EnvironmentObject
    private var router: AppRouter

    @StateObject
    var vm: BookViewModel

    func loaded(_ book: Book) -> some View {
        VStack {
            HStack {
                VStack {
                    LoadableImageView(
                        url: book.coverUrls.first,
                        cache: DiscImageCache.shared
                    )
                    .frame(width: 60, height: 100)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerSize: .init(width: 5, height: 5)))
                    Spacer()
                }
                VStack {
                    Text(book.title)
                        .font(.title)
                    HStack(spacing: 0) {
                        VStack {
                            if book.authorIds.isEmpty {
                                Text("by unknown author")
                            } else {
                                ForEach(0..<book.authorIds.count, id: \.self) { index in
                                    HStack(spacing: 0) {
                                        if index == 0 {
                                            Text("by ")
                                        }
                                        InlineAuthorView(
                                            id: book.authorIds[index],
                                            service: vm.service
                                        )
                                        .font(.title3)
                                        if index < book.authorIds.count - 1 {
                                            Text(", ")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if let description = book.description {
                        MarkdownView(
                            markdown: description.replacing("https://\(AppLink.openlibrary.rawValue).org/", with: "\(AppLink.openlibrary.rawValue)://")
                        ).padding(.top, 16)
                    }
                    Spacer()
                }.frame(maxWidth: .infinity)
            }
        }
        .padding(8)
        .onTapGesture {
            router.present(.editions(id), style: .modal)
        }
    }
}

extension BookView: Equatable {
    static func == (lhs: BookView, rhs: BookView) -> Bool {
        lhs.id == rhs.id
    }
}
