//
//  ExtensionViewController.swift
//  TesteExtensions
//
//  Created by humberto Lima on 27/06/20.
//  Copyright © 2020 humberto Lima. All rights reserved.
//

import UIKit

extension UIViewController {
    // função que gera um alerta padrão do sistema
    func alertaSimples(title: String, mensagem:String){
        let alert = UIAlertController(title: title, message: mensagem, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAnimedAlert(mesage: String, textColor: UIColor, backgroundColor: UIColor, duration: TimeInterval, alertFromTop: Bool) {
            let labelMessage = UILabel(frame: CGRect(x: 8, y: 8, width: Int(self.view.frame.width - 16), height: 20))
            labelMessage.font = UIFont.systemFont(ofSize: 12, weight: .light)
            labelMessage.textAlignment = .center
            labelMessage.numberOfLines = 0
            labelMessage.text = mesage
            labelMessage.textColor = textColor
            labelMessage.backgroundColor = .clear
            labelMessage.frame.size.height = max(autoHeightForLabel(labelMessage), 20)
            
            
            let alertView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: (labelMessage.frame.height + 20)))
            alertView.backgroundColor = backgroundColor
            alertView.alpha = 1
            alertView.layer.cornerRadius = 10
            alertView.clipsToBounds = true
            
            labelMessage.center = alertView.center
            alertView.addSubview(labelMessage)
            alertView.center.x = self.view.center.x
            self.view.addSubview(alertView)
            
            if alertFromTop {
                let aboveTop = 0 - alertView.frame.height
                let heightBellowTop = self.view.safeAreaInsets.top + alertView.frame.height / 2
                
                alertView.layer.position.y = aboveTop
                UIView.animate(withDuration: 0.5, animations: {
                    alertView.layer.position.y = heightBellowTop
                }, completion: { _ in
                    UIView.animate(withDuration: 0.5, delay: duration, animations: { alertView.layer.position.y = aboveTop
                    }, completion: { _ in alertView.removeFromSuperview() })
                })
            }
            else {
                let belowBottom = self.view.frame.height + alertView.frame.height / 2
                let heightAboveBottom = self.view.frame.height - (self.view.safeAreaInsets.bottom + alertView.frame.height)
                
                alertView.layer.position.y = belowBottom
                UIView.animate(withDuration: 0.5, animations: {
                    alertView.layer.position.y = heightAboveBottom
                }, completion: { _ in
                        UIView.animate(withDuration: 0.5, delay: duration, animations: { alertView.layer.position.y = belowBottom
                        }, completion: { _ in alertView.removeFromSuperview() })
                })
            }
        }
        
        private func autoHeightForLabel(_ label: UILabel) -> CGFloat {
            let lb = UILabel(frame: label.frame)
            lb.text = label.text
            lb.font = label.font
            lb.textAlignment = label.textAlignment
            lb.numberOfLines = label.numberOfLines
            lb.sizeToFit()
            
            return lb.frame.height
        }
}
