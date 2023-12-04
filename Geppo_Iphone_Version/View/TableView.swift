//
//  TableView.swift
//  Geppo_Iphone_Version
//
//  Created by Roland Garcia on 2023/09/02.
//

import SwiftUI

struct TableView: View {
   
    @ObservedObject var viewModel: ContentViewViewModel
    @State private var searchText = ""

        var filteredEntries: [UserEntry] {
            if searchText.isEmpty {
                return viewModel.userEntries
            } else {
                return viewModel.userEntries.filter { entry in
                    entry.coNumber.contains(searchText) || entry.formattedDate().contains(searchText)
                }
            }
        }
   
    
    var body: some View {
            NavigationStack {
                VStack {
                    TextField("Pesquisar", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    if filteredEntries.isEmpty {
                        ContentUnavailableView("NoData", systemImage: "tray.fill", description: Text("Nenhum resultado encontrado"))
                    } else {
                        List {
                            ForEach(filteredEntries, id: \.id) { entry in
                                NavigationLink(
                                    destination: EditEntryView(entry: $viewModel.userEntries[viewModel.userEntries.firstIndex(of: entry)!], userEntries: $viewModel.userEntries),
                                    label: {
                                        RowData(rowData: entry)
                                    }
                                )
                            }
                            .onDelete(perform: deleteRow)
                        }
                        .navigationTitle("Lista salva")
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
