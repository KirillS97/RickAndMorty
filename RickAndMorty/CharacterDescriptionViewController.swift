//
//  CharacterDescriptionViewController.swift
//  RickAndMorty
//
//  Created by Kirill on 19.08.2023.
//

import UIKit



// MARK: - CharacterDescriptionViewController

class CharacterDescriptionViewController: UIViewController {
    
    
    
    // MARK: - Свойства объектов класса
    let netwokManager = NetworkManager.shared
    
    var character: Character!
    var avatar: UIImage?
    var episodes: [Episode] = [] {
        didSet {
            var sortedEpisodesArray: [Episode]
            sortedEpisodesArray = self.episodes.sorted(by: {
                $0.releaseDateInTimeInterval < $1.releaseDateInTimeInterval
            })
            self.episodes = sortedEpisodesArray
            self.characterDescriptionView.updateTable()
        }
    }
    var characterDescriptionView: CharacterDescriptionView!
    var tableSectionTitles = ["", "Info", "Origin", "Episodes"]
    
    
    
    // MARK: - Инициализаторы
    init(character: Character) {
        super.init(nibName: nil, bundle: nil)
        self.character = character
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - loadView
    override func loadView() {
        super.loadView()
        self.configureCharacterDescriptionView()
    }
    
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
       
        self.configureCharacterDescriptionView()
        
        self.fetchEpisodes()
    }
    
    
    
    // MARK: - Конфигурирование characterDescriptionView
    private func configureCharacterDescriptionView() -> Void {
        self.characterDescriptionView = CharacterDescriptionView(frame: CGRect.zero)
        self.view = self.characterDescriptionView
        self.characterDescriptionView.addTableDaraSource(dataSource: self)
        self.characterDescriptionView.addTableDelegate(delegate: self)
    }
    
    
    
    // MARK: - Отправка запроса для получения массива всех эпизодов с персонажем
    private func fetchEpisodes() -> Void {
        var urlArray: [URL?] = []
        for episodeUrl in self.character.episode {
            urlArray.append(URL(string: episodeUrl))
        }
        self.netwokManager.fetchEpisodesArray(urlArray: urlArray) { result in
            switch result {
            case .success(let episodes):
                self.episodes = episodes
                self.characterDescriptionView.stopActivityIndicator()
                self.characterDescriptionView.showContent()
            case .failure(_):
                self.characterDescriptionView.hideContent()
            }
        }
    }
    
    
}




// MARK: - UITableViewDataSource
extension CharacterDescriptionViewController: UITableViewDataSource {
    
    //  MARK: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        self.tableSectionTitles.count
    }
    
    // MARK: viewForHeaderInSection
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.tableSectionTitles.indices.contains(section) {
            let header = CustomHeaderForTableView(frame: CGRect.zero)
            header.setUpTitle(title: self.tableSectionTitles[section])
            return header
        } else {
            return nil
        }
    }
    
    // MARK: heightForHeaderInSection
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return 33
    }
    
    // MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        case 3: return self.episodes.count
        default: return 0
        }

    }
    
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = CharacterDescriptionTableViewCell()
            cell.configure(characterName: self.character.name,
                           characterStatus: self.character.status,
                           imageUrl: URL(string: self.character.image))
            return cell
        case 1:
            let cell = InfoTableViewCell()
            cell.configure(characterSpecies: self.character.species,
                           characterType: self.character.type,
                           characterGender: self.character.gender)
            return cell
        case 2:
            let cell = OriginTableViewCell()
            if !self.character.origin.name.isEmpty {
                cell.configure(originName: self.character.origin.name)
            } else {
                cell.configure(originName: "Unknown")
            }
            return cell
        case 3:
            if self.episodes.indices.contains(indexPath.row) {
                let episode = self.episodes[indexPath.row]
                if let cell = self.characterDescriptionView.dequeueReusableCellForTable(reuseId: EpisodeTableViewCell.reuseId,
                                                                                        indexPath: indexPath) as? EpisodeTableViewCell {
                    cell.configure(episodeName: episode.name,
                                   episodeDescription: episode.episodeDescription,
                                   episodeRealiseDate: episode.air_date)
                    return cell
                }
                return UITableViewCell()
            }
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }

}



// MARK: - UITableViewDelegate
extension CharacterDescriptionViewController: UITableViewDelegate {
    
}
