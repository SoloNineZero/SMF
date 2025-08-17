import UIKit
import CoreData

final class FavoriteVC: UIViewController {
    
    private var viewModel = FavoritePostsViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.id)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = title
        
        setupSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.viewModel.loadPosts()
            self.tableView.reloadData()
        }
    }

    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavoriteVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.id, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        let post = viewModel.posts[indexPath.row]
        cell.configute(post: post)
        cell.onFavoriteTapped = { [weak self] in
            guard self != nil else { return }
            
            CoreDataService.shared.deletePost(post)
            self?.viewModel.loadPosts()
            self?.tableView.reloadData()
        }
        return cell
    }
}

