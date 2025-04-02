import Foundation
import SwiftUI

struct celdas
{
    var casillas: Casillas
    
    func mostrarCasillas() -> String
    
    {
        switch casillas {
        case Casillas.cruz:
            return "x"
            
        case Casillas.circulo:
            return "O"
            
        default:
            return " "
            
            
        }
    }
    
    
    
    func colorcasilla() -> Color
    
    {
        switch casillas {
        case Casillas.cruz:
            return Color.black
            
        case Casillas.circulo:
            return Color.red
            
        default:
            return Color.black
            
            
        }
    }
    
    
    
}


enum Casillas
{
    case cruz
    case circulo
    case vacio
}
