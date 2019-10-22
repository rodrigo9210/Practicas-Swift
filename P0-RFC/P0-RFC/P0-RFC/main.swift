//
//  main.swift
//  P0-RFC
//
//  Created by Rodrigo on 9/24/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

var tipo : String = ""
var respuesta : Bool = false
var continua : Bool = false
var persona : Persona

ayuda()

repeat {
    while !respuesta {
        (tipo, respuesta) = menuDeInicio()
    }
    
    if tipo == "1"{
        var persona = PersonaFisica(fecha: DateComponents(calendar: .current, year: 1900, month: 2, day:30), siglasFecha: "", siglasNombre: "", claveDiferenciadora: "", digitoVerificador: "", nombreParaGenerarClave: "", RFC: "", nombre: "", apellidoPaterno: "", apellidoMaterno: "")
        
        persona.pideDatosPersonaFisica()
        persona.imprimeDatosPersonales()
        persona.generaSiglasNombre()
        persona.generaSiglasFecha()
        persona.generaClaveDiferenciadora()
        persona.generaDigitoVerificador()
        persona.imprimeYGeneraRFC()
        
        
    } else if tipo == "2" {
        var persona = PersonaMoral(fecha: DateComponents(calendar: .current, year: 1900, month: 2, day:30), siglasFecha: "", siglasNombre: "", claveDiferenciadora: "", digitoVerificador: "", nombreParaGenerarClave: "", RFC: "", nombre: [])
        
        persona.pideDatosPersonaMoral()
        persona.generaSiglasNombre()
        persona.generaSiglasFecha()
        persona.generaClaveDiferenciadora()
        persona.generaDigitoVerificador()
        persona.imprimeYGeneraRFC()
    }
    
    respuesta = false
    continua = menuDeSalida()
    
} while continua
