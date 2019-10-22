//
//  EntradaYSalida.swift
//  P0-RFC
//
//  Created by Rodrigo on 9/24/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

class EntradaYSalida {
    
    var mensajeDeBienvenida = "Programa para calcular tu RFC.\nSelecciona una opción."
    var menuInicio = "1. Persona Física\n2. Persona Moral\n3. Salir\n4. Ayuda"
    var menuSalida = "Ingresa 1 para continuar o cualquier otra tecla para salir"
    var meses = "\t1. Enero\n\t2. Febrero\n\t3. Marzo\n\t4. Abril\n\t5. Mayo\n\t6. Junio\n\t7. Julio\n\t8. Agosto\n\t9. Septiembre\n\t10. Octubre\n\t11. Noviembre\n\t12. Diciembre\n"
    var menuDeAyuda = "-----------------------------------------------------------------------------------\nAYUDA\nEste programa asigna el RFC de persona físicas y morales.\nAl inicio se muestra un menu con las opciones disponibles.\nIngresa el número de una de las opciones y presiona ENTER para continuar.\nPara usar correctamente este programa debes:\n\t1. Ingresar nombres sin: acentos, números, caracteres especiales, ni dejarlo en blanco.\n\t2. Ingresar números sin: letras, caracteres especiales, ni dejarlo en blanco.\n\t3. Despues de ingresar un dato presionar ENTER para continuar.\n\t4. Si ingresas un dato que no cumple con estas condiciones el sistema lo vuelve a pedir.\n\t5. Solo avanzará hasta que ingreses el dato correctamente.\n\t6. Al ingresar todos los datos te muestra el RFC generado y pregunta si quieres generar otro o salir.\n\n-----------------------------------------------------------------------------------\n"
    
    func imprimeAConsola(_ message: String){
        print(message)
    }
    
    func obtieneInput() -> String{
        let teclado = FileHandle.standardInput
        let datosTecleados = teclado.availableData
        let dataEnStr = String(data: datosTecleados, encoding: String.Encoding.utf8)!
        return dataEnStr.trimmingCharacters(in: CharacterSet.newlines)
    }
    
}//class EntradaYSalida


