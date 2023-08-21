//
//  EpisodeTableViewCell.swift
//  RickAndMorty
//
//  Created by Kirill on 20.08.2023.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    // MARK: Свойства класса
    static let reuseId = "EpisodeTableViewCell"
    
    // MARK: Свойства объектов класса
    var episodeNameLabel       : UILabel!
    var episodeDescriptionLabel: UILabel!
    var episodeRealiseDateLabel: UILabel!
    var horizontalStack        : UIStackView!
    var verticalStack          : UIStackView!
    
    // MARK: Инициализаторы
    init() {
        super.init(style: .default, reuseIdentifier: EpisodeTableViewCell.reuseId)
        self.setUpEpisodeTableViewCell()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpEpisodeTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Подгтовка к повторному использованию
    override func prepareForReuse() {
        self.episodeNameLabel.text = nil
        self.episodeDescriptionLabel.text = nil
        self.episodeRealiseDateLabel.text = nil
    }
    
    // MARK: Настройка ячейки
    private func setUpEpisodeTableViewCell() -> Void {
        self.setUpEpisodeNameLabel()
        self.setUpEpisodeDescriptionLabel()
        self.setUpEpisodeRealiseDateLabel()
        self.setUpHorizontalStack()
        self.setUpVerticalStack()
        self.setUpBackgroundColor()
        self.isUserInteractionEnabled = false
    }
    
    private func setUpBackgroundColor() -> Void {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    
    
}




// MARK: - Интерфейс и конфигурирование ячейки
extension EpisodeTableViewCell {
    
    func configure(episodeName: String, episodeDescription: String, episodeRealiseDate: String) -> Void {
        self.setUpEpisodeName(name: episodeName)
        self.setUpEpisodeDescription(description: episodeDescription)
        self.setUpEpisodeRealiseDate(realiseDate: episodeRealiseDate)
    }
    
    // MARK: Методы для заполнения меток
    private func setUpEpisodeName(name: String) -> Void {
        self.episodeNameLabel.text = name
    }
    
    private func setUpEpisodeDescription(description: String) -> Void {
        self.episodeDescriptionLabel.text = description
    }
    
    private func setUpEpisodeRealiseDate(realiseDate: String) -> Void {
        self.episodeRealiseDateLabel.text = realiseDate
    }
    
}




// MARK: - Компоновка UI ячейки
extension EpisodeTableViewCell {
    
    // MARK: Настройка метки с названием эпизода
    private func setUpEpisodeNameLabel() -> Void {
        self.episodeNameLabel = UILabel()
        self.episodeNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        self.episodeNameLabel.textColor = .white
        self.episodeNameLabel.textAlignment = .natural
        self.episodeNameLabel.numberOfLines = 0
    }
    
    // MARK: Настройка метки с описанием эпизода
    private func setUpEpisodeDescriptionLabel() -> Void {
        self.episodeDescriptionLabel = UILabel()
        self.episodeDescriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        self.episodeDescriptionLabel.textColor = AppColors.greenText.getColor()
        self.episodeDescriptionLabel.textAlignment = .natural
    }
    
    // MARK: Настройка метки с датой выхода эпизода
    private func setUpEpisodeRealiseDateLabel() -> Void {
        self.episodeRealiseDateLabel = UILabel()
        self.episodeRealiseDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        self.episodeRealiseDateLabel.textColor = AppColors.grayText.getColor()
        self.episodeRealiseDateLabel.textAlignment = .natural
    }
    
    // MARK: Настройка горизонтального стека
    private func setUpHorizontalStack() -> Void {
        self.horizontalStack = UIStackView(arrangedSubviews: [self.episodeDescriptionLabel, self.episodeRealiseDateLabel])
        self.horizontalStack.axis = .horizontal
        self.horizontalStack.alignment = .leading
        self.horizontalStack.distribution = .equalSpacing
    }
    
    // MARK: Настройка вертикального стека
    private func setUpVerticalStack() -> Void {
        self.verticalStack = UIStackView(arrangedSubviews: [self.episodeNameLabel, self.horizontalStack])
        self.addSubview(self.verticalStack)
        self.verticalStack.axis = .vertical
        self.verticalStack.layoutMargins = .init(top: 16, left: 15.25, bottom: 16, right: 15.25)
        self.verticalStack.isLayoutMarginsRelativeArrangement = true
        self.verticalStack.spacing = 16
        self.verticalStack.alignment = .fill
        self.verticalStack.layer.cornerRadius = 16
        self.verticalStack.backgroundColor = AppColors.cellsColor.getColor()
        self.addConstraintsToVerticalStack()
    }
    
    private func addConstraintsToVerticalStack() -> Void {
        self.verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.verticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            self.verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
