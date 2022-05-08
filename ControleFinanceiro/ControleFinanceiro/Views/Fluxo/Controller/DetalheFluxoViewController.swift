//
//  DetalheFluxoViewController.swift
//  Controle
//
//  Created by humberto Lima on 08/05/22.
//

import UIKit

class DetalheFluxoViewController: UIViewController {

    var modelDetalhe = FluxoModel()
    
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelData: UILabel!
    @IBOutlet weak var labelVAlor: UILabel!
    @IBOutlet weak var fieldescricao: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @IBAction func BackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        self.fieldescricao.clipsToBounds = true
        self.fieldescricao.layer.cornerRadius = 5
        self.fieldescricao.layer.borderWidth = 0.5
        self.fieldescricao.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.25)
        
        self.labelTitulo.text = modelDetalhe.titulo ?? ""
        self.labelVAlor.text = "\(modelDetalhe.valor ?? 0)".showMoneyFormat()
        self.labelData.text = "\(modelDetalhe.data ?? Date())"
        self.fieldescricao.text = modelDetalhe.descricao ?? ""
    }
    
}
