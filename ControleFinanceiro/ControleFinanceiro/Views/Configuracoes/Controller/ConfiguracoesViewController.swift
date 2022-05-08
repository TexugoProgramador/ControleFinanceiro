//
//  ConfiguracoesViewController.swift
//  Controle
//
//  Created by humberto Lima on 08/05/22.
//

import UIKit

class ConfiguracoesViewController: UIViewController {

    @IBOutlet weak var fieldValor: UITextField!
    @IBOutlet weak var sliderValuer: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fieldValor.text = "\(dataManager.getConfiguracao().valorDefinido ?? 0)".showMoneyFormat()
        self.sliderValuer.value = dataManager.getConfiguracao().valorDefinido ?? 0
    }
    
    func createModel() -> ConfiguracaoModel {
        var temp = ConfiguracaoModel()
        let stringtemp = (self.fieldValor.text ?? "0").replacingOccurrences(of: "R$ ", with: "")
        temp.valorDefinido = Float(stringtemp)
        return temp
    }
    
    @IBAction func saveUpdate(_ sender: UIButton) {
        let alert = UIAlertController(title: "Atenção", message: "Deseja alterar as configurações?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            dataManager.salvaConfiguracao(modelSalvar: self.createModel(), nomeEntity: "Configuracoes")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func alterouValor(_ sender: UISlider) {
        self.fieldValor.text = "\(sender.value)"
    }
    
    @IBAction func removeKeyboard(_ sender: UITapGestureRecognizer) {
        self.fieldValor.resignFirstResponder()
    }
}
