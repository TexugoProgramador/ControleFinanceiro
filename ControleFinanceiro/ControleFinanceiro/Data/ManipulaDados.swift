//
//  ManipulaDados.swift
//  TesteExtensions
//
//  Created by humberto Lima on 27/06/20.
//  Copyright © 2020 humberto Lima. All rights reserved.
//

import UIKit
import CoreData


class ManipulaDados {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func salvaDados(modelSalvar: FluxoModel, nomeEntity: String){
        if nomeEntity != "" {
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: nomeEntity, in: managedContext)!
            let modelInserir = NSManagedObject(entity: entity,  insertInto: managedContext)
            
            modelInserir.setValue((modelSalvar.valor ?? 0.0), forKey: "valor")
            modelInserir.setValue((modelSalvar.titulo ?? ""), forKey: "titulo")
            modelInserir.setValue((modelSalvar.descricao ?? ""), forKey: "descricao")
            modelInserir.setValue((modelSalvar.data ?? ""), forKey: "data")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Não foi possível salvar erro. \(error), \(error.userInfo)")
            }
        }else{
            return
        }
    }
    
    func ListaTransacoes() -> [FluxoModel] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [FluxoModel()] }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Fluxo")
        do {
            let dadoTemp = try managedContext.fetch(fetchRequest)
            var listFluxos = [FluxoModel]()
            for temp in dadoTemp {
                let modelTemp = FluxoModel(valor: (temp.value(forKey: "valor") as? Float ?? 0.0), titulo: (temp.value(forKey: "titulo") as? String ?? ""), descricao: (temp.value(forKey: "descricao") as? String ?? ""), data: (temp.value(forKey: "data") as? Date ?? Date()))
                listFluxos.append(modelTemp)
            }
            
            var listModelTemp = [FluxoModel]()
            while listFluxos.count > 0  {
                listModelTemp.append(listFluxos.last ?? FluxoModel())
                listFluxos.removeLast()
            }
            return listModelTemp
            //return listTravels
        } catch let error as NSError {
            print("Dados não encontrados \(error), \(error.userInfo)")
            return [FluxoModel()]
        }
    }
    
    func deletaTransacao(modelSalvar: FluxoModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Fluxo")
        //let fetchPredicate = NSPredicate(format: "titulo == '\(modelSalvar.titulo!)' && data == \(modelSalvar.data!)")
        let fetchPredicate = NSPredicate(format: "titulo == %@", modelSalvar.titulo ?? "")
        fetchRequest.predicate = fetchPredicate
        
        do {
            let dadoTemp = try managedContext.fetch(fetchRequest)
            if dadoTemp.count > 0 {
                managedContext.delete(dadoTemp.first ?? NSManagedObject())
                try managedContext.save()
                
            }
        } catch let error as NSError {
            print("Dados não encontrados \(error), \(error.userInfo)")
        }
    }
    
    func salvaConfiguracao(modelSalvar: ConfiguracaoModel, nomeEntity: String){
        if nomeEntity != "" {
            self.limpaEntities(entity: nomeEntity)
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: nomeEntity, in: managedContext)!
            let modelInserir = NSManagedObject(entity: entity,  insertInto: managedContext)
            
            modelInserir.setValue((modelSalvar.valorDefinido ?? 0.0), forKey: "valorDefinido")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Não foi possível salvar erro. \(error), \(error.userInfo)")
            }
        }else{
            return
        }
    }
    
    func getConfiguracao() -> ConfiguracaoModel {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return ConfiguracaoModel() }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Configuracoes")
        do {
            let dadoTemp = try managedContext.fetch(fetchRequest)
            
            for temp in dadoTemp {
                return ConfiguracaoModel(valorDefinido: (temp.value(forKey: "valorDefinido") as? Float ?? 0.0))
            }
            
            return ConfiguracaoModel()
            
        } catch let error as NSError {
            print("Dados não encontrados \(error), \(error.userInfo)")
            return ConfiguracaoModel()
        }
    }
    
    func limpaEntities(entity:String) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try managedContext.execute(request)
        } catch {
            return
        }
    }
}
