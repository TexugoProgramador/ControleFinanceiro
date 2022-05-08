//
//  ExtensionImageView.swift
//  TesteExtensions
//
//  Created by humberto Lima on 27/06/20.
//  Copyright © 2020 humberto Lima. All rights reserved.
//

import UIKit

extension UIImageView {
    // carrega uma imagem vindo de uma url
    func carregaImagem(urlImagem: String) -> UIImage{
        let ImageTemp = UIImage(named: "import UIKit")
        if urlImagem != "" {
            var data = Data()
            do {
                try data = Data(contentsOf: URL(string: urlImagem)!)
                return UIImage(data: data)!
            }catch {
                return ImageTemp!
            }
        }else{
            return ImageTemp!
        }
    }
    
    // quando recebe uma String em base 64 de umaimagem essa função converte em uma UIImage
    func geraImagemDeString(stringRecebida: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: stringRecebida, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded) ?? UIImage()
        return decodedimage
    }
}
