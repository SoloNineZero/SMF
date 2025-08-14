import UIKit

final class ShimmerPostCell: UITableViewCell {
    static let id = "ShimmerPostCell"

    private let avatarView: ShimmerView = {
        let view = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let authorView: ShimmerView = {
        let view = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
        
    private let bodyView: ShimmerView = {
        let view = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
        startAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startAnimation() {
        avatarView.startAnimating()
        authorView.startAnimating()
        bodyView.startAnimating()
    }

    private func setupSubviews() {
        contentView.addSubview(avatarView)
        contentView.addSubview(authorView)
        contentView.addSubview(bodyView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            avatarView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            avatarView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            avatarView.widthAnchor.constraint(equalToConstant: 50),
            avatarView.heightAnchor.constraint(equalToConstant: 50),
            
            authorView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            authorView.leftAnchor.constraint(equalTo: avatarView.rightAnchor, constant: 16),
            authorView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            authorView.heightAnchor.constraint(equalToConstant: 40),

            bodyView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 12),
            bodyView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            bodyView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            bodyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            bodyView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
    }
}
