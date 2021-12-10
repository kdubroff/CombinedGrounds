//
//  PostDetailViewController.swift
//  CombinedGrounds
//
//  Created by Kenny Dubroff on 12/10/21.
//

import UIKit

class PostDetailViewController: UIViewController {
    var post: Post?
    var viewModel: PostViewModel

    init(post: Post? = nil, viewModel: PostViewModel) {
        self.post = post
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("programmatic")
    }

    lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.isEditable = isEditing
        return textView
    }()

    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.isEditable = isEditing
        return textView
    }()

    private func setupViews() {
        view.backgroundColor = .systemBackground
        titleTextView.text = post?.title
        bodyTextView.text = post?.body

        view.addSubview(titleTextView)
        view.addSubview(bodyTextView)
        setupEditButton()
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleTextView.heightAnchor.constraint(equalToConstant: 100),

            bodyTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 20),
            bodyTextView.trailingAnchor.constraint(equalTo: titleTextView.trailingAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            bodyTextView.leadingAnchor.constraint(equalTo: titleTextView.leadingAnchor)
        ])

    }
}
