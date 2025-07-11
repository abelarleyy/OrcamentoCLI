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
        print("Nova receita \(novaReceita.descricao) no valor de \(novaReceita.valor) adicionada com sucesso!")
    }

    func adicionarGasto(novoGasto: GastoPessoal){
        gastos.append(novoGasto)
        saldo -= novoGasto.valor
        print("Novo gasto \(novoGasto.descricao) no valor de \(novoGasto.valor) adicionado com sucesso!")
    }

    func mostrarTodasReceitas(){
        for receita in receitas{
            print(receita.descricaoFormatada())
        }
    }

    func mostrarTodosGastos(){
        for gasto in gastos{
            print(gasto.descricaoFormatada())
        }
    }
   
    func consultarReceitaNome(nome: String){
        for receita in receitas{
            if receita.descricao == nome{
                print("Receita encontrada: \(receita.descricaoFormatada())")
                return
            }
        }
        print("Receita não encontrada")
    }
    func consultarGastoNome(nome: String){
        for gasto in gastos{
            if gasto.descricao == nome{
                print("Gasto encontrado: \(gasto.descricaoFormatada())")
                return
            }
        }
        print("Gasto não encontrado")
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
    
    func removerGastoPeloNome(nome: String){
        if let index = gastos.firstIndex(where: { $0.descricao == nome }){
            let gastoRemovido = gastos.remove(at: index)
            saldo += gastoRemovido.valor
            print("Gasto \(gastoRemovido.descricao) removido com sucesso")
        } else {
            print("Gasto não encontrado")
        }
    }
    func removerReceitaPeloNome(nome: String){
        if let index = receitas.firstIndex(where: { $0.descricao == nome }){
            let receitaRemovida = receitas.remove(at: index)
            saldo -= receitaRemovida.valor
            print("Receita \(receitaRemovida.descricao) removida com sucesso")
        } else {
            print("Receita não encontrada")
        }
    }
    func editarGasto(descricaoAntiga: String, novaDescricao: String, novoValor: Double, novaCategoria: TipoGastos) {
        if let index = gastos.firstIndex(where: { $0.descricao.lowercased() == descricaoAntiga.lowercased() }) {
            let valorAntigo = gastos[index].valor
            saldo += valorAntigo

            gastos[index].descricao = novaDescricao
            gastos[index].valor = novoValor
            gastos[index].categoria = novaCategoria.rawValue
            gastos[index].data = Date()

            saldo -= novoValor

            print("Gasto editado com sucesso!")
        } else {
            print("Gasto com a descrição '\(descricaoAntiga)' não encontrado!")
        }
    }
     func editarReceita(descricaoAntiga: String, novaDescricao: String, novoValor: Double, novaCategoria: TiposReceitas) {
        if let index = receitas.firstIndex(where: { $0.descricao.lowercased() == descricaoAntiga.lowercased() }) {
            let valorAntigo = receitas[index].valor
            saldo -= valorAntigo
            
            receitas[index].descricao = novaDescricao
            receitas[index].valor = novoValor
            receitas[index].categoria = novaCategoria.rawValue
            receitas[index].data = Date()

            saldo += novoValor
            
            print("Receita editada com sucesso!")
        } else {
            print("Receita com a descrição '\(descricaoAntiga)' não encontrada!")
        }
    }
    func mediaReceitas() -> Double{
        if receitas.count == 0{
            return 0.0
        }
        return calcularReceitaTotal() / Double(receitas.count)
    }
    func mediaGastos() -> Double{
        if gastos.count == 0{
            return 0.0
        }
        return calcularGastoTotal() / Double(gastos.count)
    }
    func definirMeta(metaAtual: Double) -> Double{
        metaEconomia = metaAtual
        return metaEconomia 
    }
    func editarMeta(novaMeta: Double) -> Double{
        metaEconomia = novaMeta
        return metaEconomia
    }
    func metaDeEconomia() -> Double{
        print("\nA meta de economia é de \(metaEconomia)")
        print("O saldo atual é de \(saldo)")
        print("E falta isso para atingir a meta: ")
        return (metaEconomia - saldo)
    }
}

let meuGerenciador = GerenciadorOrcamento()
var rodandoMenu = true

while rodandoMenu{
        print("\n --- Menu Orçamento ---")
        print("1. Mostrar Saldo")
        print("2. Adicionar Receita")
        print("3. Adicionar Gasto")
        print("4. Mostrar Todas as Receitas")
        print("5. Mostrar Todos os Gastos")
        print("6. Consultar Receita pela descrição")
        print("7. Consultar Gasto pela descrição")
        print("8. Remover Receita")
        print("9. Remover Gasto")
        print("10. Editar Receita")
        print("11. Editar Gasto")
        print("12. Média de Receitas")
        print("13. Média de Gastos")
        print("14. Definir Meta")
        print("15. Editar Meta")
        print("16. Meta de Economia")
        print("17. Sair")
        print("\nDigite o número da opção: ")

    if let escolha = readLine(), let escolhaInt = Int(escolha){
        switch escolhaInt{
            case 1:
                print("O saldo atual é de \(meuGerenciador.saldo)")
            case 2:
                print("--- Adicionar Receita ---")

                print("Escolha a categoria da receita:")
                for (index, tipo) in TiposReceitas.allCases.enumerated() {
                    print("\(index + 1). \(tipo.rawValue)")
                }
                guard let categoriaIndexStr = readLine(),
                      let categoriaIndex = Int(categoriaIndexStr),
                      categoriaIndex > 0 && categoriaIndex <= TiposReceitas.allCases.count else {
                    print("Seleção de categoria inválida.")
                    continue
                }

                print("Digite a descrição da receita: ")
                guard let descricaoReceita = readLine(), !descricaoReceita.isEmpty else {
                    print("Descrição inválida.")
                    continue
                }
                print("Digite o valor da receita: ")
                guard let valorReceitaStr = readLine(), let valorReceita = Double(valorReceitaStr) else {
                    print("Valor inválido.")
                    continue
                }
                
                let categoriaReceita = TiposReceitas.allCases[categoriaIndex - 1]

                let novaReceita = ReceitaPessoal(valor: valorReceita, descricao: descricaoReceita, categoria: categoriaReceita)
                meuGerenciador.adicionarReceita(novaReceita: novaReceita)
            case 3:
                print("--- Adicionar Gasto ---")

                print("Escolha a categoria do gasto:")
                for (index, tipo) in TipoGastos.allCases.enumerated() {
                    print("\(index + 1). \(tipo.rawValue)")
                }
                guard let categoriaIndexStr = readLine(),
                      let categoriaIndex = Int(categoriaIndexStr),
                      categoriaIndex > 0 && categoriaIndex <= TipoGastos.allCases.count else {
                    print("Seleção de categoria inválida.")
                    continue
                }
                let categoriaGasto = TipoGastos.allCases[categoriaIndex - 1]

                print("Digite a descrição do gasto: ")
                guard let descricaoGasto = readLine(), !descricaoGasto.isEmpty else {
                    print("Descrição inválida.")
                    continue
                }
                
                print("Digite o valor do gasto: ")
                guard let valorGastoStr = readLine(), let valorGasto = Double(valorGastoStr) else {
                    print("Valor inválido.")
                    continue
                }                

                let novoGasto = GastoPessoal(valor: valorGasto, descricao: descricaoGasto, categoria: categoriaGasto)
                meuGerenciador.adicionarGasto(novoGasto: novoGasto)
            case 4:
                print("--- Mostrar Todas as Receitas ---")
                meuGerenciador.mostrarTodasReceitas()
            case 5:
                print("--- Mostrar Todos os Gastos ---")
                meuGerenciador.mostrarTodosGastos()
            case 6: 
                print("--- Consultar Receita Pelo Nome ---")
                print("Digite o nome da receita: ")
                guard let nomeReceita: String = readLine(), !nomeReceita.isEmpty else {
                    print("Nome inválido.")
                    continue
                }
                meuGerenciador.consultarReceitaNome(nome: nomeReceita)
            case 7:
                print("--- Consultar Gasto Pelo Nome ---")
                print("Digite o nome do gasto: ")
                guard let nomeGasto: String = readLine(), !nomeGasto.isEmpty else {
                    print("Nome inválido.")
                    continue
                }
                meuGerenciador.consultarGastoNome(nome: nomeGasto)                
            case 8:
                print("--- Remover Receita pelo Nome ---")
                print("Digite o nome da receita: ")
                guard let nomeReceita: String = readLine(), !nomeReceita.isEmpty else {
                    print("Nome inválido.")
                    continue
                }
                meuGerenciador.removerReceitaPeloNome(nome: nomeReceita)
            case 9:
                print("--- Remover Gasto pelo Nome ---")
                print("Digite o nome do gasto: ")
                guard let nomeGasto: String = readLine(), !nomeGasto.isEmpty else{
                    print("Nome inválido.")
                    continue
                }
                meuGerenciador.removerGastoPeloNome(nome: nomeGasto)
            case 10:
                print("--- Editar Receita ---")
                print("Digite a descrição da receita: ")
                guard let descricaoAntigaStr: String = readLine(), !descricaoAntigaStr.isEmpty else{
                    print("Descrição inválida.")
                    continue
                }
                print("Digite a nova descrição da receita: ")
                guard let novaDescricaoStr: String = readLine(), !novaDescricaoStr.isEmpty else{
                    print("Descrição inválida.")
                    continue
                }
                print("Digite o novo valor da receita: ")
                guard let novoValorStr: String = readLine(), let novoValor = Double(novoValorStr) else{
                    print("Valor inválido.")
                    continue
                }
                print("Escolha a nova categoria da receita:")
                for (index, tipo) in TiposReceitas.allCases.enumerated() {
                    print("\(index + 1). \(tipo.rawValue)")
                }
                guard let categoriaIndexStr: String = readLine(), 
                    let categoriaIndex = Int(categoriaIndexStr),
                    categoriaIndex > 0 && categoriaIndex <= TiposReceitas.allCases.count else {
                print("Seleção de categoria inválida.")
                continue
                }
                let novaCategoria = TiposReceitas.allCases[categoriaIndex - 1]
                meuGerenciador.editarReceita(descricaoAntiga: descricaoAntigaStr, novaDescricao: novaDescricaoStr, novoValor: novoValor, novaCategoria: novaCategoria)
            case 11:
                print("--- Editar Gasto ---")
                print("Digite a descrição do gasto: ")
                guard let descricaoAntigaStr: String = readLine(), !descricaoAntigaStr.isEmpty else {
                    print("Descrição inválida.")
                    continue
                }
                print("Digite a nova descrição do gasto: ")
                guard let novaDescricaoStr: String = readLine(), !novaDescricaoStr.isEmpty else{
                    print("Descrição inválida.")
                    continue
                }
                print("Digite o novo valor do gasto: ")
                guard let novoValorStr: String = readLine(), let novoValor: Double = Double(novoValorStr) else {
                    print("Valor inválido!")
                    continue
                }
                print("Escolha a nova categoria do gasto:")
                for (index, tipo) in TipoGastos.allCases.enumerated(){
                    print("\(index + 1). \(tipo.rawValue)")
                }
                guard let categoriaIndexStr: String = readLine(),
                let categoriaIndex = Int(categoriaIndexStr),
                categoriaIndex > 0 && categoriaIndex <= TipoGastos.allCases.count else {
                    print("Seleção de categoria inválida.")
                    continue
                }
                let novaCategoria = TipoGastos.allCases[categoriaIndex - 1]
                meuGerenciador.editarGasto(descricaoAntiga: descricaoAntigaStr, novaDescricao: novaDescricaoStr, novoValor: novoValor, novaCategoria: novaCategoria)
            case 12:
                print("A média de receitas é: \(meuGerenciador.mediaReceitas())")
            case 13:
                print("A média de gastos é: \(meuGerenciador.mediaGastos())")
            case 14:
                print("--- Definir Meta de Economia ---")
                print("Digite o valor da meta:")
                if let metaStr = readLine(), let meta = Double(metaStr) {
                    let metaDefinida = meuGerenciador.definirMeta(metaAtual: meta)
                    print("Meta definida para: \(metaDefinida)")
                } else {
                    print("Valor de meta inválido.")
                }

            case 15:
                print("--- Editar Meta de Economia ---")
                print("Digite o novo valor da meta:")
                if let novaMetaStr = readLine(), let novaMeta = Double(novaMetaStr) {
                    let metaEditada = meuGerenciador.editarMeta(novaMeta: novaMeta)
                    print("Meta editada para: \(metaEditada)")
                } else {
                    print("Valor de meta inválido.")
                }

            case 16:
                let falta = meuGerenciador.metaDeEconomia()
                print(falta)

            case 17:
                rodandoMenu = false
            default:
                print("Opção inválida")
        }
    }
}