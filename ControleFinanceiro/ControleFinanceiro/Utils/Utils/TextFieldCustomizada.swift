//
//  TextFieldCustomizada.swift
//  TesteExtensions
//
//  Created by humberto Lima on 27/06/20.
//  Copyright © 2020 humberto Lima. All rights reserved.
//

import UIKit

@IBDesignable class TextFieldSublinhada: UITextField {
    
    @IBInspectable var cor: UIColor?{
        didSet { setUpView() }
    }
    
    @IBInspectable var espessura: Int = 1{
        didSet { setUpView() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        let labelTemp = UILabel(frame: CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: CGFloat(espessura)))
        labelTemp.backgroundColor = cor ?? UIColor.black
        self.addSubview(labelTemp)
        self.borderStyle = .none
    }
}
