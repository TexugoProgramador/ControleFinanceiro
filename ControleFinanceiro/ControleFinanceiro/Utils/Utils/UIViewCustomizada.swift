//
//  UIViewCustomizada.swift
//  TesteExtensions
//
//  Created by humberto Lima on 27/06/20.
//  Copyright © 2020 humberto Lima. All rights reserved.
//

import UIKit


extension UIView {
    //cria uma sombra no componente
    func sombra(corSombra: CGColor) {
        self.layer.cornerRadius = 15
        self.layer.shadowColor = corSombra
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
    }
}
