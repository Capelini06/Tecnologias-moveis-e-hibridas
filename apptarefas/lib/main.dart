// =============================================
// IMPORTAÇÕES
// =============================================

// Biblioteca do Flutter com os widgets do Material Design
// (Scaffold, AppBar, TextField, ElevatedButton, etc.).
import 'package:flutter/material.dart';

// Importa as outras telas do projeto para que possam ser
// usadas na navegação mais abaixo.
import 'sobre.dart';
import 'tarefas.dart';

// =============================================
// PONTO DE ENTRADA DO APLICATIVO
// =============================================

// main() é a primeira função executada quando o app inicia.
void main() {
  // runApp() recebe o widget raiz e o coloca na tela.
  runApp(
    // MaterialApp configura o app inteiro: tema, rotas e navegação.
    const MaterialApp(
      // Remove a faixa vermelha "DEBUG" do canto da tela.
      debugShowCheckedModeBanner: false,

      // home define qual tela é exibida ao abrir o app.
      home: MyHomePage(),
    ),
  );
}

// =============================================
// TELA PRINCIPAL
// =============================================

// StatefulWidget é usado quando a tela precisa mudar durante
// a execução (aqui, o contador e o texto dos campos).
// Um StatelessWidget serviria apenas para telas fixas.
class MyHomePage extends StatefulWidget {
  // Construtor. O "const" permite que o Flutter reaproveite
  // esta instância, e "super.key" repassa a chave de
  // identificação do widget para a classe pai.
  const MyHomePage({super.key});

  // Método obrigatório do StatefulWidget: cria o objeto de
  // estado que guarda os dados e desenha a interface.
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// =============================================
// ESTADO DA TELA
// =============================================

// O underline (_) no início do nome torna a classe privada,
// visível apenas dentro deste arquivo.
class _MyHomePageState extends State<MyHomePage> {
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
  final TextEditingController nomeController = TextEditingController();
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
    nomeController.dispose();
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

      // Cor de fundo do Scaffold. Fica escondida atrás da
      // imagem, mas aparece enquanto ela carrega.
      backgroundColor: Colors.amber,

      // =============================================
      // CORPO
      // =============================================

      // Container é um widget genérico usado para aplicar
      // decoração, tamanho, margem e espaçamento interno.
      body: Container(
        // double.infinity faz o Container ocupar toda a
        // largura e altura disponíveis. Sem isso ele se
        // ajustaria ao tamanho do conteúdo e a imagem de
        // fundo apareceria apenas em parte da tela.
        width: double.infinity,
        height: double.infinity,

        // BoxDecoration define a aparência do Container:
        // cor, borda, sombra ou, neste caso, imagem.
        decoration: const BoxDecoration(
          image: DecorationImage(
            // AssetImage carrega uma imagem da pasta do
            // projeto, declarada no pubspec.yaml.
            image: AssetImage('assets/imagens/fundo.jpg'),

            // BoxFit.cover amplia a imagem até cobrir todo o
            // espaço, cortando o excesso sem distorcer.
            fit: BoxFit.cover,
          ),
        ),

        // Center centraliza o filho na horizontal e vertical.
        child: Center(
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
                // CAMPO NOME
                // =============================================

                // TextField é a caixa de entrada de texto.
                TextField(
                  // Liga este campo ao controlador, que
                  // guarda e permite ler o texto digitado.
                  controller: nomeController,

                  // InputDecoration cuida da aparência do
                  // campo: rótulo, borda e preenchimento.
                  decoration: const InputDecoration(
                    // Texto que aparece dentro do campo e
                    // sobe para a borda ao começar a digitar.
                    labelText: 'Nome',

                    // Desenha uma borda retangular ao redor.
                    border: OutlineInputBorder(),

                    // Ativa o preenchimento de fundo. Sem
                    // "filled: true" a cor abaixo é ignorada.
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                // SizedBox vazio funciona como espaçador
                // entre um widget e outro.
                const SizedBox(height: 20),

                // =============================================
                // CAMPO CURSO
                // =============================================
                TextField(
                  controller: cursoController,

                  decoration: const InputDecoration(
                    labelText: 'Curso',
                    border: OutlineInputBorder(),
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
                // BOTÃO ADICIONAR
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
                    String nome = nomeController.text.trim();

                    // =============================================
                    // VERIFICA SE O CAMPO ESTÁ PREENCHIDO
                    // =============================================
                    if (nome.isEmpty) {
                      // ScaffoldMessenger exibe a SnackBar, a
                      // mensagem temporária na parte inferior.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Insira o seu nome!'),

                          // Tempo que a mensagem fica visível.
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // return interrompe a função aqui, para
                      // que o contador não seja incrementado
                      // com o campo vazio.
                      return;
                    }

                    // setState avisa o Flutter que um dado
                    // mudou. Isso dispara o build() de novo e
                    // atualiza a tela. Alterar a variável sem
                    // setState não redesenha nada.
                    setState(() {
                      contador++;
                    });
                  },

                  // Ícone exibido à esquerda do texto.
                  icon: const Icon(Icons.add),

                  // Em ElevatedButton.icon o texto vai em
                  // "label"; no ElevatedButton comum, em
                  // "child".
                  label: const Text('ADICIONAR'),
                ),

                const SizedBox(height: 20),

                // =============================================
                // BOTÃO PARA A TELA DE TAREFAS
                // =============================================
                ElevatedButton(
                  onPressed: () {
                    // Navigator controla a pilha de telas.
                    // push() empilha uma tela nova por cima
                    // da atual, criando o botão de voltar.
                    Navigator.push(
                      context,

                      // MaterialPageRoute define a rota e a
                      // animação de transição padrão.
                      MaterialPageRoute(
                        // builder é a função que constrói a
                        // tela de destino.
                        builder: (context) => const Tarefas(),
                      ),
                    );
                  },
                  child: const Text('TAREFAS'),
                ),

                const SizedBox(height: 20),

                // =============================================
                // BOTÃO PARA A TELA SOBRE
                // =============================================
                ElevatedButton(
                  onPressed: () {
                    // =============================================
                    // VALIDA ANTES DE NAVEGAR
                    // =============================================

                    // O operador || (OU) faz a mensagem
                    // aparecer se QUALQUER campo estiver
                    // vazio. Com && (E) ela só apareceria se
                    // todos os três estivessem vazios.
                    if (nomeController.text.trim().isEmpty ||
                        cursoController.text.trim().isEmpty ||
                        disciplinaController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Insira todos os campos!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // =============================================
                    // ENVIA OS DADOS PARA A OUTRA TELA
                    // =============================================
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // Os valores digitados são passados
                        // pelo construtor da tela Sobre.
                        // Aqui não cabe "const", pois o texto
                        // só é conhecido durante a execução.
                        builder: (context) => Sobre(
                          nome: nomeController.text.trim(),
                          curso: cursoController.text.trim(),
                          disciplina: disciplinaController.text.trim(),
                        ),
                      ),
                    );
                  },
                  child: const Text('SOBRE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}