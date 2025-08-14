import UIKit

final class ShimmerView: UIView {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayer()
    }

    /// Настраивает внешний вид слоя для shimmer-заглушки:
    /// - Устанавливает фон и скруглённые углы.
    /// - Создаёт горизонтальный градиент для эффекта бегущего света.
    private func setupLayer() {
        backgroundColor = UIColor.systemGray5
        layer.cornerRadius = 8
        clipsToBounds = true

        gradientLayer.colors = [
            UIColor.systemGray5.cgColor,
            UIColor.systemGray4.cgColor,
            UIColor.systemGray5.cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    /// Запускает shimmer-анимацию:
    /// - Создаёт базовую анимацию для свойства `locations` у градиента.
    /// - Смещает точки цветового перехода от отрицательных значений до значений за пределами слоя.
    /// - Длительность одного прохода — 1.2 секунды.
    /// - Анимация повторяется бесконечно.
    func startAnimating() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.2
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmerAnimation")
    }

    func stopAnimating() {
        gradientLayer.removeAnimation(forKey: "shimmerAnimation")
    }
}
