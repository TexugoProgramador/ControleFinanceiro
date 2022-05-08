//
//  NovaEntradaViewController.swift
//  Controle
//
//  Created by humberto Lima on 08/05/22.
//

import UIKit

class NovaEntradaViewController: UIViewController {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var fieldTitulo: UITextField!
    @IBOutlet weak var fieldValor: UITextField!
    @IBOutlet weak var fieldDescricao: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
    }
    
    func setupView() {
        self.viewContent.clipsToBounds = true
        self.viewContent.layer.cornerRadius = 5
        
        self.fieldDescricao.clipsToBounds = true
        self.fieldDescricao.layer.cornerRadius = 5
        self.fieldDescricao.layer.borderWidth = 0.5
        self.fieldDescricao.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.25)
    }
    
    func validForm() -> Bool {
        guard (self.fieldTitulo.text ?? "") != "" else {
            self.showAnimedAlert(mesage: "Digite o titulo", textColor: .white, backgroundColor: vermelhoAlerta, duration: duracaoAlertSimples, alertFromTop: true)
            return false
        }
        
        guard (self.fieldValor.text ?? "") != "" else {
            self.showAnimedAlert(mesage: "Digite o valor", textColor: .white, backgroundColor: vermelhoAlerta, duration: duracaoAlertSimples, alertFromTop: true)
            return false
        }
        
        return true
    }
    
    func createModel() -> FluxoModel {
        var fluxoInserir = FluxoModel()
        fluxoInserir.titulo = self.fieldTitulo.text ?? ""
        fluxoInserir.valor = Float((self.fieldValor.text ?? "0").replacingOccurrences(of: ",", with: "."))
        fluxoInserir.descricao = self.fieldDescricao.text ?? ""
        fluxoInserir.data = curretDate()
        return fluxoInserir
    }
    
    // TODO: implementar no futuro
    func curretDate() -> Date {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy"
//        let dateReturn = formatter.date(from: "\(Date())")
//        return dateReturn ?? Date()
        return Date()
    }
    
    @IBAction func tapClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveNew(_ sender: UIButton) {
        if validForm() {
            dataManager.salvaDados(modelSalvar: createModel(), nomeEntity: "Fluxo")
            self.dismiss(animated: true)
        }
    }
}
