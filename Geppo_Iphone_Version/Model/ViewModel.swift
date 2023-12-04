//
//  ViewModel.swift
//  Geppo_Iphone_Version
//
//  Created by Roland Garcia on 2023/11/06.
//


import Foundation
import SwiftUI

class ContentViewViewModel: ObservableObject {
    
    var hasData: Bool {
        return !userEntries.isEmpty
    }
    
    @Published var userEntries: [UserEntry] = []
    
    @Published var selectedDate = Date()
    @Published var tsumisaki = ""
    @Published var coNumber : String =  "" {
        didSet{
            if coNumber.count > 11 {
                coNumber = String(coNumber.prefix(11))
            }
        }
    }
    @Published var ikisaki = ""
    @Published var localDevolucao: Constants.Devolucao = .henbanNashi
    @Published var selectedSize: Constants.ContainerSize = .quarentaFeet
    @Published var selectedEstado: Constants.Estado = .cheio
    @Published var shyashiNumber = ""
    
    func clearFields() {
        selectedDate = Date()
        tsumisaki = ""
        coNumber = ""
        ikisaki = ""
        localDevolucao = .henbanNashi
        selectedSize = .quarentaFeet
        selectedEstado = .cheio
        shyashiNumber = ""
    }
    func addRowData() {
        userEntries.append(
            UserEntry(
                selectedDate: selectedDate,
                tsumisaki: tsumisaki,
                coNumber: coNumber,
                ikisaki: ikisaki,
                localDevolucao: localDevolucao,
                selectedSize: selectedSize,
                selectedEstado: selectedEstado,
                shyashiNumber: shyashiNumber
            )
        )
        clearFields()
    }
}
