import Foundation
import SwiftUI

struct celdas
{
    var tile:Tile
    //funcion que devuelve un simmbolo y se muestra
    func showtile() -> String{
        switch(tile)
        {
        case Tile.Nought:
            return "0"
        default:
            return ""
        
        }
        
        
    }
    
    
    
    
}
