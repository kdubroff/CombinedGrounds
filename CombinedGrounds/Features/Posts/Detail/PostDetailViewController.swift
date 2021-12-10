//
//  PostDetailViewController.swift
//  CombinedGrounds
//
//  Created by Kenny Dubroff on 12/10/21.
//

import UIKit

class PostDetailViewController: UIViewController {
    var post: Post

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("programmatic")
    }

    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, bodyTextView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        return label
    }()

    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.isEditable = false
        return textView
    }()

    private func setupViews() {
        view.backgroundColor = .systemBackground
        titleLabel.text = post.title
        bodyTextView.text = post.body

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
}
