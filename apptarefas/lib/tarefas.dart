// =============================================
// IMPORTAÇÕES
// =============================================

// Biblioteca do Flutter com os widgets do Material Design
// (Scaffold, AppBar, TextField, ElevatedButton, etc.).
import 'package:flutter/material.dart';

// =============================================
// PONTO DE ENTRADA (APENAS PARA TESTE)
// =============================================

// Este main() serve só para rodar esta tela isoladamente
// durante os testes. No app completo quem inicia tudo é o
// main() do arquivo principal, e esta tela é aberta pelo
// Navigator. Pode ser apagado na entrega final.
void main() {
  runApp(
    const MaterialApp(
      // Remove a faixa vermelha "DEBUG" do canto da tela.
      debugShowCheckedModeBanner: false,

      // Define qual tela aparece ao abrir.
      home: Tarefas(),
    ),
  );
}

// =============================================
// TELA DE TAREFAS
// =============================================

// StatefulWidget é usado porque a tela muda durante a
// execução: o contador aumenta e os campos recebem texto.
class Tarefas extends StatefulWidget {
  // Construtor. O "const" permite que o Flutter reaproveite
  // esta instância, e "super.key" repassa a chave de
  // identificação do widget para a classe pai.
  const Tarefas({super.key});

  // Método obrigatório do StatefulWidget: cria o objeto de
  // estado que guarda os dados e desenha a interface.
  @override
  State<Tarefas> createState() => _TarefasState();
}

// =============================================
// ESTADO DA TELA
// =============================================

// O underline (_) no início do nome torna a classe privada,
// visível apenas dentro deste arquivo.
class _TarefasState extends State<Tarefas> {
  // =============================================
  // CONTADOR DE TAREFAS
  // =============================================

  // Variável de estado: sobrevive aos redesenhos da tela.
  int contador = 0;

  // =============================================
  // CONTROLADORES DE CAMPO
  // =============================================

  // TextEditingController faz a ponte entre o código e o
  // TextField: permite ler o que foi digitado (.text) e
  // também alterar o conteúdo do campo por programação.
  final TextEditingController cursoController = TextEditingController();
  final TextEditingController disciplinaController = TextEditingController();

  // =============================================
  // LIBERAR OS CONTROLADORES
  // =============================================

  // dispose() é chamado automaticamente quando a tela é
  // destruída. Liberar os controladores evita vazamento de
  // memória, pois eles continuariam ocupando espaço.
  @override
  void dispose() {
    cursoController.dispose();
    disciplinaController.dispose();

    // super.dispose() deve ser sempre a última linha, para
    // que a classe pai também faça sua própria limpeza.
    super.dispose();
  }

  // =============================================
  // CONSTRUÇÃO DA INTERFACE
  // =============================================

  // build() desenha a tela. É executado na abertura e
  // novamente a cada chamada de setState().
  @override
  Widget build(BuildContext context) {
    // Scaffold é a estrutura básica de uma tela Material:
    // oferece os espaços para barra superior, corpo, menu
    // lateral, botão flutuante, etc.
    return Scaffold(
      // =============================================
      // BARRA SUPERIOR
      // =============================================
      appBar: AppBar(
        // Cor de fundo da barra.
        backgroundColor: Colors.blue,

        // Cor aplicada ao título e aos ícones da barra.
        foregroundColor: Colors.white,

        title: const Text('Agenda de Tarefas'),
      ),

      // =============================================
      // FUNDO
      // =============================================

      // Cor de fundo do Scaffold, atrás de todo o corpo.
      backgroundColor: Colors.amber,

      // =============================================
      // CORPO
      // =============================================

      // Center centraliza o filho na horizontal e vertical.
      body: Center(
        // SingleChildScrollView permite rolar o conteúdo.
        // Sem ele, o teclado do celular reduziria o espaço
        // e o Flutter mostraria o erro de overflow.
        child: SingleChildScrollView(
          // EdgeInsets.all aplica 20 pixels de espaço em
          // todos os lados do conteúdo.
          padding: const EdgeInsets.all(20),

          // Column empilha os widgets na vertical.
          // (Row faria o mesmo na horizontal.)
          child: Column(
            // children recebe a lista de widgets filhos.
            children: [
              // =============================================
              // TÍTULO
              // =============================================
              const Text(
                'Cadastro de Tarefas',

                // TextStyle controla a aparência do texto:
                // tamanho, espessura, cor, fonte, etc.
                style: TextStyle(
                  // Tamanho da fonte em pixels lógicos.
                  fontSize: 30,

                  // Espessura do traço. FontWeight.bold
                  // equivale a w700; a normal é w400.
                  fontWeight: FontWeight.bold,

                  color: Colors.black,
                ),
              ),

              // SizedBox vazio funciona como espaçador
              // entre um widget e outro.
              const SizedBox(height: 20),

              // =============================================
              // CAMPO CURSO
              // =============================================

              // TextField é a caixa de entrada de texto.
              TextField(
                // Liga este campo ao controlador, que
                // guarda e permite ler o texto digitado.
                controller: cursoController,

                // InputDecoration cuida da aparência do
                // campo: rótulo, borda e preenchimento.
                decoration: const InputDecoration(
                  // Texto que aparece dentro do campo e
                  // sobe para a borda ao começar a digitar.
                  labelText: 'Curso',

                  // Desenha uma borda retangular ao redor.
                  border: OutlineInputBorder(),

                  // Ativa o preenchimento de fundo. Sem
                  // "filled: true" a cor abaixo é ignorada.
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // =============================================
              // CAMPO DISCIPLINA
              // =============================================
              TextField(
                controller: disciplinaController,

                decoration: const InputDecoration(
                  labelText: 'Disciplina',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // =============================================
              // CONTADOR
              // =============================================

              // Aqui o Text NÃO pode ser "const", porque o
              // valor de $contador só é conhecido durante a
              // execução. Por isso o const foi movido para
              // o TextStyle, que é fixo.
              Text(
                // O cifrão ($) faz a interpolação: insere o
                // valor da variável dentro da string.
                'Cursos cadastrados: $contador',

                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              // =============================================
              // BOTÃO CADASTRAR
              // =============================================

              // ElevatedButton.icon é a variação do botão
              // que exibe um ícone ao lado do texto.
              ElevatedButton.icon(
                // onPressed recebe a função executada no
                // toque. Se receber null, o botão fica
                // desabilitado (cinza).
                onPressed: () {
                  // =============================================
                  // RECUPERA OS DADOS DIGITADOS
                  // =============================================

                  // .text lê o conteúdo do campo e .trim()
                  // remove os espaços do início e do fim.
                  String curso = cursoController.text.trim();
                  String disciplina = disciplinaController.text.trim();

                  // =============================================
                  // VERIFICA SE OS CAMPOS ESTÃO PREENCHIDOS
                  // =============================================

                  // O operador || (OU) dispara o aviso se
                  // qualquer um dos campos estiver vazio.
                  if (curso.isEmpty || disciplina.isEmpty) {
                    // ScaffoldMessenger exibe a SnackBar, a
                    // mensagem temporária na parte inferior.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha todos os campos!'),

                        // Tempo que a mensagem fica visível.
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // return interrompe a função aqui, para
                    // que o cadastro não seja concluído.
                    return;
                  }

                  // =============================================
                  // INCREMENTA O CONTADOR
                  // =============================================

                  // setState avisa o Flutter que um dado
                  // mudou. Isso dispara o build() de novo e
                  // atualiza a tela. Alterar a variável sem
                  // setState não redesenha nada.
                  // A contagem vem DEPOIS da validação, para
                  // não somar cadastros com campos vazios.
                  setState(() {
                    contador++;
                  });

                  // =============================================
                  // MOSTRA OS DADOS GRAVADOS
                  // =============================================

                  // Esta SnackBar não é "const" porque o
                  // texto usa variáveis.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        // O \n quebra a linha dentro do texto.
                        // Strings coladas uma embaixo da
                        // outra são unidas automaticamente.
                        'Dados gravados!\n'
                        'Cursos cadastrados: $contador\n'
                        'Curso: $curso\n'
                        'Disciplina: $disciplina',
                      ),

                      duration: const Duration(seconds: 4),
                    ),
                  );

                  // =============================================
                  // LIMPA OS CAMPOS
                  // =============================================

                  // .clear() esvazia o campo para o próximo
                  // cadastro. Remova se preferir manter o
                  // texto digitado na tela.
                  cursoController.clear();
                  disciplinaController.clear();
                },

                // Ícone exibido à esquerda do texto.
                icon: const Icon(Icons.save),

                // Em ElevatedButton.icon o texto vai em
                // "label"; no ElevatedButton comum, em
                // "child".
                label: const Text('Cadastrar'),
              ),

              const SizedBox(height: 20),

              // =============================================
              // BOTÃO VOLTAR
              // =============================================
              ElevatedButton(
                onPressed: () {
                  // Navigator controla a pilha de telas.
                  // pop() remove a tela atual e retorna à
                  // anterior. Só funciona se esta tela tiver
                  // sido aberta com Navigator.push().
                  Navigator.pop(context);
                },
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}