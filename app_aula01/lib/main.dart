// =============================================
// IMPORTAÇÕES
// =============================================

// Biblioteca do Flutter com os widgets do Material Design
// (Scaffold, AppBar, TextField, ElevatedButton, etc.).
import 'package:flutter/material.dart';

// =============================================
// PONTO DE ENTRADA DO APLICATIVO
// =============================================

// main() é a primeira função executada quando o app inicia.
void main() {
  // runApp() recebe o widget raiz e o coloca na tela.
  runApp(const MyApp());
}

// =============================================
// WIDGET RAIZ
// =============================================

// StatelessWidget é usado quando o widget não muda durante
// a execução. Aqui ele apenas configura o app, então não
// precisa guardar nenhum estado.
class MyApp extends StatelessWidget {
  // Construtor. O "const" permite que o Flutter reaproveite
  // esta instância, e "super.key" repassa a chave de
  // identificação do widget para a classe pai.
  const MyApp({super.key});

  // build() descreve o que este widget desenha na tela.
  @override
  Widget build(BuildContext context) {
    // MaterialApp configura o app inteiro: tema, rotas,
    // idioma e navegação entre telas.
    // Como todos os valores abaixo são fixos, o próprio
    // MaterialApp pode ser "const".
    return const MaterialApp(
      // Remove a faixa vermelha "DEBUG" do canto da tela.
      debugShowCheckedModeBanner: false,

      // home define qual tela é exibida ao abrir o app.
      home: HomeScreen(),
    );
  }
}

// =============================================
// TELA PRINCIPAL
// =============================================

// StatefulWidget é usado porque a tela muda durante a
// execução: o contador aumenta a cada clique.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // Método obrigatório do StatefulWidget: cria o objeto de
  // estado que guarda os dados e desenha a interface.
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// =============================================
// ESTADO DA TELA
// =============================================

// O underline (_) no início do nome torna a classe privada,
// visível apenas dentro deste arquivo.
class _HomeScreenState extends State<HomeScreen> {
  // =============================================
  // CONTADOR DE CLIQUES
  // =============================================

  // Variável de estado: sobrevive aos redesenhos da tela.
  int contador = 0;

  // =============================================
  // CONTROLADOR DO CAMPO
  // =============================================

  // TextEditingController faz a ponte entre o código e o
  // TextField: permite ler o que foi digitado (.text) e
  // também alterar o conteúdo do campo por programação.
  final TextEditingController nomeController = TextEditingController();

  // =============================================
  // LIBERAR O CONTROLADOR
  // =============================================

  // dispose() é chamado automaticamente quando a tela é
  // destruída. Liberar o controlador evita vazamento de
  // memória, pois ele continuaria ocupando espaço.
  @override
  void dispose() {
    nomeController.dispose();

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

        title: const Text("Olá, meu nome é Guilherme Capelini"),
      ),

      // =============================================
      // FUNDO
      // =============================================

      // Color.fromARGB recebe, nesta ordem: opacidade
      // (255 = totalmente opaco), vermelho, verde e azul.
      // Resulta num vermelho escuro.
      backgroundColor: const Color.fromARGB(255, 167, 5, 5),

      // =============================================
      // CORPO
      // =============================================

      // SingleChildScrollView permite rolar o conteúdo.
      // Sem ele, o teclado do celular reduziria o espaço
      // e o Flutter mostraria o erro de overflow.
      body: SingleChildScrollView(
        // EdgeInsets.all aplica 16 pixels de espaço em
        // todos os lados do conteúdo.
        padding: const EdgeInsets.all(16.0),

        // Center centraliza o filho na horizontal.
        child: Center(
          // Column empilha os widgets na vertical.
          // (Row faria o mesmo na horizontal.)
          child: Column(
            // Agrupa os filhos no meio do eixo vertical.
            // Dentro de um SingleChildScrollView a Column
            // só ocupa a altura do conteúdo, então este
            // alinhamento acaba tendo pouco efeito visível.
            mainAxisAlignment: MainAxisAlignment.center,

            // children recebe a lista de widgets filhos.
            children: [
              // =============================================
              // TEXTO DE APRESENTAÇÃO
              // =============================================

              // Padding afasta o filho das bordas. Aqui o
              // "symmetric" aplica 16 pixels só na horizontal
              // (esquerda e direita), somando ao padding que
              // já veio do SingleChildScrollView.
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),

                child: Text(
                  'Meu nome é Guilherme Capelini, curso Análise e '
                  'Desenvolvimento de Sistemas e tenho como objetivo '
                  'conseguir um emprego estável na área.',

                  // Centraliza o texto quando ele ocupa mais
                  // de uma linha.
                  textAlign: TextAlign.center,

                  // TextStyle controla a aparência do texto.
                  style: TextStyle(
                    // Branco para contrastar com o fundo.
                    color: Colors.white,

                    // Tamanho da fonte em pixels lógicos.
                    fontSize: 20,

                    // Espessura do traço. FontWeight.bold
                    // equivale a w700; a normal é w400.
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // SizedBox vazio funciona como espaçador
              // entre um widget e outro.
              const SizedBox(height: 20),

              // =============================================
              // IMAGEM
              // =============================================

              // Image.network baixa a imagem da internet.
              // Diferente de Image.asset, ela não vai junto
              // com o app: exige conexão e o app precisa da
              // permissão de internet para funcionar.
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvtfEEszt2YR-LhuGqYzal67dcfjGDYfvLMXe0sR4PpA&s=10',
                width: 300,

                // errorBuilder desenha algo no lugar quando
                // o download falha. Sem ele, a tela mostraria
                // um ícone de erro cinza.
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.white,
                  );
                },
              ),

              const SizedBox(height: 20),

              // =============================================
              // CAMPO NOME
              // =============================================

              // TextField é a caixa de entrada de texto.
              TextField(
                // Liga este campo ao controlador, que guarda
                // e permite ler o texto digitado.
                controller: nomeController,

                // InputDecoration cuida da aparência do
                // campo: rótulo, dica, borda e preenchimento.
                decoration: const InputDecoration(
                  // Texto que aparece dentro do campo e sobe
                  // para a borda ao começar a digitar.
                  labelText: 'Digite seu nome:',

                  // Dica exibida no campo vazio. Some assim
                  // que o usuário começa a escrever.
                  hintText: 'Exemplo: Daniel',

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
              // CONTADOR
              // =============================================

              // Aqui o Text NÃO pode ser "const", porque o
              // valor de $contador só é conhecido durante a
              // execução. Por isso o const foi movido para
              // o TextStyle, que é fixo.
              Text(
                // O cifrão ($) faz a interpolação: insere o
                // valor da variável dentro da string.
                'Cliques: $contador',

                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // =============================================
              // BOTÃO
              // =============================================
              ElevatedButton(
                // onPressed recebe a função executada no
                // toque. Se receber null, o botão fica
                // desabilitado (cinza).
                onPressed: () {
                  // setState avisa o Flutter que um dado
                  // mudou. Isso dispara o build() de novo e
                  // atualiza a tela. Alterar a variável sem
                  // setState não redesenha nada.
                  setState(() {
                    contador++;
                  });

                  // =============================================
                  // RECUPERA O DADO DIGITADO
                  // =============================================

                  // .text lê o conteúdo do campo e .trim()
                  // remove os espaços do início e do fim.
                  String nomeDigitado = nomeController.text.trim();

                  // Se o usuário não digitou nada, usa um
                  // valor padrão em vez de exibir um aviso.
                  if (nomeDigitado.isEmpty) {
                    nomeDigitado = 'visitante';
                  }

                  // =============================================
                  // MOSTRA A MENSAGEM
                  // =============================================

                  // ScaffoldMessenger exibe a SnackBar, a
                  // mensagem temporária na parte inferior.
                  // Ela não é "const" porque usa variáveis.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Olá, $nomeDigitado! Você clicou $contador vez(es).',
                      ),

                      // Tempo que a mensagem fica visível.
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },

                // Em ElevatedButton o texto vai em "child";
                // na variação .icon, em "label".
                child: const Text('Clique aqui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}