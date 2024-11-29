import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String? winner;

  void _handleTap(int index) {
    if (board[index] == '' && winner == null) {
      setState(() {
        board[index] = currentPlayer;
        if (_checkWinner()) {
          winner = currentPlayer;
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner() {
    const winPatterns = [
      [0, 1, 2], // row 1
      [3, 4, 5], // row 2
      [6, 7, 8], // row 3
      [0, 3, 6], // col 1
      [1, 4, 7], // col 2
      [2, 5, 8], // col 3
      [0, 4, 8], // diagonal
      [2, 4, 6], // diagonal
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] != '' &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        return true;
      }
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 144, 239, 242),
                    border: Border.all(
                        color: const Color.fromARGB(255, 118, 204, 238)),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          if (winner != null)
            Text(
              '$winner Kazandı!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          else if (!board.contains(''))
            const Text(
              'Berabere!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Yeniden Başlat'),
          ),
        ],
      ),
    );
  }
}
