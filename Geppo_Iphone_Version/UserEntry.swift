//
//  UserEntry.swift
//  Geppo_Iphone_Version
//
//  Created by Roland Garcia on 2023/09/02.
//

import Foundation


struct UserEntry: Identifiable, Equatable {
    
    
    let id = UUID()
    var selectedDate: Date
    var tsumisaki: String
    var coNumber: String
    var ikisaki: String
    var localDevolucao: Constants.Devolucao?
    var selectedSize: Constants.ContainerSize
    var selectedEstado: Constants.Estado
    var shyashiNumber: String
      
    
    
    //funcao para formatar a data
    func formattedDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"
            return dateFormatter.string(from: selectedDate)
        }
}
