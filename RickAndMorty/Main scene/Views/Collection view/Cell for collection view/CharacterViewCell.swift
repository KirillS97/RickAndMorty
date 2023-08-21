//
//  CharacterViewCell.swift
//  RickAndMorty
//
//  Created by Kirill on 18.08.2023.
//

import UIKit

class CharacterViewCell: UICollectionViewCell {
    
    // MARK: Свойства класса
    static let reuseId = "CharacterViewCell"
    
    // MARK: Свойства объектов класса
    private var avatarImageView  : UIImageView!
    private var activityIndicator: UIActivityIndicatorView!
    private var nameLabel        : UILabel!
    private var verticalStack    : UIStackView!
    
    // MARK: Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpCharacterViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Подготовка к повторному использованию
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatarImageView.image = nil
        self.nameLabel.text = nil
        self.activityIndicator.startAnimating()
    }
    
    // MARK: Настройка ячейки
    private func setUpCharacterViewCell() -> Void {
        self.setUpAvatarImageView()
        self.setUpNameLabel()
        self.setUpVerticalStack()
        self.setUpActivityIndicator()
    }

}




// MARK: - Интерфейс ячейки
extension CharacterViewCell {
    
    func setUpAvatar(image: UIImage?) -> Void {
        self.avatarImageView.image = image
    }
    
    func setUpName(name: String) -> Void {
        self.nameLabel.text = name
    }
    
    func stopActivityIndicator() -> Void {
        self.activityIndicator.stopAnimating()
    }
    
}



// MARK: - Компоновка UI
extension CharacterViewCell {
    
    // MARK: Настройка avatarImageView
    private func setUpAvatarImageView() -> Void {
        self.avatarImageView = UIImageView()
        self.avatarImageView.layer.cornerRadius = 10
        self.avatarImageView.clipsToBounds = true
        self.addConstraintsToAvatarImageView()
    }
    
    private func addConstraintsToAvatarImageView() -> Void {
        self.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 140),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    // MARK: Настройка метки с именем
    private func setUpNameLabel() -> Void {
        self.nameLabel = UILabel()
        self.nameLabel.textColor = .white
        self.nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        self.nameLabel.textAlignment = .center
    }
    
    // MARK: Настройка вертикального стека
    private func setUpVerticalStack() -> Void {
        self.verticalStack = UIStackView()
        self.addSubview(self.verticalStack)
        self.verticalStack.axis = .vertical
        self.verticalStack.layoutMargins = .init(top: 8, left: 8, bottom: 16, right: 8)
        self.verticalStack.isLayoutMarginsRelativeArrangement = true
        self.verticalStack.spacing = 16
        self.verticalStack.alignment = .center
        self.verticalStack.layer.cornerRadius = 16
        self.verticalStack.backgroundColor = UIColor(red: (38/255), green: (42/255), blue: (56/255), alpha: 1)
        self.verticalStack.addArrangedSubview(self.avatarImageView)
        self.verticalStack.addArrangedSubview(self.nameLabel)
        self.addConstraintsToVerticalStack()
    }
    
    private func addConstraintsToVerticalStack() -> Void {
        self.verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.verticalStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.verticalStack.widthAnchor.constraint(equalToConstant: 156)
        ])
    }
    
    // MARK: Настройка индикатора загрузки
    private func setUpActivityIndicator() -> Void {
        self.activityIndicator = UIActivityIndicatorView(style: .medium)
        self.addSubview(self.activityIndicator)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color = .white
        self.addConstraintsToActivityIndicator()
        self.activityIndicator.startAnimating()
    }
    
    private func addConstraintsToActivityIndicator() -> Void {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.avatarImageView.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.avatarImageView.centerYAnchor)
        ])
    }
}
