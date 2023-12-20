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
                    entry.coNumber.contains(searchText) || entry.formattedDate().contains(searchText) || entry.ikisaki.contains(searchText)
                }
            }
        }
   
    
    var body: some View {
            NavigationStack {
                VStack {
                    
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
                        .animation(.default, value: searchText)
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            }
        }
    
    private func deleteRow (at offsets: IndexSet) {
        withAnimation{
            viewModel.userEntries.remove(atOffsets: offsets)
            
            
        }
    }
    
}


    

#Preview {
    TableView(viewModel:ContentViewViewModel())
}
