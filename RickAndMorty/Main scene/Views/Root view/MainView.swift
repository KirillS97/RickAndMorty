//
//  MainView.swift
//  RickAndMorty
//
//  Created by Kirill on 18.08.2023.
//

import UIKit

class MainView: UIView {
    
    private var mainCollectionView: MainCollectionView!
    private var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpMainView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpMainView() -> Void {
        self.setUpMainCollectionView()
        self.setUpActivityIndicator()
        self.backgroundColor = AppColors.mainColor.getColor()
        self.hideContent()
    }
    
}



// MARK: - Интерфейс
extension MainView {
    
    // MARK: Установка источника данных для таблицы
    func addCollectionDataSource(dataSource: UICollectionViewDataSource) {
        self.mainCollectionView.dataSource = dataSource
    }
    
    // MARK: Установка делегата для таблицы
    func addCollectionDelegate(delegate: UICollectionViewDelegate) {
        self.mainCollectionView.delegate = delegate
    }
    
    // MARK: Обновление таблицы
    func updateCollection() -> Void {
        self.mainCollectionView.reloadData()
    }
    
    // MARK: Сокрытие контента
    func hideContent() -> Void {
        self.mainCollectionView.isHidden = true
    }
    
    // MARK: Отображение контента
    func showContent() -> Void {
        self.mainCollectionView.isHidden = false
    }
    
    // MARK: Остановка индикатора загрузки
    func stopActivityIndicator() -> Void {
        self.activityIndicator.stopAnimating()
    }
    
}



// MARK: - Компоновка UI
extension MainView {
    
    // MARK: Настройка таблицы
    private func setUpMainCollectionView() -> Void {
        self.mainCollectionView = MainCollectionView(frame: CGRect.zero)
        self.addSubview(self.mainCollectionView)
        self.addConstraintsToMainCollectionView()
    }
    
    private func addConstraintsToMainCollectionView() -> Void {
        self.mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mainCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.mainCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.mainCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.mainCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: Настройка индикатора загрузки
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

