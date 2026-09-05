// =============================================
// IMPORTAÇÕES
// =============================================

// Biblioteca do Flutter com os widgets do Material Design
// (Scaffold, AppBar, Text, ElevatedButton, etc.).
import 'package:flutter/material.dart';

// =============================================
// TELA SOBRE
// =============================================

// Esta tela recebe dados de fora, digitados na tela
// principal. Por isso declara campos próprios.
class Sobre extends StatefulWidget {
  // "final" indica que o valor é definido uma única vez, na
  // criação do widget, e não muda depois.
  final String nome;
  final String curso;
  final String disciplina;

  // Construtor. Os parâmetros entre chaves {} são nomeados:
  // na chamada é preciso escrever Sobre(nome: ..., curso: ...).
  const Sobre({
    // Repassa a chave de identificação para a classe pai.
    super.key,

    // "required" torna o parâmetro obrigatório: sem ele o
    // código nem compila. E "this.nome" já grava o valor
    // recebido direto no campo da classe.
    required this.nome,
    required this.curso,
    required this.disciplina,
  });

  // Método obrigatório do StatefulWidget: cria o objeto de
  // estado que desenha a interface.
  @override
  State<Sobre> createState() => _SobreState();
}

// =============================================
// ESTADO DA TELA
// =============================================

// O underline (_) no início do nome torna a classe privada,
// visível apenas dentro deste arquivo.
class _SobreState extends State<Sobre> {
  // build() desenha a tela.
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
        // Inclui a seta de voltar, que o Flutter desenha
        // sozinho por esta tela ter vindo de um push().
        foregroundColor: Colors.white,

        title: const Text('Sobre'),
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
            // projeto, declarada no pubspec.yaml. O caminho
            // precisa ser idêntico ao usado nas outras telas.
            image: AssetImage('assets/imagens/fundo.jpg'),

            // BoxFit.cover amplia a imagem até cobrir todo o
            // espaço, cortando o excesso sem distorcer.
            fit: BoxFit.cover,
          ),
        ),

        // Center centraliza o filho na horizontal e vertical.
        child: Center(
          // SingleChildScrollView permite rolar o conteúdo,
          // evitando o erro de overflow em telas pequenas.
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
                // IMAGEM
                // =============================================

                // ClipRRect recorta o filho com cantos
                // arredondados. Sem ele a foto ficaria
                // quadrada, pois Image não tem borda própria.
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),

                  child: Image.asset(
                    'assets/imagens/foto.jpg',
                    width: 200,
                    height: 200,

                    // Preenche os 200x200 sem distorcer,
                    // cortando o que sobrar.
                    fit: BoxFit.cover,
                  ),
                ),

                // SizedBox vazio funciona como espaçador
                // entre um widget e outro.
                const SizedBox(height: 30),

                // =============================================
                // NOME DO ALUNO
                // =============================================

                // Dentro da classe de estado, os dados
                // recebidos pelo construtor são acessados
                // pelo prefixo "widget.".
                // Aqui o Text NÃO pode ser "const", porque o
                // valor só é conhecido durante a execução.
                // Por isso o const foi para o TextStyle.
                Text(
                  // As chaves ${} fazem a interpolação:
                  // inserem o valor dentro da string.
                  'Aluno: ${widget.nome}',

                  // TextStyle controla a aparência do texto.
                  style: const TextStyle(
                    // Tamanho da fonte em pixels lógicos.
                    fontSize: 20,

                    // Espessura do traço. FontWeight.bold
                    // equivale a w700; a normal é w400.
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // =============================================
                // CURSO
                // =============================================
                Text(
                  'Curso: ${widget.curso}',
                  style: const TextStyle(fontSize: 18),

                  // Centraliza o texto quando ele ocupa mais
                  // de uma linha.
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // =============================================
                // DISCIPLINA
                // =============================================
                Text(
                  'Disciplina: ${widget.disciplina}',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // =============================================
                // BOTÃO VOLTAR
                // =============================================

                // ElevatedButton.icon é a variação do botão
                // que exibe um ícone ao lado do texto.
                ElevatedButton.icon(
                  // onPressed recebe a função executada no
                  // toque. Se receber null, o botão fica
                  // desabilitado (cinza).
                  onPressed: () {
                    // Navigator controla a pilha de telas.
                    // pop() remove a tela atual e retorna à
                    // anterior. Só funciona se esta tela
                    // tiver sido aberta com Navigator.push().
                    Navigator.pop(context);
                  },

                  // Ícone exibido à esquerda do texto.
                  icon: const Icon(Icons.arrow_back),

                  // Em ElevatedButton.icon o texto vai em
                  // "label"; no ElevatedButton comum, em
                  // "child".
                  label: const Text('VOLTAR'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}