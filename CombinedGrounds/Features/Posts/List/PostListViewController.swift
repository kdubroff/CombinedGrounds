//
//  ViewController.swift
//  CombinedGrounds
//
//  Created by Kenny Dubroff on 12/9/21.
//

import UIKit
import Combine

class PostListViewController: UITableViewController {
    var spinner: UIActivityIndicatorView!
    var viewModel: PostViewModel = PostViewModel()
    private var cancelSet: Set<AnyCancellable> = []

    var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
            spinner.stopAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        spinner.startAnimating()

        viewModel.$posts.eraseToAnyPublisher()
            .compactMap{$0}
            .sink() {
                self.posts = $0
            }
            .store(in: &cancelSet)
    }

    private func setSpinner() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        spinner.layer.cornerRadius = 10
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.layer.zPosition = 1
        self.spinner = spinner
        view.addSubview(spinner)
    }

    private func setAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPost))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc private func addPost() {
        let detailViewController = PostDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    private func setupViews() {
        tableView.register(PostListCell.self, forCellReuseIdentifier: PostListCell.identifier)
        
        navigationController?.navigationBar.prefersLargeTitles = true

        self.title = "Posts"
        setSpinner()
        setAddButton()
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
// MARK: TableView DataSource
extension PostListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.identifier) as! PostListCell
        cell.post = posts[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let detailViewController = PostDetailViewController(post: post, viewModel: viewModel)
        detailViewController.modalPresentationStyle = .fullScreen
        detailViewController.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
