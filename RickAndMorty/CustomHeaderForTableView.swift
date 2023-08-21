//
//  CustomHeaderForTableView.swift
//  RickAndMorty
//
//  Created by Kirill on 19.08.2023.
//

import UIKit



class CustomHeaderForTableView: UIView {

    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpCustomHeaderForTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpCustomHeaderForTableView() -> Void {
        self.setUpLabel()
        self.backgroundColor = AppColors.mainColor.getColor()
    }
    
}



// MARK: - Интерфейс
extension CustomHeaderForTableView  {
    func setUpTitle(title: String) {
        self.label.text = title
    }
}



// MARK: - Компоновка UI
extension CustomHeaderForTableView {
    
    private func setUpLabel() -> Void {
        self.label = UILabel()
        self.addSubview(self.label)
        self.label.font = .systemFont(ofSize: 17, weight: .semibold)
        self.label.textColor = .white
        self.addConstraintsToLabel()
    }
    
    private func addConstraintsToLabel() -> Void {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
}
