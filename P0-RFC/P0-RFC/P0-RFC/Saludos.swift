//
//  Saludos.swift
//  P0-RFC
//
//  Created by Rodrigo on 9/24/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

class Saludos{
    
    let entradaYSalida = EntradaYSalida()
    var formatoFecha : DateFormatter = {
        let formato = DateFormatter()
        formato.dateStyle = .long
        return formato
    }()
    
    func saluda(){
        if CommandLine.argc > 1 {
            entradaYSalida.imprimeUso()
        } else {
            entradaYSalida.imprimeAConsola("Este programa te preguntara tu nombre y apellido y te saludara dejandote saber la fecha del saludo")
            entradaYSalida.imprimeAConsola("Cual es tu nombre?")
            let nombre = entradaYSalida.obtieneInput()
            entradaYSalida.imprimeAConsola("Cual es tu apellido?")
            let apellido = entradaYSalida.obtieneInput()
            let fecha = Date()
            entradaYSalida.imprimeAConsola("Hola \(nombre) \(apellido),  hoy es \(formatoFecha.string(from: fecha))")
        }
    }
        
}//class Saludos
