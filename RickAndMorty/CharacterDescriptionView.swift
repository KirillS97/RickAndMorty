//
//  CharacterDescriptionView.swift
//  RickAndMorty
//
//  Created by Kirill on 19.08.2023.
//

import UIKit

class CharacterDescriptionView: UIView {
    
    
    
    // MARK: Свойства объектов класса
    private var table: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpCharacterDescriptionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Настройка этого вью
    private func setUpCharacterDescriptionView() -> Void {
        self.setUpTable()
        self.setUpActivityIndicator()
        self.setUpBackgroundColor()
        self.hideContent()
    }
    
    // MARK: Настройка цвета фонва вью
    private func setUpBackgroundColor() -> Void {
        self.backgroundColor = AppColors.mainColor.getColor()
    }
    
    
}



// MARK: Интерфейс и конфигурирование ячейки
extension CharacterDescriptionView {
    
    // MARK: Установка источника данных для таблицы
    func addTableDaraSource(dataSource: UITableViewDataSource) {
        self.table.dataSource = dataSource
    }
    
    // MARK: Установка делегата для таблицы
    func addTableDelegate(delegate: UITableViewDelegate) {
        self.table.delegate = delegate
    }
    
    // MARK: Обновление таблицы
    func updateTable() -> Void {
        self.table.reloadData()
    }
    
    // MARK: Извлечение ячейки из очереди ожидания
    func dequeueReusableCellForTable(reuseId: String, indexPath: IndexPath) -> UITableViewCell {
        return self.table.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
    }
    
    // MARK: Сокрытие контента
    func hideContent() -> Void {
        self.table.isHidden = true
    }
    
    // MARK: Отображение контента
    func showContent() -> Void {
        self.table.isHidden = false
    }
    
    // MARK: Остановка индикатора загрузки
    func stopActivityIndicator() -> Void {
        self.activityIndicator.stopAnimating()
    }
    
}



// MARK: - Компоновка UI ячейки
extension CharacterDescriptionView {
    
    // MARK: Настройка  таблицы
    private func setUpTable() -> Void {
        self.table = UITableView()
        self.addSubview(self.table)
        self.table.estimatedRowHeight = 100
        self.table.showsVerticalScrollIndicator = false
        self.table.backgroundColor = AppColors.mainColor.getColor()
        self.table.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.reuseId)
        self.addConstraintsToTable()
    }
    
    private func addConstraintsToTable() -> Void {
        self.table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.table.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.table.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            self.table.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.table.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])
    }
    
    private func setUpActivityIndicator() -> Void {
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.addSubview(self.activityIndicator)
        self.activityIndicator.color = .white
        self.activityIndicator.hidesWhenStopped = true
        self.addConstraintsToActivityIndicator()
        self.activityIndicator.startAnimating()
    }
    
    private func addConstraintsToActivityIndicator() -> Void {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
}
