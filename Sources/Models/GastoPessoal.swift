import Foundation

class GastoPessoal: ItemOrcamento{
    let id: String
    var valor: Double
    var descricao: String
    var categoria: String
    var data: Date
    
    init(valor: Double, descricao: String, categoria: TipoGastos, data: Date = Date()){
        self.id = UUID().uuidString
        self.valor = valor
        self.descricao = descricao
        self.categoria = categoria.rawValue
        self.data = data
    }

    func descricaoFormatada() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return "Gasto: \(descricao) (\(categoria)) - R$ \(valor) em \(dateFormatter.string(from: data))"
    }
}