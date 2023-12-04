
import SwiftUI
import Foundation

struct EditEntryView: View {
    
    @Binding var entry: UserEntry
    @Binding var userEntries: [UserEntry]
    @State private var isShowingSaveAlert = false
    @Environment(\.dismiss) private var dismiss
    
    @State private var editedEntry: UserEntry
        
        init(entry: Binding<UserEntry>, userEntries: Binding<[UserEntry]>) {
            _entry = entry
            _userEntries = userEntries
            _editedEntry = State(initialValue: entry.wrappedValue)
        }
    
    
    var body: some View {
        NavigationStack { // Você deve usar NavigationView ao redor da visualização para permitir a navegação de volta
            
            Form{
            Section {
                
                    // Use o editedEntry em vez de entry nos campos de entrada
                    TextField("積み先", text: $editedEntry.tsumisaki)
                    TextField("行き先", text: $editedEntry.ikisaki)
                    TextField("コンテナNo.　", text: $editedEntry.coNumber)
                    
                    Picker("開始", selection: $editedEntry.localDevolucao) {
                        ForEach(Constants.Devolucao.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(Optional(option))
                        }
                    }
                    
                    Picker("コンテナサイズ", selection: $editedEntry.selectedSize) {
                        ForEach(Constants.ContainerSize.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    
                    Picker("実 / 空", selection: $editedEntry.selectedEstado) {
                        ForEach(Constants.Estado.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    
                    TextField("車しNo.", text: $editedEntry.shyashiNumber)
                } header: {
                    Text("Editar entrada")
                        .font(.largeTitle)
                }
                
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationBarItems(
                trailing: Button("Salvar") {
                    saveChanges()
                    isShowingSaveAlert = true
                }
            )
            .alert(isPresented: $isShowingSaveAlert) {
                Alert(
                    title: Text("Salvo com Sucesso"),
                    message: Text("Seus dados foram salvos com sucesso."),
                    dismissButton: .default(Text("OK"), action: {
                        // Atualize entry para refletir as alterações feitas
                        $entry.wrappedValue = editedEntry
                        dismiss()
                    })
                )
            }
        }
    }

    // A função saveChanges agora não precisa de um parâmetro
    func saveChanges() {
//        if let index = userEntries.firstIndex(where: { $0.id == entry.id }) {
//            userEntries[index] = entry
//        }
        $entry.wrappedValue = editedEntry
    }
}
