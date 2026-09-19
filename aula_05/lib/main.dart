// =======================================================================
// EXEMPLO COMENTADO — Conceitos fundamentais de Flutter/Dart
// =======================================================================
// Este arquivo demonstra, em um único app didático, os seguintes conceitos:
//   1. StatefulWidget — Estado
//   2. setState() — Atualização
//   3. Estado da aplicação — Dados
//   4. TextField — Entrada
//   5. TextEditingController — Controle
//   6. Checkbox — Seleção
//   7. DropdownButton — Escolha
//   8. Classes e objetos — Modelagem
//   9. Passagem de dados — Comunicação
//  10. Navigator.push() — Avançar
//  11. Navigator.pop() — Retornar
//  12. async/await — Assincronismo
// =======================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------
// FUNÇÃO main()
// -----------------------------------------------------------------------
// Todo app Flutter começa aqui. runApp() recebe um Widget e o "planta"
// na tela, iniciando a árvore de widgets que forma a interface.
void main() {
  runApp(const MyApp());
}

// -----------------------------------------------------------------------
// MyApp — Widget raiz do aplicativo
// -----------------------------------------------------------------------
// É um StatelessWidget porque ele mesmo não guarda nenhum dado que muda
// com o tempo — ele só configura o MaterialApp (tema, título, rota
// inicial) e delega o trabalho para CadastroPage.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Conceitos Flutter',
      // home define qual widget aparece primeiro quando o app abre.
      home: const CadastroPage(),
    );
  }
}

// =========================================================================
// 8) CLASSES E OBJETOS — Modelagem
// =========================================================================
// Uma classe é um "molde" que descreve os dados de algo do mundo real
// (aqui, uma Pessoa). Um objeto é uma instância concreta dessa classe,
// criada em tempo de execução com valores específicos.
//
// Usamos uma classe em vez de variáveis soltas porque isso agrupa dados
// relacionados (nome, aceite dos termos, cidade) em uma única unidade,
// facilitando levar essas informações de uma tela para outra.
class Pessoa {
  // Atributos (campos) da classe — cada objeto Pessoa terá seus
  // próprios valores para essas três variáveis.
  final String nome;
  final bool aceitaTermos;
  final String cidade;

  // Construtor — é o "molde de criação" do objeto. O `required` obriga
  // quem cria uma Pessoa a informar os três valores.
  Pessoa({
    required this.nome,
    required this.aceitaTermos,
    required this.cidade,
  });

  // Sobrescrevemos toString() para que, se algum dia imprimirmos um
  // objeto Pessoa (ex: print(pessoa)), o texto exibido seja legível.
  @override
  String toString() {
    return 'Nome: $nome | Aceitou termos: $aceitaTermos | Cidade: $cidade';
  }
}

// =========================================================================
// 1) STATEFULWIDGET — Estado
// =========================================================================
// CadastroPage é a "casca" do widget: ela é imutável e só existe para
// criar e apontar para o seu State (_CadastroPageState), que é onde os
// dados que mudam realmente vivem. Todo StatefulWidget segue esse par:
// uma classe Widget + uma classe State associada.
class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  // createState() é chamado pelo Flutter para instanciar o objeto de
  // estado que vai controlar essa tela.
  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

// O underscore (_) no início do nome torna a classe "privada" a este
// arquivo — convenção comum para as classes de State.
class _CadastroPageState extends State<CadastroPage> {
  // =======================================================================
  // 5) TEXTEDITINGCONTROLLER — Controle
  // =======================================================================
  // O TextEditingController é o "elo" entre o código e o texto digitado
  // pelo usuário em um TextField. Com ele conseguimos LER o que foi
  // digitado (_nomeController.text) e também LIMPAR o campo
  // programaticamente (_nomeController.clear()), sem precisar que o
  // usuário apague manualmente.
  final TextEditingController _nomeController = TextEditingController();

  // =======================================================================
  // 3) ESTADO DA APLICAÇÃO — Dados
  // =======================================================================
  // Estas três variáveis são o "estado" desta tela: valores que podem
  // mudar ao longo do tempo (por interação do usuário) e que, quando
  // mudam, precisam refletir visualmente na interface.
  bool _aceitaTermos = false;    // controla o Checkbox
  String _cidadeSelecionada = 'Londrina'; // controla o DropdownButton
  bool _carregando = false;      // controla se mostramos um spinner ou o botão

  // Lista fixa de opções que vamos oferecer no DropdownButton.
  final List<String> _cidades = ['Londrina', 'Curitiba', 'Maringá', 'São Paulo'];

  // dispose() é chamado automaticamente pelo Flutter quando esta tela é
  // destruída (por exemplo, ao sair dela). É obrigatório "liberar" o
  // TextEditingController aqui para evitar vazamento de memória.
  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  // =======================================================================
  // 12) ASYNC/AWAIT — Assincronismo
  // =======================================================================
  // O modificador `async` indica que esta função pode executar tarefas
  // demoradas (como acesso à rede ou a um banco de dados) sem travar a
  // interface do usuário enquanto espera a resposta. `await` "pausa" a
  // execução desta função (só dela, não do app inteiro) até que a
  // operação assíncrona termine.
  Future<void> _salvarCadastro() async {
    // Validação simples antes de prosseguir.
    if (_nomeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o nome antes de continuar.')),
      );
      return;
    }

    // =====================================================================
    // 2) setState() — Atualização
    // =====================================================================
    // Chamar setState() é a forma de avisar o Flutter: "um dado do meu
    // estado mudou, por favor redesenhe a tela". Sem essa chamada, a
    // variável mudaria no código, mas a interface continuaria mostrando
    // o valor antigo. Aqui ligamos o indicador de carregamento.
    setState(() {
      _carregando = true;
    });

    // Simula uma operação assíncrona real (por exemplo, uma chamada de
    // API ou uma escrita em banco de dados) esperando 2 segundos.
    // Enquanto este await está "pausado", o app continua responsivo —
    // o usuário poderia, teoricamente, interagir com outras partes da
    // tela (aqui já mostramos um spinner, então o botão fica escondido).
    await Future.delayed(const Duration(seconds: 2));

    // Criamos o objeto Pessoa (uso prático do item 8) com os dados
    // coletados dos widgets de entrada.
    final pessoa = Pessoa(
      nome: _nomeController.text.trim(),
      aceitaTermos: _aceitaTermos,
      cidade: _cidadeSelecionada,
    );

    // Novo setState(): agora que a operação "assíncrona" terminou,
    // desligamos o indicador de carregamento para a tela refletir isso.
    setState(() {
      _carregando = false;
    });

    // `mounted` verifica se este State ainda está "vivo" na árvore de
    // widgets. Como passamos por um await, é possível que o usuário já
    // tenha saído da tela nesse meio-tempo — usar context depois de um
    // await sem checar mounted pode causar erro.
    if (!mounted) return;

    // =====================================================================
    // 10) NAVIGATOR.PUSH() — Avançar
    // 9) PASSAGEM DE DADOS — Comunicação (tela 1 -> tela 2)
    // =====================================================================
    // Navigator.push() empilha uma nova tela (ResumoPage) por cima da
    // atual. Passamos o objeto `pessoa` diretamente pelo construtor de
    // ResumoPage — essa é a forma mais simples de "comunicar" dados de
    // uma tela para a próxima.
    //
    // Também usamos `await` aqui: push() retorna um Future que só se
    // resolve quando a tela ResumoPage for fechada (com Navigator.pop).
    // O valor entre <> (String) indica o TIPO de dado que esperamos
    // receber de volta.
    final resultado = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => ResumoPage(pessoa: pessoa),
      ),
    );

    // Este trecho só roda DEPOIS que o usuário voltar da ResumoPage,
    // pois estamos "esperando" o Future do Navigator.push com await.
    // `resultado` contém o valor que a ResumoPage enviou via
    // Navigator.pop(context, valor) — outra forma de passagem de dados,
    // agora no sentido tela 2 -> tela 1.
    if (resultado != null) {
      setState(() {
        _nomeController.clear();   // limpa o campo de texto
        _aceitaTermos = false;     // reseta o checkbox
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resultado)),
        );
      }
    }
  }

  // build() é chamado toda vez que o Flutter precisa (re)desenhar esta
  // tela — seja na primeira construção, seja após um setState().
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Pessoa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===================================================================
            // 4) TEXTFIELD — Entrada
            // ===================================================================
            // Widget que permite ao usuário digitar texto. Ele é "ligado"
            // ao _nomeController através da propriedade `controller` — é
            // assim que conseguimos ler o texto digitado em outro
            // momento (dentro de _salvarCadastro()).
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome completo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // ===================================================================
            // 6) CHECKBOX — Seleção
            // ===================================================================
            // Widget de marcação sim/não. `value` reflete o estado atual
            // (_aceitaTermos) e `onChanged` é chamado toda vez que o
            // usuário toca no checkbox, entregando o novo valor (true
            // ou false, por isso o `?? false` — proteção contra null).
            Row(
              children: [
                Checkbox(
                  value: _aceitaTermos,
                  onChanged: (valor) {
                    // setState() aqui garante que a tela seja
                    // redesenhada mostrando a caixinha marcada/desmarcada.
                    setState(() {
                      _aceitaTermos = valor ?? false;
                    });
                  },
                ),
                const Text('Aceito os termos de uso'),
              ],
            ),
            const SizedBox(height: 16),

            // ===================================================================
            // 7) DROPDOWNBUTTON — Escolha
            // ===================================================================
            // Widget de seleção entre várias opções pré-definidas.
            // `value` é a opção atualmente selecionada, `items` é a
            // lista de opções (construída a partir de _cidades usando
            // .map()), e `onChanged` atualiza o estado quando o usuário
            // escolhe uma cidade diferente.
            DropdownButton<String>(
              value: _cidadeSelecionada,
              isExpanded: true,
              items: _cidades.map((cidade) {
                return DropdownMenuItem(
                  value: cidade,
                  child: Text(cidade),
                );
              }).toList(),
              onChanged: (novaCidade) {
                setState(() {
                  // O `!` diz ao Dart "tenho certeza que não é null" —
                  // seguro aqui porque o DropdownButton só chama
                  // onChanged com um valor válido da lista de items.
                  _cidadeSelecionada = novaCidade!;
                });
              },
            ),
            const SizedBox(height: 24),

            // Alterna entre spinner (enquanto _carregando == true) e o
            // botão de ação — outro exemplo de estado controlando a UI.
            Center(
              child: _carregando
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _salvarCadastro,
                      child: const Text('Salvar e ver resumo'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// Segunda tela — recebe o objeto Pessoa (uso prático dos itens 8 e 9)
// =========================================================================
// Esta tela é um StatelessWidget porque ela apenas EXIBE os dados
// recebidos — não precisa guardar nem alterar nenhum estado próprio.
class ResumoPage extends StatelessWidget {
  // O objeto Pessoa chega até aqui pelo construtor — exatamente o valor
  // que foi passado em `ResumoPage(pessoa: pessoa)` lá no
  // Navigator.push(). Esse é o mecanismo de passagem de dados entre
  // widgets/telas em Flutter: por parâmetros de construtor.
  final Pessoa pessoa;

  const ResumoPage({super.key, required this.pessoa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo do cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Aqui usamos diretamente os campos do objeto `pessoa`
            // (pessoa.nome, pessoa.cidade, pessoa.aceitaTermos) — prova
            // de que os dados realmente "viajaram" da tela anterior.
            Text('Nome: ${pessoa.nome}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Cidade: ${pessoa.cidade}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              pessoa.aceitaTermos ? 'Termos aceitos ✅' : 'Termos não aceitos ❌',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              // =============================================================
              // 11) NAVIGATOR.POP() — Retornar
              // 9) PASSAGEM DE DADOS — Comunicação (tela 2 -> tela 1)
              // =============================================================
              // Navigator.pop() desempilha esta tela, voltando para a
              // anterior (CadastroPage). O segundo argumento é o valor
              // que será "entregue" para quem estava esperando o
              // Future de Navigator.push() — nesse caso, uma mensagem
              // de confirmação em formato String.
              onPressed: () {
                Navigator.pop(context, 'Cadastro de ${pessoa.nome} confirmado!');
              },
              child: const Text('Confirmar e voltar'),
            ),
          ],
        ),
      ),
    );
  }
}