//
//  ExtensionImage.swift
//  TesteExtensions
//
//  Created by humberto Lima on 27/06/20.
//  Copyright © 2020 humberto Lima. All rights reserved.
//
import UIKit

extension UIImage {
    // gera uma string
    func gera64Imagem(imageRecebido: UIImage) -> String {
        let imageData = imageRecebido.pngData()! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
}
