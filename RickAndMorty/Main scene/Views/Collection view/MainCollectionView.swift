//
//  MainCollectionView.swift
//  RickAndMorty
//
//  Created by Kirill on 18.08.2023.
//

import UIKit

class MainCollectionView: UICollectionView {
    
    
    
    // MARK: UICollectionViewFlowLayout
    private var customizedFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = flowLayout.minimumLineSpacing
        flowLayout.scrollDirection = .vertical
        flowLayout.estimatedItemSize = CGSize(width: 156, height: 240)
        flowLayout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        return flowLayout
    }()
    
    
    
    // MARK: Инициализаторы
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: self.customizedFlowLayout)
        self.setUpMainCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Настройка MainCollectionView
    private func setUpMainCollectionView() -> Void {
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = false
        self.register(CharacterViewCell.self, forCellWithReuseIdentifier: CharacterViewCell.reuseId)
        self.updateColor()
        self.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private func updateColor() -> Void {
        if self.visibleCells.isEmpty {
            self.backgroundColor = AppColors.mainColor.getColor()
        }
    }
    


}
