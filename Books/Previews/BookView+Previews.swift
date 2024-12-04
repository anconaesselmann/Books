//  Created by Axel Ancona Esselmann on 7/23/24.
//

import SwiftUI
import Ipsum

#Preview {
    BookView(
        id: "OL17860744W",
        vm: BookViewModel(
            service: MockService(
                books: [
                    "OL17860744W": Book(
                        id: "OL17860744W",
                        title: Ipsum().tag(),
                        authorIds: [
                            "OL7115219A",
                            "OL7115220A"
                        ],
                        description: Ipsum().paragraph(),
                        coverUrls: []
                    )
                ],
                authors: [
                    "OL7115219A": Author(id: "", name: "Test Author", bio: Ipsum().paragraph(), birthDate: "BD", photoIds: []),
                    "OL7115220A": Author(id: "", name: "Test Author2", bio: Ipsum().paragraph(), birthDate: "BD", photoIds: [])
                ]
            )
        )
    )
    .frame(width: 500, height: 500)
}
