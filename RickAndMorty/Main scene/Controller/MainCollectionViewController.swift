//
//  MainCollectionViewController.swift
//  RickAndMorty
//
//  Created by Kirill on 18.08.2023.
//

import UIKit



class MainCollectionViewController: UIViewController {
    
    
    
    // MARK: Методы объектов класса
    var characters: [Character] = [] {
        didSet {
            self.mainView.updateCollection()
            self.mainView.stopActivityIndicator()
            self.mainView.showContent()
        }
    }
    let networkManager = NetworkManager.shared
    let urlCreator = URLCreator.shared
    
    var pageForLoad = 1
    var pagesNumber = 1
    
    var mainView: MainView!
    
    // MARK: loadView
    override func loadView() {
        super.loadView()
        self.setUpMainView()
    }
    
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .white
        
        self.fetchCharactersForPage()
    }
    
    
    
    // MARK: Метод отправки запроса на сервер для получения массива персонажей
    private func fetchCharactersForPage() -> Void {
        let url = self.urlCreator.getCharactersForPageURL(pageNumber: self.pageForLoad)
        self.networkManager.fetchCharacters(url: url) { result in
            switch result {
            case .success(let data):
                if self.pagesNumber != data.info.pages {
                    self.pagesNumber = data.info.pages
                }
                self.characters.append(contentsOf: data.results)
                self.pageForLoad += 1
            case .failure(_):
                print("Error")
            }
        }
    }
    
    
    // MARK: Настройка mainView
    private func setUpMainView() -> Void {
        self.mainView = MainView(frame: CGRect.zero)
        self.view = mainView
        self.mainView.addCollectionDataSource(dataSource: self)
        self.mainView.addCollectionDelegate(delegate: self)
    }
    
    
    
    // MARK: Переход к следующей сцене
    private func goToCharacterDescriptionVC(character: Character) -> Void {
        let characterDescriptionVC = CharacterDescriptionViewController(character: character)
        self.navigationController?.pushViewController(characterDescriptionVC, animated: true)
    }
    
    
}




// MARK: - UICollectionViewDataSource
extension MainCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterViewCell.reuseId, for: indexPath) as? CharacterViewCell {
            if self.characters.indices.contains(indexPath.item) {
                let imageUrl = URL(string: self.characters[indexPath.item].image)
                let characterName = self.characters[indexPath.item].name
                cell.configure(characterName: characterName, imageUrl: imageUrl)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard self.characters.indices.contains(indexPath.item) else { return }
        if indexPath.item == self.characters.index(before: self.characters.endIndex) {
            if self.pageForLoad <= self.pagesNumber {
                self.fetchCharactersForPage()
            }
        }
    }
    
    
}



// MARK: - UICollectionViewDelegate
extension MainCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.characters.indices.contains(indexPath.item) {
            self.goToCharacterDescriptionVC(character: self.characters[indexPath.item])
        }
    }
}
