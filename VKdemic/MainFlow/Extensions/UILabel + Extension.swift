//
//  UILabel + Extension.swift
//  VKdemic
//
//  Created by Djinsolobzik on 04.05.2023.
//

import UIKit

extension UILabel {
    convenience init(name: String, font: UIFont? = .systemFont(ofSize: 18)) {
        self.init()
        self.text = name
        self.font = font
    }
}
