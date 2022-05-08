//
//  FluxoTableViewCell.swift
//  Controle
//
//  Created by humberto Lima on 08/05/22.
//

import UIKit

class FluxoTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var labelDescricao: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView(modelTemp: FluxoModel)  {
        self.labelTitle.text = modelTemp.titulo ?? ""
        self.labelValue.text = "\(modelTemp.valor ?? 0.0)".showMoneyFormat()
        self.labelDescricao.text = modelTemp.descricao ?? ""
    }
}
