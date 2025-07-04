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
}
let receita1 = ReceitaPessoal(valor: 150.0, descricao: "Trabalho de Social Media", categoria: .freelance)
let gasto1 = GastoPessoal(valor: 50.0, descricao: "Mercado", categoria: .comida)

let meuGerenciador = GerenciadorOrcamento()
meuGerenciador.adicionarReceita(novaReceita: receita1)
meuGerenciador.adicionarGasto(novoGasto: gasto1)

print("Saldo atual: \(meuGerenciador.saldo)")
print(meuGerenciador.consultaPorReceita(id: receita1.id))
