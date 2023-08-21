//
//  CharacterDescriptionTableViewCell.swift
//  RickAndMorty
//
//  Created by Kirill on 20.08.2023.
//

import UIKit



class CharacterDescriptionTableViewCell: UITableViewCell {
    
    // MARK: Свойства класса
    static let reuseId = "CharacterDescriptionTableViewCell"
    
    // MARK: Свойства объектов класса
    private var verticalStack      : UIStackView!
    private var avatarImageView    : UIImageView!
    private var characterNameLabel : UILabel!
    private var characterStateLabel: UILabel!
    private var activityIndicator  : UIActivityIndicatorView!
    
    // MARK: Инициализаторы
    init() {
        super.init(style: .default, reuseIdentifier: CharacterDescriptionTableViewCell.reuseId)
        self.setUpCharacterDescriptionTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Настройка ячейки
    private func setUpCharacterDescriptionTableViewCell() -> Void {
        self.setUpBackgroundColor()
        self.isUserInteractionEnabled = false
        self.setUpAvatarImageView()
        self.setUpCharacterNameLabel()
        self.setUpCharacterStateLabel()
        self.setUpVerticalStack()
        self.setUpActivityIndicator()
    }
    
    private func setUpBackgroundColor() -> Void {
        self.backgroundColor = AppColors.mainColor.getColor()
    }
    
}



// MARK: - Интерфейс и конфигурирование ячейки
extension CharacterDescriptionTableViewCell {
    
    // MARK: - Интерфейс
    func configure(characterName: String, characterStatus: String) -> Void {
        self.setUpCharacterName(name: characterName)
        self.setUpCharacterState(state: characterStatus)
    }
    
    func stopActivityIndicator() -> Void {
        self.activityIndicator.stopAnimating()
    }
    
    // MARK: Установка аватара
    func setUpAvatar(image: UIImage?) -> Void {
        self.avatarImageView.image = image
    }
    
    // MARK: Установка имени персонажа
    private func setUpCharacterName(name: String) -> Void {
        self.characterNameLabel.text = name
    }
    
    // MARK: Установка состояния персонажа
    private func setUpCharacterState(state: String) -> Void {
        self.characterStateLabel.text = state
        self.setUpCharacterStateLabelColor()
    }
    
}



// MARK: - Компоновка UI ячейки
extension CharacterDescriptionTableViewCell {
        
    
    
    // MARK: Настройка аватара
    private func setUpAvatarImageView() -> Void {
        self.avatarImageView = UIImageView()
        self.avatarImageView.layer.cornerRadius = 16
        self.avatarImageView.clipsToBounds = true
        self.addConstraintsToAvatarImageView()
    }
    
    private func addConstraintsToAvatarImageView() -> Void {
        self.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 148),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    
    
    // MARK: Настройка метки с именем персонажа
    private func setUpCharacterNameLabel() -> Void {
        self.characterNameLabel = UILabel()
        self.characterNameLabel.textColor = .white
        self.characterNameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        self.characterNameLabel.textAlignment = .center
    }
    
    
    
    // MARK: Настройка метки с состоянием персонажа (жив/мертв)
    private func setUpCharacterStateLabel() -> Void {
        self.characterStateLabel = UILabel()
        self.characterStateLabel.font = .systemFont(ofSize: 16, weight: .regular)
        self.characterStateLabel.textAlignment = .center
    }
    
    private func setUpCharacterStateLabelColor() -> Void {
        if let stateDescription = self.characterStateLabel.text {
            if stateDescription == "Alive" {
                self.characterStateLabel.textColor = AppColors.greenText.getColor()
            } else {
                self.characterStateLabel.textColor = .systemRed
            }
        }
    }
    
    
    
    // MARK: Настройка вертикального стека
    private func setUpVerticalStack() -> Void {
        self.verticalStack = UIStackView()
        self.addSubview(self.verticalStack)
        self.verticalStack.axis = .vertical
        self.verticalStack.spacing = 0
        self.verticalStack.alignment = .center
        self.verticalStack.addArrangedSubview(self.avatarImageView)
        self.verticalStack.setCustomSpacing(24, after: self.avatarImageView)
        self.verticalStack.addArrangedSubview(self.characterNameLabel)
        self.verticalStack.setCustomSpacing(8, after: self.characterNameLabel)
        self.verticalStack.addArrangedSubview(self.characterStateLabel)
        self.addConstraintsToVerticalStack()
    }
    
    private func addConstraintsToVerticalStack() -> Void {
        self.verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.verticalStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    
    // MARK: Настройка индикатора загрузки аватара
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
