import Foundation

protocol ItemOrcamento{
    var id: String {get}
    var valor: Double {get set}
    var descricao: String {get set}
    var categoria: String {get set}
    var data: Date {get set}
    func descricaoFormatada() -> String
}