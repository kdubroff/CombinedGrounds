//
//  PostViewModel.swift
//  CombinedGrounds
//
//  Created by Kenny Dubroff on 12/10/21.
//

import Foundation
import Combine

class PostViewModel {
    @Published var posts: [Post] = []

    private var postBacking: [Post] = [] {
        didSet {
            for var post in postBacking {
                post.title = formatPostTitle(post.title)
                posts.append(post)
            }
        }
    }

    private var cancellable: AnyCancellable?

    private var nextId: Int {
        guard let max = posts.map({ $0.id }).max() else { return 0 }
        return max + 1
    }

    init() {
        getPosts()
    }

    private func getPosts() {
        let jsonDecoder = JSONDecoder()

        let dataResult = AppDelegate.shared.networkManager.getData()
            .decode(type: [Post].self, decoder: jsonDecoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
            .catch { _ in Just([Post]()) }
            .assign(to: \.postBacking, on: self)

        self.cancellable = dataResult
    }
    
    func addPost(title: String, body: String, userId: Int) {
        let post = Post(userId: userId, id: nextId, title: title, body: body)
        postBacking.append(post)
    }
    /// First edit post attributes, then call this method to replace with the edited post
    /// - NOTE: Performance can be improved by converting `postCollection` to a Dictionary
    func editPost(_ post: Post) {
        postBacking.removeAll(where: { $0.id == post.id })
        postBacking.append(post)
    }

    private func formatPostTitle(_ title: String) -> String {
        title.firstCapitalized
    }

    private func getPost(with id: Int) -> Post? {
        return posts.first(where: {$0.id == id})
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
