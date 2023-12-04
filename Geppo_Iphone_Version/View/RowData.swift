//
//  RowData.swift
//  Geppo_Iphone_Version
//
//  Created by Roland Garcia on 2023/12/04.
//

import SwiftUI

struct RowData: View {
    
    var rowData: UserEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("今日の日付: \(rowData.formattedDate())")
            Text("積み先: \(rowData.tsumisaki)")
            Text("行き先: \(rowData.ikisaki)")
            Text("コンテナNo.: \(rowData.coNumber)")
            Text("開始: \(rowData.localDevolucao?.rawValue ?? "nenhum")")
            Text("コンテナサイズ: \(rowData.selectedSize.rawValue)")
            Text("実 / 空: \(rowData.selectedEstado.rawValue)")
            Text("車しNo.: \(rowData.shyashiNumber)")
        }
    
    }
}
