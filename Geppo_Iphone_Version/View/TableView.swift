//
//  TableView.swift
//  Geppo_Iphone_Version
//
//  Created by Roland Garcia on 2023/09/02.
//

import SwiftUI

struct TableView: View {
   
    @ObservedObject var viewModel: ContentViewViewModel
    //@Binding var userEntries: [UserEntry]
   
    
    var body: some View {
        
        NavigationStack {
            if viewModel.userEntries.isEmpty{
                ContentUnavailableView("NoData", systemImage: "tray.fill", description: Text("Nenhuma data inserida"))
            }else {
                List{
                    ForEach(viewModel.userEntries.indices, id: \.self) { index in
                        NavigationLink(
                            destination: EditEntryView(entry: $viewModel.userEntries[index], userEntries: $viewModel.userEntries),
                                                label: {
                        VStack(alignment: .leading) {
                            Text("今日の日付　: \(viewModel.userEntries[index].formattedDate())")
                            Text("積み先　: \(viewModel.userEntries[index].tsumisaki)")
                            Text("行き先　: \(viewModel.userEntries[index].ikisaki)")
                            Text("コンテナNo.　: \(viewModel.userEntries[index].coNumber)")
                            Text("開始　: \(viewModel.userEntries[index].localDevolucao?.rawValue ?? "nenhum")")
                            Text("コンテナサイズ　: \(viewModel.userEntries[index].selectedSize.rawValue)")
                            Text("実 / 空　: \(viewModel.userEntries[index].selectedEstado.rawValue)")
                            Text("車しNo.　: \(viewModel.userEntries[index].shyashiNumber)")
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
            viewModel.userEntries.remove(atOffsets: offsets)
            
            
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
