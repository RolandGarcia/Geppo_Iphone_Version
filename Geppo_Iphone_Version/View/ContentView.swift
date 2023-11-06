//
//  ContentView.swift
//  Geppo_Iphone_Version
//
//  Created by Roland Garcia on 2023/08/26.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewViewModel()
   
    @State private var userEntries: [UserEntry] = []
    @State private var showTableView = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("日付け入れてください")) {
                    DatePicker("日付", selection: $viewModel.selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .environment(\.locale, Locale(identifier: "ja_JP"))
                        .environment(\.calendar, Calendar(identifier: .japanese))
                }
                
                Section(header: Text("積み先と Co.Number")) {
                    TextField("積み先", text: $viewModel.tsumisaki)
                    TextField("Co.Number", text: $viewModel.coNumber)
                        
                        }
                    
                Section(header: Text("行き先と輸出業者")) {
                    TextField("行き先", text: $viewModel.ikisaki)
                    Picker("輸出業者", selection: $viewModel.localDevolucao) {
                        ForEach(Constants.Devolucao.allCases) { devolucao in
                            Text(devolucao.rawValue).tag(devolucao)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("実 / 空、しゃしN 、コンテナサイズ")) {
                    Picker("サイズ", selection: $viewModel.selectedSize) {
                        ForEach(Constants.ContainerSize.allCases) { tamanho in
                            Text(tamanho.rawValue).tag(tamanho)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("実 / 空", selection: $viewModel.selectedEstado) {
                        ForEach(Constants.Estado.allCases) { estado in
                            Text(estado.rawValue).tag(estado)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("しゃしN番号", text: $viewModel.shyashiNumber)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Geppo")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: viewModel.addRowData) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                    .padding()
                    Button( action: {
                        showTableView.toggle()
                        print(showTableView)
                    },label: {
                        Image(systemName: "archivebox.fill")
                            .font(.title) // Ajuste o tamanho da imagem conforme necessário
                            .foregroundColor(.red) // Cor da imagem
                    })
                    .navigationDestination(isPresented: $showTableView, destination: { TableView(viewModel: viewModel)}
                    )
                    .padding()
                }
                
                
            }
            
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}
    
    
    
    struct Constants {
        enum ContainerSize: String, CaseIterable, Identifiable {
            
            var id: ContainerSize { self }
            
            case quarentaFeet = "40"
            case vinteFeet = "20"
        }
        
        
        enum Estado: String, CaseIterable, Identifiable {
            case cheio = "実"
            case vazio = "空"
            
            var id: Estado { self }
        }
        
        enum Devolucao: String, CaseIterable, Identifiable {
            
            case henbanNashi = "henBanNashi"
            case c8nitto = "c8nitto"
            case c8kamigumi = "C8kamigumi"
            case dict = "Dict"
            case c9mitsubishi = "C9Mitsubishi"
            case c9Mitsui = "C9Mitsui"
            case c1 = "C1"
            case c2_4 = "C2/4"
            case rkamigumi = "Rkamigumi"
            case rmitsubishi = "Rmitsubiushi"
            case kfnitsu = "KfNitsu"
            case KfKamigumi = "KfKamigumi"
            case KfShokai = "KfShokai"
            case yusen = "Yusen"
            case kinki = "Kinki"
            
            var id: Devolucao { self }
        }
    }
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    

