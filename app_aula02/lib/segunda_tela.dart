// =============================================
// IMPORTAÇÕES
// =============================================

// Biblioteca do Flutter com os widgets do Material Design
// (Scaffold, AppBar, Text, ElevatedButton, etc.).
import 'package:flutter/material.dart';

// =============================================
// SEGUNDA TELA
// =============================================

// StatelessWidget é usado porque a tela não muda durante a
// execução: nada aqui é digitado, contado ou atualizado.
// Um StatefulWidget só seria necessário se algum dado
// precisasse mudar e redesenhar a interface.
class SegundaTela extends StatelessWidget {
  // Construtor. O "const" permite que o Flutter reaproveite
  // esta instância, e "super.key" repassa a chave de
  // identificação do widget para a classe pai.
  const SegundaTela({super.key});

  // build() descreve o que este widget desenha na tela.
  @override
  Widget build(BuildContext context) {
    // Scaffold é a estrutura básica de uma tela Material:
    // oferece os espaços para barra superior, corpo, menu
    // lateral, botão flutuante, etc.
    return Scaffold(
      // =============================================
      // BARRA SUPERIOR
      // =============================================

      // Como esta tela foi aberta com Navigator.push(), o
      // Flutter adiciona sozinho a seta de voltar à
      // esquerda do título.
      appBar: AppBar(title: const Text('Segunda Tela')),

      // =============================================
      // CORPO
      // =============================================

      // Center centraliza o filho na horizontal e vertical.
      body: Center(
        // Column empilha os widgets na vertical.
        // (Row faria o mesmo na horizontal.)
        child: Column(
          // Por padrão a Column ocupa toda a altura e alinha
          // os filhos no topo. Com "center" eles ficam
          // agrupados no meio do eixo vertical.
          mainAxisAlignment: MainAxisAlignment.center,

          // children recebe a lista de widgets filhos.
          children: [
            // =============================================
            // MENSAGEM
            // =============================================
            const Text(
              'Você está na segunda tela!',

              // TextStyle controla a aparência do texto:
              // tamanho, cor, espessura, fonte, etc.
              style: TextStyle(
                // Tamanho da fonte em pixels lógicos.
                fontSize: 24,
              ),
            ),

            // SizedBox vazio funciona como espaçador entre
            // um widget e outro.
            const SizedBox(height: 20),

            // =============================================
            // BOTÃO VOLTAR
            // =============================================
            ElevatedButton(
              // onPressed recebe a função executada no
              // toque. Se receber null, o botão fica
              // desabilitado (cinza).
              onPressed: () {
                // Navigator controla a pilha de telas.
                // pop() remove a tela atual e retorna à
                // anterior, que continuou na memória.
                // Faz o mesmo que a seta da AppBar.
                Navigator.pop(context);
              },

              // Em ElevatedButton o texto vai em "child";
              // na variação .icon, em "label".
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}