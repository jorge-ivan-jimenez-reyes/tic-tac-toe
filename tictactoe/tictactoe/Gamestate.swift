// Importamos Foundation, que trae funciones básicas de Swift.
import Foundation
// Esta clase maneja toda la "lógica" del juego.
class GameState: ObservableObject
{
    // El tablero: una cuadrícula de casillas (3x3).
    @Published var board = [[Cell]]()
    
    // Quién está jugando: X o O (comienza X).
    @Published var turn = Tile.Cross
    
    // Cuántos puntos lleva el jugador O.
    @Published var noughtsScore = 0
    
    // Cuántos puntos lleva el jugador X.
    @Published var crossesScore = 0
    
    // ¿Debemos mostrar un aviso? (¡Ganaste! o ¡Empate!).
    @Published var showAlert = false
    
    // Qué mensaje mostrar en el aviso.
    @Published var alertMessage = "Draw" // Empieza en "Empate".
    
    // Cuando se crea un nuevo juego, el tablero se limpia.
    init()
    {
        resetBoard()
    }
    
    // Nos dice de quién es el turno para mostrarlo en pantalla.
    func turnText() -> String
    {
        return turn == Tile.Cross ? "Turn: X" : "Turn: O"
    }
   
    
    

    
    // Esta función se llama cuando el niño toca una casilla.
    func placeTile(_ row: Int, _ column: Int)
    {
        // Si la casilla ya tiene una X o una O, no hacemos nada.
        if(board[row][column].tile != Tile.Empty)
        {
            return
        }
        
        // Ponemos una X o una O dependiendo de quién le toca.
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        // Revisamos si alguien ganó.
        if(checkForVictory())
        {
            // Si ganó, subimos el puntaje al jugador que ganó.
            if(turn == Tile.Cross)
            {
                crossesScore += 1
            }
            else
            {
                noughtsScore += 1
            }
            
            // Mostramos un mensaje que diga quién ganó.
            let winner = turn == Tile.Cross ? "Crosses" : "Noughts"
            alertMessage = winner + " Win!"
            showAlert = true // Decimos que hay que mostrar el aviso.
        }
        else
        {
            // Si nadie ganó, cambiamos el turno al otro jugador.
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        
        // Si el tablero se llenó y nadie ganó, es empate.
        if(checkForDraw())
        {
            alertMessage = "Draw"
            showAlert = true
        }
    }
    
    // Revisamos si ya no quedan casillas vacías.
    func checkForDraw() -> Bool
    {
        for row in board
        {
            for cell in row
            {
                if cell.tile == Tile.Empty
                {
                    // Si encontramos una casilla vacía, no es empate todavía.
                    return false
                }
            }
        }
        
        // Si no encontramos casillas vacías, es empate.
        return true
    }
    
    // Revisamos si alguien ganó.
    func checkForVictory() -> Bool
    {
        // Ganar en columna (vertical).
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0)
        {
            return true
        }
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2)
        {
            return true
        }
        
        // Ganar en fila (horizontal).
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2)
        {
            return true
        }
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2)
        {
            return true
        }
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2)
        {
            return true
        }
        
        // Ganar en diagonal.
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0)
        {
            return true
        }
        
        // Si no encontró 3 iguales, no ganó nadie aún.
        return false
    }
    
    // Esta función nos ayuda a revisar si en una casilla
    // está el símbolo del jugador que tiene el turno.
    func isTurnTile(_ row: Int, _ column: Int) -> Bool
    {
        return board[row][column].tile == turn
    }
    
    // Esta función borra todo el tablero y lo reinicia.
    func resetBoard()
    {
        var newBoard = [[Cell]]() // Creamos un tablero vacío.
        
        // Hacemos 3 filas...
        for _ in 0...2
        {
            var row = [Cell]() // Nueva fila vacía.
            
            // ...y 3 columnas en cada fila.
            for _ in 0...2
            {
                row.append(Cell(tile: Tile.Empty)) // Cada casilla empieza vacía.
            }
            newBoard.append(row) // Agregamos la fila al tablero.
        }
        board = newBoard // Actualizamos el tablero.
    }
    
    
    
}


