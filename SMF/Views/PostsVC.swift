import UIKit

final class PostsVC: UIViewController {
    
    private var viewModel = PostsViewModel()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.id)
        tableView.register(ShimmerPostCell.self, forCellReuseIdentifier: ShimmerPostCell.id)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = title
    }
    
    private func bindViewModel() {
        viewModel.onPostsUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    
        viewModel.onError = { [weak self] error in
            let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            self?.present(alert, animated: true)
        }
        
        viewModel.loadData()
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

// MARK: - UITableViewDataSource
extension PostsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.postsWithAuthor.isEmpty ? 5 : viewModel.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.postsWithAuthor.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ShimmerPostCell.id, for: indexPath) as? ShimmerPostCell else {
                return UITableViewCell()
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.id, for: indexPath) as? PostCell else {
                return UITableViewCell()
            }
            cell.configure(post: viewModel.postsWithAuthor[indexPath.row])
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension PostsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
