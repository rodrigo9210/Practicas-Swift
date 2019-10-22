//
//  Funciones.swift
//  P0-RFC
//
//  Created by Rodrigo on 9/27/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

//imprime el menu de inicio. regresa la opcion seleccionada y true si la opcion es valida
func menuDeInicio() -> (String, Bool){
    let entradaYSalida = EntradaYSalida()
    entradaYSalida.imprimeAConsola(entradaYSalida.mensajeDeBienvenida)
    entradaYSalida.imprimeAConsola(entradaYSalida.menuInicio)
    let tipoDePersonaACrear = entradaYSalida.obtieneInput()
    if tipoDePersonaACrear == "1" {
        print("Elegiste Persona Física")
        return (tipoDePersonaACrear, true)
    } else if tipoDePersonaACrear == "2"{
        print("Elegiste Persona Moral")
        return (tipoDePersonaACrear, true)
    } else if tipoDePersonaACrear == "3" {
        print("Adios")
        exit(0)
    } else if tipoDePersonaACrear == "4" {
        entradaYSalida.imprimeAConsola(entradaYSalida.menuDeAyuda)
        return (tipoDePersonaACrear, false)
    }
    else {
        print("Opción Inválida. Intentalo nuevamente")
        return (tipoDePersonaACrear, false)
    }
}

//imprime el menu de salida y regresa true si el usuario quiere continuar.
func menuDeSalida() -> Bool{
    let entradaYSalida = EntradaYSalida()
    entradaYSalida.imprimeAConsola(entradaYSalida.menuSalida)
    let continua = entradaYSalida.obtieneInput()
    if continua == "1" {
        return true
    } else{
        return false
    }
}

//pide un numero. El argumento es para interacrtuar con el usuario
//regresa true si el número es valido segun sea el caso.
func pideNumero(numeroAPedir valorDeEntrada: String) -> (String, Bool) {
    let entradaYSalida = EntradaYSalida()
    entradaYSalida.imprimeAConsola("Ingresa el \(valorDeEntrada) de nacimiento.")
    if valorDeEntrada == "mes"{
        entradaYSalida.imprimeAConsola(entradaYSalida.meses)
    }
    let numeroPorAsignar = entradaYSalida.obtieneInput()
    
    let validaNum = Validaciones()
    var resultado = validaNum.validaNumero(num: numeroPorAsignar)
    
    if resultado {
        if numeroPorAsignar == ""{
            print("El \(valorDeEntrada) no puede ir vacio.")
            return ("", false)
        } else{
            if valorDeEntrada == "dia" {
                resultado = validaNum.validaDia(dia: Int(numeroPorAsignar)!)
            } else if valorDeEntrada == "mes" {
                resultado = validaNum.validaMes(mes: Int(numeroPorAsignar)!)
            } else if valorDeEntrada == "año" {
                resultado = validaNum.validaAño(año: Int(numeroPorAsignar)!)
            }
            
            if !resultado {
                print("El \(valorDeEntrada) no está permitido.")
                return("",false)
            }
            else{
                print("OK")
                return(numeroPorAsignar, true)
            }
        }
        
    } else {
        print("\(numeroPorAsignar) contiene carácteres no permitidos.")
        return (numeroPorAsignar.replacingOccurrences(of: "", with: ""), resultado)
    }
}

//imprime un menu de ayuda si detecta algun argumento.
func ayuda() {
    let (argc, argumentos) = (CommandLine.argc, CommandLine.arguments)
    let entradaYSalida = EntradaYSalida()
    
    if argc > 1 && argumentos[1] != ""{
        entradaYSalida.imprimeAConsola(entradaYSalida.menuDeAyuda)
    }
}

    
