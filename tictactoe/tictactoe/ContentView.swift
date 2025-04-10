// Importamos SwiftUI, que es como una caja de herramientas
// para hacer pantallas bonitas y fáciles de usar.
import SwiftUI

// Aquí decimos que vamos a construir la pantalla principal del juego.
struct ContentView: View
{
    // Creamos un objeto especial para guardar cómo va el juego.
    @StateObject var gameState = GameState()
    
    // Aquí empieza el diseño de la pantalla.
    var body: some View
    {
        // Tamaño del borde entre los cuadritos del juego.
        let borderSize = CGFloat(5)
        
        // Mostramos de quién es el turno (X o O).
        Text(gameState.turnText())
            .font(.title) // Hacemos el texto grande.
            .bold()       // Y en negritas para que se vea fuerte.
            .padding()    // Ponemos un poquito de espacio alrededor.
        
        Spacer() // Un espacio para separar las cosas.

        // Mostramos cuántos puntos lleva el jugador de las "X".
        Text(String(format: "Crosses: %d", gameState.crossesScore))
            .font(.title)
            .bold()
            .padding()
        
        // Ahora dibujamos el tablero (la cuadrícula 3x3).
        VStack(spacing: borderSize)
        {
            // Repetimos 3 veces, una por cada fila del tablero.
            ForEach(0...2, id: \.self)
            { row in
                // Cada fila tiene 3 columnas.
                HStack(spacing: borderSize)
                {
                    ForEach(0...2, id: \.self)
                    { column in
                        
                        // Buscamos qué hay en esa casilla (vacía, X o O).
                        let cell = gameState.board[row][column]
                        
                        // Dibujamos lo que hay en la casilla.
                        Text(cell.displayTile())
                            .font(.system(size: 60)) // Hacemos los símbolos grandotes.
                            .foregroundColor(cell.tileColor()) // Le ponemos color.
                            .bold() // También en negritas.
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Que el cuadrito se estire bien.
                            .aspectRatio(1, contentMode: .fit) // Que sea cuadrado.
                            .background(Color.white) // Fondo blanco para cada casilla.
                            .onTapGesture {
                                // Cuando el niño toque un cuadrito, ponemos una X o una O.
                                gameState.placeTile(row, column)
                            }
                    }
                }
            }
        }
        .background(Color.black) // Fondo negro para todo el tablero.
        .padding() // Un poquito de espacio alrededor.
        .alert(isPresented: $gameState.showAlert)
        {
            // Si alguien gana o hay empate, mostramos un aviso.
            Alert(
                title: Text(gameState.alertMessage), // Mensaje como "¡Ganaste!".
                dismissButton: .default(Text("Okay"))
                {
                    // Cuando presionen "Okay", el juego se reinicia.
                    gameState.resetBoard()
                }
            )
        }
        
        // Mostramos cuántos puntos lleva el jugador de los "O".
        Text(String(format: "Noughts: %d", gameState.noughtsScore))
            .font(.title)
            .bold()
            .padding()
        
        Spacer() // Otro espacio para separar cosas.
    }
}

// Esta parte es para que podamos ver una "vista previa" del juego
// mientras estamos trabajando en él.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
