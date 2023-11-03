
import SwiftUI
import Foundation

struct EditEntryView: View {
    
    @Binding var entry: UserEntry
    @Binding var userEntries: [UserEntry]
    @State private var isShowingSaveAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack { // Você deve usar NavigationView ao redor da visualização para permitir a navegação de volta
            Form {
                Section {
                    TextField("積み先", text: $entry.tsumisaki)
                    TextField("行き先", text: $entry.ikisaki)
                    TextField("コンテナNo.　", text: $entry.coNumber)
                    
                    Picker("開始", selection: $entry.localDevolucao) {
                        ForEach(Constants.Devolucao.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(Optional(option))
                        }
                    }
                    
                    Picker("コンテナサイズ", selection: $entry.selectedSize) {
                        ForEach(Constants.ContainerSize.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    
                    Picker("実 / 空", selection: $entry.selectedEstado) {
                        ForEach(Constants.Estado.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    
                    TextField("車しNo.", text: $entry.shyashiNumber)
                } header: {
                    Text("Editar entrada")
                        .font(.largeTitle)
                }
                            }
            
            .navigationBarItems(
                trailing: Button("Salvar") {
                    saveChanges() // Chame a função saveChanges
                    isShowingSaveAlert = true
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            )
            .alert(isPresented: $isShowingSaveAlert) {
                Alert(
                    title: Text("Salvo com Sucesso"),
                    message: Text("Seus dados foram salvos com sucesso."),
                    dismissButton: .default(Text("OK"), action: {
                        dismiss()
                    }
                )
            )}
        }
    }

    // A função saveChanges agora não precisa de um parâmetro
    func saveChanges() {
        if let index = userEntries.firstIndex(where: { $0.id == entry.id }) {
            userEntries[index] = entry
        }
    }
}
