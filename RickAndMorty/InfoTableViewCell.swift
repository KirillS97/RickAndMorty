//
//  InfoTableViewCell.swift
//  RickAndMorty
//
//  Created by Kirill on 19.08.2023.
//

import UIKit



class InfoTableViewCell: UITableViewCell {
    
    // MARK: Свойства класса
    static let reuseId = "InfoTableViewCell"
    
    // MARK: Свойства объектов класса
    var speciesLabel          : UILabel!
    var speciesValueLabel     : UILabel!
    var speciesHorizontalStack: UIStackView!
    
    var typeLabel             : UILabel!
    var typeValueLabel        : UILabel!
    var typeHorizontalStack   : UIStackView!
    
    var genderLabel           : UILabel!
    var genderValueLabel      : UILabel!
    var genderHorizontalStack : UIStackView!
    
    var verticalStack         : UIStackView!
    
    let titleColor = UIColor.init(red: (196/255), green: (201/255), blue: (206/255), alpha: 1)
    
    // MARK: Инициализаторы
    init() {
        super.init(style: .default, reuseIdentifier: InfoTableViewCell.reuseId)
        self.setUpInfoTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Настройка ячейки
    private func setUpInfoTableViewCell() -> Void {
        self.setUpSpeciesLabel()
        self.setUpSpeciesValueLabel()
        self.setUpTypeLabel()
        self.setUpTypeValueLabel()
        self.setUpGenderLabel()
        self.setUpGenderValueLabel()
        self.setUpSpeciesHorizontalStack()
        self.setUpTypeHorizontalStack()
        self.setUpGenderHorizontalStack()
        self.setUpVerticalStack()
        self.isUserInteractionEnabled = false
        self.setUpBackgroundColor()
    }
    
    private  func setUpBackgroundColor() -> Void {
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
}



// MARK: - Интерфейс и конфигурирование ячейки
extension InfoTableViewCell {
    
    // MARK: Интерфейс
    func configure(characterSpecies: String, characterType: String, characterGender: String) -> Void {
        self.setUpSpecies(species: characterSpecies)
        self.setUpType(type: characterType)
        self.setUpGender(gender: characterGender)
    }
    
    // MARK: Конфигурирование
    private func setUpSpecies(species: String) -> Void {
        self.speciesValueLabel.text = species
    }
    
    private func setUpType(type: String) -> Void {
        if !type.isEmpty {
            self.typeValueLabel.text = type
        } else {
            self.typeValueLabel.text = "None"
        }
    }
    
    private func setUpGender(gender: String) -> Void {
        if !gender.isEmpty {
            self.genderValueLabel.text = gender
        } else {
            self.genderValueLabel.text = "Unknowned"
        }
    }
}



// MARK: - Компоновка UI ячейки
extension InfoTableViewCell {
    
    // MARK: Настройка меток Species
    private func setUpSpeciesLabel() -> Void {
        self.speciesLabel = self.getTitleLabel(title: "Species:")
    }
    
    private func setUpSpeciesValueLabel() -> Void {
        self.speciesValueLabel = self.getValueLabel()
    }
    
    private func setUpSpeciesHorizontalStack() -> Void {
        self.speciesHorizontalStack = self.getHorizontalStack(arrangedSubvies: [self.speciesLabel, self.speciesValueLabel])
    }
    
    // MARK: Настройка меток Type
    private func setUpTypeLabel() -> Void {
        self.typeLabel = self.getTitleLabel(title: "Type:")
    }
    
    private func setUpTypeValueLabel() -> Void {
        self.typeValueLabel = self.getValueLabel()
    }
    
    private func setUpTypeHorizontalStack() -> Void {
        self.typeHorizontalStack = self.getHorizontalStack(arrangedSubvies: [self.typeLabel, self.typeValueLabel])
    }
    
    // MARK: Настройка меток Gender
    private func setUpGenderLabel() -> Void {
        self.genderLabel = self.getTitleLabel(title: "Gender:")
    }
    
    private func setUpGenderValueLabel() -> Void {
        self.genderValueLabel = self.getValueLabel()
    }
    
    private func setUpGenderHorizontalStack() -> Void {
        self.genderHorizontalStack = self.getHorizontalStack(arrangedSubvies: [self.genderLabel, self.genderValueLabel])
    }
    
    // MARK: Настройка вертикального стека
    private func setUpVerticalStack() -> Void {
        self.verticalStack = UIStackView()
        self.addSubview(self.verticalStack)
        self.verticalStack.axis = .vertical
        self.verticalStack.layoutMargins = .init(top: 16, left: 0, bottom: 16, right: 0)
        self.verticalStack.isLayoutMarginsRelativeArrangement = true
        self.verticalStack.spacing = 16
        self.verticalStack.alignment = .fill
        self.verticalStack.layer.cornerRadius = 16
        self.verticalStack.backgroundColor = AppColors.cellsColor.getColor()
        self.verticalStack.addArrangedSubview(self.speciesHorizontalStack)
        self.verticalStack.addArrangedSubview(self.typeHorizontalStack)
        self.verticalStack.addArrangedSubview(self.genderHorizontalStack)
        self.addConstraintsToVerticalStack()
    }
    
    private func addConstraintsToVerticalStack() -> Void {
        self.verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.verticalStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    // MARK: Метод для настройки заголовочных меток
    private func getTitleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = self.titleColor
        label.text = title
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }
    
    // MARK: Метод для настройки меток со значениями
    private func getValueLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.numberOfLines = 0
        return label
    }
    
    // MARK: Метод для горизонтальных стеков
    private func getHorizontalStack(arrangedSubvies: [UIView]) -> UIStackView {
        let horizontalStack = UIStackView(arrangedSubviews: arrangedSubvies)
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .equalSpacing
        horizontalStack.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        horizontalStack.isLayoutMarginsRelativeArrangement = true
        return horizontalStack
    }
}
