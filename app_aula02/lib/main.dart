// =============================================
// IMPORTAÇÕES
// =============================================

// Biblioteca do Flutter com os widgets do Material Design
// (Scaffold, AppBar, Text, ElevatedButton, etc.).
import 'package:flutter/material.dart';

// Importa a outra tela do projeto para que ela possa ser
// usada na navegação mais abaixo.
import 'segunda_tela.dart';

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
    return MaterialApp(
      // Remove a faixa vermelha "DEBUG" do canto da tela.
      debugShowCheckedModeBanner: false,

      // home define qual tela é exibida ao abrir o app.
      home: const MainPage(),
    );
  }
}

// =============================================
// PRIMEIRA TELA
// =============================================

// Também é StatelessWidget: a tela só exibe um título e um
// botão de navegação, sem dados que mudem com o tempo.
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold é a estrutura básica de uma tela Material:
    // oferece os espaços para barra superior, corpo, menu
    // lateral, botão flutuante, etc.
    return Scaffold(
      // =============================================
      // BARRA SUPERIOR
      // =============================================

      // Sem backgroundColor definido, a AppBar usa a cor
      // padrão do tema do MaterialApp.
      appBar: AppBar(title: const Text('Meu Aplicativo')),

      // =============================================
      // CORPO
      // =============================================

      // Container é um widget genérico usado para aplicar
      // decoração, tamanho, margem e espaçamento interno.
      body: Container(
        // BoxDecoration define a aparência do Container:
        // cor, borda, sombra ou, neste caso, imagem.
        decoration: const BoxDecoration(
          image: DecorationImage(
            // AssetImage carrega uma imagem da pasta do
            // projeto, declarada no pubspec.yaml.
            image: AssetImage('assets/imagens/fundo.jpg'),

            // BoxFit.cover amplia a imagem até cobrir todo o
            // espaço, cortando o excesso sem distorcer.
            // Outras opções: contain (mostra tudo, pode
            // sobrar espaço) e fill (estica e distorce).
            fit: BoxFit.cover,
          ),
        ),

        // Center centraliza o filho na horizontal e vertical.
        // Ele também se expande para ocupar todo o espaço
        // disponível, o que garante que a imagem de fundo do
        // Container cubra a tela inteira.
        child: Center(
          // Column empilha os widgets na vertical.
          // (Row faria o mesmo na horizontal.)
          child: Column(
            // Por padrão a Column ocupa toda a altura e
            // alinha os filhos no topo. Com "center" eles
            // ficam agrupados no meio do eixo vertical.
            mainAxisAlignment: MainAxisAlignment.center,

            // children recebe a lista de widgets filhos.
            children: [
              // =============================================
              // TÍTULO
              // =============================================
              const Text(
                'Meu Aplicativo',

                // TextStyle controla a aparência do texto:
                // cor, tamanho, espessura, fonte, etc.
                style: TextStyle(
                  // Branco para contrastar com a imagem.
                  color: Colors.white,

                  // Tamanho da fonte em pixels lógicos.
                  fontSize: 30,

                  // Espessura do traço. FontWeight.bold
                  // equivale a w700; a normal é w400.
                  fontWeight: FontWeight.bold,
                ),
              ),

              // SizedBox vazio funciona como espaçador
              // entre um widget e outro.
              const SizedBox(height: 20),

              // =============================================
              // BOTÃO DE NAVEGAÇÃO
              // =============================================
              ElevatedButton(
                // onPressed recebe a função executada no
                // toque. Se receber null, o botão fica
                // desabilitado (cinza).
                onPressed: () {
                  // Navigator controla a pilha de telas.
                  // push() empilha uma tela nova por cima da
                  // atual; a anterior continua na memória e
                  // o Flutter cria a seta de voltar sozinho.
                  Navigator.push(
                    // O context informa ao Navigator em que
                    // ponto da árvore de widgets ele está.
                    context,

                    // MaterialPageRoute define a rota e a
                    // animação de transição padrão da
                    // plataforma.
                    MaterialPageRoute(
                      // builder é a função que constrói a
                      // tela de destino.
                      builder: (context) => const SegundaTela(),
                    ),
                  );
                },

                // Em ElevatedButton o texto vai em "child";
                // na variação .icon, em "label".
                child: const Text('Ir para a segunda tela'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}