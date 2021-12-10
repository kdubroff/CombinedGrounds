//
//  PostListCell.swift
//  CombinedGrounds
//
//  Created by Kenny Dubroff on 12/10/21.
//

import UIKit

class PostListCell: UITableViewCell {
    static var identifier = "PostListCell"

    var post: Post! {
        didSet {
            setupViews()
        }
    }

    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, bodyPreviewLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .darkText
        return label
    }()

    lazy var bodyPreviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()

    private func setupViews() {
        titleLabel.text = post.title
        bodyPreviewLabel.text = "    \(post.body)"

        if !subviews.contains(stackView) {
            addSubview(stackView)

            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
                stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
                stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
                stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12)
            ])
        }
    }
}
