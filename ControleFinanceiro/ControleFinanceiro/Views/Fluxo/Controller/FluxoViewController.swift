//
//  FluxoViewController.swift
//  ControleFinanceiro
//
//  Created by humberto Lima on 08/05/22.
//

import UIKit

class FluxoViewController: UIViewController {

    var listTransacoes = [FluxoModel]()
    var selectedModel = FluxoModel()
    var deleteModel = FluxoModel()
    var saldoMes = Float()
    
    @IBOutlet weak var labelSaldoGasto: UILabel!
    @IBOutlet weak var tabelaEntradas: UITableView!
    @IBOutlet weak var buttonNovaEntrada: BotaoCustomizado!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView()  {
        self.tabelaEntradas.delegate = self
        self.tabelaEntradas.dataSource = self
        self.tabelaEntradas.register(UINib(nibName: "FluxoTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func confirmDelete() {
        let alert = UIAlertController(title: "Atenção", message: "Deseja DELETAR essa transação?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            dataManager.deletaTransacao(modelSalvar: self.deleteModel)
            self.listTransacoes = dataManager.ListaTransacoes()
            self.labelSaldoGasto.text = self.CalculeSaldo()
            self.tabelaEntradas.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.listTransacoes = dataManager.ListaTransacoes()
        self.labelSaldoGasto.text = self.CalculeSaldo()
        self.tabelaEntradas.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goNext") {
            let vc = segue.destination as! DetalheFluxoViewController
            vc.modelDetalhe = self.selectedModel
        }
    }
    
    func CalculeSaldo() -> String {
        saldoMes = dataManager.getConfiguracao().valorDefinido ?? 0
        
        var valorGasto = Float()
        for temp in self.listTransacoes {
            valorGasto += temp.valor ?? 0
        }
        return "R$ \(saldoMes - valorGasto)"
    }
    
    // Alterar cor do label com saldo
    func defineCor() {
        
    }
}

extension FluxoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listTransacoes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tabelaEntradas.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FluxoTableViewCell
        cell.setupView(modelTemp: self.listTransacoes[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedModel = self.listTransacoes[indexPath.section]
        self.performSegue(withIdentifier: "goNext", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             self.deleteModel = self.listTransacoes[indexPath.section]
             self.confirmDelete()
         }
     }
}
