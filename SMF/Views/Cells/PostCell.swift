import UIKit

final class PostCell: UITableViewCell {
    
    static let id = "PostCell"

    private lazy var avatarUIImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSunbviews()
        setupConstraints()
        setupSelectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarUIImageView.layoutIfNeeded()
        avatarUIImageView.layer.cornerRadius = avatarUIImageView.bounds.width / 2
    }
    
    func configure(post: PostWithAuthor) {
        titleLabel.text = post.post.title
        bodyLabel.text = post.post.body
        authorLabel.text = post.author?.name
        
        guard let data = post.author?.avatar else { return }
        avatarUIImageView.image = UIImage(data: data)
    }
    
    private func setupSunbviews() {
        contentView.addSubview(avatarUIImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(authorLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            avatarUIImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            avatarUIImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarUIImageView.widthAnchor.constraint(equalToConstant: 50),
            
            authorLabel.centerYAnchor.constraint(equalTo: avatarUIImageView.centerYAnchor),
            authorLabel.leftAnchor.constraint(equalTo: avatarUIImageView.rightAnchor, constant: 16),
            authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: avatarUIImageView.bottomAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            bodyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            bodyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupSelectionView() {
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        selectedView.layer.cornerRadius = 8
        selectedBackgroundView = selectedView
    }
}
