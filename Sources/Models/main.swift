import Foundation

class GerenciadorOrcamento{
    var saldo: Double = 0.0
    var metaEconomia: Double = 0.0
    var gastos: [GastoPessoal]
    var receitas: [ReceitaPessoal]

    init (saldo: Double = 0.0, metaEconomia: Double = 0.0) {
        self.saldo = saldo
        self.metaEconomia = metaEconomia
        self.gastos = []
        self.receitas = []
    }

    func adicionarReceita(novaReceita: ReceitaPessoal){
        receitas.append(novaReceita)
        saldo += novaReceita.valor
        print("Nova receita \(novaReceita.descricao) no valor de \(novaReceita.valor) adicionada com sucesso!)")
    }

    func adicionarGasto(novoGasto: GastoPessoal){
        gastos.append(novoGasto)
        saldo -= novoGasto.valor
        print("Novo gasto \(novoGasto.descricao) no valor de \(novoGasto.valor) adicionado com sucesso!)")
    }
   
    func consultaPorReceita(id: UUID){
        for receita in receitas{
            if receita.id == id{
                print("Receita encontrada: \(receita.descricaoFormatada())")
                return
            }
        }
        print("Receita não encontrada!")
    }
    func consultaPorGasto(id: UUID){
        for gasto in gastos{
            if gasto.id == id{
                print("Gasto encontrado: \(gasto.descricaoFormatada())")
                return
            }
        }
    }
    func calcularGastoTotal() -> Double{
        var total = 0.0
        for gasto in gastos{
            total += gasto.valor
        }
        return total
    }

    func calcularReceitaTotal() -> Double{
        var total = 0.0
        for receita in receitas{
            total += receita.valor
        }
        return total
    }
    
    func removerGasto(id: UUID){
        if let index = gastos.firstIndex(where: { $0.id == id }) {
            let gastoRemovido = gastos.remove(at: index)
            saldo += gastoRemovido.valor
            print("Gasto \(gastoRemovido.descricao) removido com sucesso")
        } else {
        print("Gasto não encontrado!")
        }
    }
    func editarGasto(id: UUID, novoValor: Double, novaDescricao: String, novaCategoria: TipoGastos){
        if let index = gastos.firstIndex(where: { $0.id == id }) {
            let gastoEditado = gastos[index]
            gastoEditado.valor = novoValor
            gastoEditado.descricao = novaDescricao
            gastoEditado.categoria = novaCategoria.rawValue
            print("Gasto \(gastoEditado.descricao) editado com sucesso")
        } else {
            print("Gasto não encontrado!")
        }
    }
    func removerReceita(id: UUID){
        if let index = receitas.firstIndex(where: { $0.id == id }){
            let receitaRemovida = receitas.remove(at: index)
            saldo -= receitaRemovida.valor
            print("Receita \(receitaRemovida.descricao) removida com sucesso")
        } else {
            print("Receita não encontrada!")
        }
    }
    func editarReceita(id: UUID, novoValor: Double, novaDescricao: String, novaCategoria: TiposReceitas){
        if let index = receitas.firstIndex(where:{ $0.id == id}){
            let receitaEditada = receitas[index]
            receitaEditada.valor = novoValor
            receitaEditada.descricao = novaDescricao
            receitaEditada.categoria = novaCategoria.rawValue
            print("Receita \(receitaEditada.descricao) editada com sucesso")
        } else {
            print("Receita não encontrada!")
        }
    }
    func mediaGastos() -> Double{
        if gastos.count == 0{
            return 0.0
        }
        return calcularGastoTotal() / Double(gastos.count)
    }
}

let receita1 = ReceitaPessoal(valor: 150.0, descricao: "Trabalho de Social Media", categoria: .freelance)
let receita2 = ReceitaPessoal(valor: 245.3, descricao: "Tesouro Nacional", categoria: .investimento)
let gasto1 = GastoPessoal(valor: 50.0, descricao: "Mercado", categoria: .comida)
let gasto2 = GastoPessoal(valor: 132.50, descricao: "Compra Online", categoria: .compra)

let meuGerenciador = GerenciadorOrcamento()
meuGerenciador.adicionarReceita(novaReceita: receita1)
meuGerenciador.adicionarReceita(novaReceita: receita2)
meuGerenciador.adicionarGasto(novoGasto: gasto1)
meuGerenciador.adicionarGasto(novoGasto: gasto2)

print("Saldo atual: \(meuGerenciador.saldo)")
//print(meuGerenciador.consultaPorReceita(id: receita1.id))
//meuGerenciador.removerGasto(id: gasto1.id)
//print("Gasto total: \(meuGerenciador.calcularGastoTotal())")
//print("Receita total: \(meuGerenciador.calcularReceitaTotal())")
//print("Gasto 2: \(gasto2.descricaoFormatada())")
//meuGerenciador.editarGasto(id: gasto2.id, novoValor: 100.00, novaDescricao: "Compra no Mercado", novaCategoria: .comida)
//print("Gasto total: \(meuGerenciador.calcularGastoTotal())")
//print("Gasto 2: \(gasto2.descricaoFormatada())")

//meuGerenciador.removerReceita(id: receita1.id)
//print("Saldo atual: \(meuGerenciador.saldo)")
//meuGerenciador.editarReceita(id: receita2.id, novoValor: 240.5, novaDescricao: "Tesouro Internacional", novaCategoria: .cashback)
//print("Saldo atual: \(meuGerenciador.saldo)")
//print("Receita 2: \(receita2.descricaoFormatada())")

print("Média de gastos: \(meuGerenciador.mediaGastos())")