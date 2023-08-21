//
//  OriginTableViewCell.swift
//  RickAndMorty
//
//  Created by Kirill on 19.08.2023.
//

import UIKit

class OriginTableViewCell: UITableViewCell {
    
    // MARK: Свойства класса
    static let reuseId = "OriginTableViewCell"
    
    // MARK: Свойства объектов класса
    var nameLabel      : UILabel!
    var typeLabel      : UILabel!
    var verticalStack  : UIStackView!
    var planetImageView: UIImageView!
    var horizontalStack: UIStackView!
    
    // MARK: Инициализаторы
    init() {
        super.init(style: .default, reuseIdentifier: OriginTableViewCell.reuseId)
        self.setUpOriginTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Настройка ячейки
    private func setUpOriginTableViewCell() {
        self.setUpNameLabel()
        self.setUpTypeLabel()
        self.setUpVerticalStack()
        self.setUpPlanetImageView()
        self.setUpHorizontalStack()
        self.setUpBackgroundColor()
        self.isUserInteractionEnabled = false
    }
    
    private func setUpBackgroundColor() {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
 
}



// MARK: - Интерфейс и компоновка ячейки
extension OriginTableViewCell {
    
    func configure(originName: String) -> Void {
        self.setUpOriginName(name: originName)
    }
    
    private func setUpOriginName(name: String) -> Void {
        self.nameLabel.text = name
    }
    
}



// MARK: - Компоновка UI ячейки
extension OriginTableViewCell {
    
    // MARK: Настройка метки с названием
    private func setUpNameLabel() -> Void {
        self.nameLabel = UILabel()
        self.nameLabel.textColor = .white
        self.nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        self.nameLabel.textAlignment = .natural
        self.nameLabel.numberOfLines = 0
    }
    
    // MARK: Настройка метки с типом
    private func setUpTypeLabel() -> Void {
        self.typeLabel = UILabel()
        self.typeLabel.textColor = AppColors.greenText.getColor()
        self.typeLabel.font = .systemFont(ofSize: 13, weight: .regular)
        self.typeLabel.textAlignment = .natural
        self.typeLabel.text = "Planet"
    }
    
    // MARK: Настройка вертикального стека
    private func setUpVerticalStack() -> Void {
        self.verticalStack = UIStackView(arrangedSubviews: [self.nameLabel, self.typeLabel])
        self.verticalStack.axis = .vertical
        self.verticalStack.spacing = 8
        self.verticalStack.alignment = .leading
    }
    
    // MARK: Настройка Изображения
    private func setUpPlanetImageView() -> Void {
        self.planetImageView = UIImageView()
        let image = UIImage(named: "planet")
        self.planetImageView.image = image
        self.planetImageView.contentMode = .center
        self.planetImageView.layer.cornerRadius = 10
        self.planetImageView.backgroundColor = UIColor(red: (25/255), green: (28/255), blue: (42/255), alpha: 1)
        self.addConstraintsToPlanetImageView()
    }
    
    private func addConstraintsToPlanetImageView() -> Void {
        self.planetImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.planetImageView.widthAnchor.constraint(equalToConstant: 64),
            self.planetImageView.heightAnchor.constraint(equalTo: self.planetImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    // MARK: Настройка горизонтального стека
    private func setUpHorizontalStack() -> Void {
        self.horizontalStack = UIStackView(arrangedSubviews: [self.planetImageView, self.verticalStack])
        self.addSubview(self.horizontalStack)
        self.horizontalStack.axis = .horizontal
        self.horizontalStack.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        self.horizontalStack.isLayoutMarginsRelativeArrangement = true
        self.horizontalStack.spacing = 16
        self.horizontalStack.alignment = .center
        self.horizontalStack.layer.cornerRadius = 16
        self.horizontalStack.backgroundColor = UIColor(red: (38/255), green: (42/255), blue: (56/255), alpha: 1)
        self.addConstraintsToHorizontalStack()
    }
    
    private func addConstraintsToHorizontalStack() -> Void {
        self.horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.horizontalStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.horizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.horizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}
