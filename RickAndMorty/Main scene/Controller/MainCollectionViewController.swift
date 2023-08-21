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
        
        self.fetchAllCharacters()
    }
    
    
    
    // MARK: Метод отправки запроса на сервер для получения массива персонажей
    private func fetchAllCharacters() -> Void {
        self.networkManager.fetchAllCharacters(url: urlCreator.getAllCharactersURL(),
                                               characters: self.characters,
                                               completionHandler: { result in
            switch result {
            case .success(let charactersArray):
                self.characters = charactersArray
            case .failure(_):
                self.mainView.hideContent()
            }
        })
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterViewCell.reuseId, for: indexPath)
        if let characterViewCell = cell as? CharacterViewCell {
            cell.prepareForReuse()
            if self.characters.indices.contains(indexPath.item) {
                characterViewCell.setUpName(name: self.characters[indexPath.item].name)
                let imageUrl = URL(string: self.characters[indexPath.item].image)
                self.networkManager.fetchImage(url: imageUrl) { image in
                    if let image {
                        characterViewCell.setUpAvatar(image: image)
                        characterViewCell.stopActivityIndicator()
                    }
                }
                return characterViewCell
            }
        }
        return cell
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
