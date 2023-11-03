//
//  TableView.swift
//  Geppo_Iphone_Version
//
//  Created by Roland Garcia on 2023/09/02.
//

import SwiftUI

struct TableView: View {
   
    
    @Binding var userEntries: [UserEntry]
   
    
    var body: some View {
        
        NavigationStack {
            if $userEntries.isEmpty{
                ContentUnavailableView("NoData", systemImage: "tray.fill", description: Text("Nenhuma data inserida"))
            }else {
                List{
                    ForEach($userEntries.indices, id: \.self) { index in
                        NavigationLink(
                                                destination: EditEntryView(entry: $userEntries[index], userEntries: $userEntries),
                                                label: {
                        VStack(alignment: .leading) {
                            Text("今日の日付　: \(userEntries[index].formattedDate())")
                            Text("積み先　: \(userEntries[index].tsumisaki)")
                            Text("行き先　: \(userEntries[index].ikisaki)")
                            Text("コンテナNo.　: \(userEntries[index].coNumber)")
                            Text("開始　: \(userEntries[index].localDevolucao?.rawValue ?? "nenhum")")
                            Text("コンテナサイズ　: \(userEntries[index].selectedSize.rawValue)")
                            Text("実 / 空　: \(userEntries[index].selectedEstado.rawValue)")
                            Text("車しNo.　: \(userEntries[index].shyashiNumber)")
                        }
                        
                    }
                                                )}
                    .onDelete(perform:deleteRow)
                    
                }
                
                .navigationTitle("Lista salva")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing){
                        EditButton()
                    }
                }
                
            }
        }
        }
        

    
    
    private func deleteRow (at offsets: IndexSet) {
        withAnimation{
            userEntries.remove(atOffsets: offsets)
            
            
        }
    }
    
}

    







//struct TableView_Previews: PreviewProvider {
//    static var previews: some View {
//            createPreviewView()
//        }
//        
//        static func createPreviewView() -> some View {
//            let userEntries = createUserEntries()
//            return TableView(userEntries: .constant(userEntries))
//        }
//        
//        static func createUserEntries() -> [UserEntry] {
//            let userEntry1 = UserEntry(selectedDate: Date(), tsumisaki: "Exemplo1", coNumber: "12345", ikisaki: "Exemplo2", localDevolucao: Devolucao.c8nitto, selectedSize: ContainerSize.vinteFeet, selectedEstado: Estado.vazio, shyashiNumber: "ABC123")
//            
//            let userEntry2 = UserEntry(selectedDate: Date(), tsumisaki: "Exemplo3", coNumber: "67890", ikisaki: "Exemplo4", localDevolucao:Devolucao.c9mitsubishi, selectedSize: ContainerSize.quarentaFeet, selectedEstado: Estado.cheio, shyashiNumber: "XYZ789")
//            
//            return [userEntry1, userEntry2]
//        }
//}
