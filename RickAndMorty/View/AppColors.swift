//
//  AppColors.swift
//  RickAndMorty
//
//  Created by Kirill on 20.08.2023.
//

import UIKit



// MARK: - Нестандартные цвета, используемые в приложении
enum AppColors {
    case mainColor
    case cellsColor
    case greenText
    case grayText
    
    func getColor() -> UIColor {
        switch self {
        case .mainColor:
            return UIColor(red: (4/255),   green: (12/255),  blue: (30/255),  alpha: 1)
        case .cellsColor:
            return UIColor(red: (38/255),  green: (42/255),  blue: (56/255),  alpha: 1)
        case .greenText:
            return UIColor(red: (71/255),  green: (198/255), blue: (11/255),  alpha: 1)
        case  .grayText:
            return UIColor(red: (147/255), green: (152/255), blue: (156/255), alpha: 1)
        }
    }
}
