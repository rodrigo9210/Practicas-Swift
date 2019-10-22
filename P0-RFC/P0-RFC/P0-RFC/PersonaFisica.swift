//
//  PersonaFisica.swift
//  P0-RFC
//
//  Created by Rodrigo on 9/27/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

struct PersonaFisica : Persona {
    //atributos del protocolo
    var fecha = DateComponents()
    var siglasFecha: String
    var siglasNombre: String
    var claveDiferenciadora: String
    var digitoVerificador: String
    var nombreParaGenerarClave: String
    var RFC : String
    //atributos propios
    var nombre : String
    var apellidoPaterno : String
    var apellidoMaterno : String

    //verifica que la fecha sea valida y que no sea menor de edad. Regresa true si cumple con las condiciones
    func validaFecha() -> Bool {
        var años = DateComponents()
        años.setValue(-18, for: .year)
        
        let hoy = Date()
        let fechaMinimaMayoriaEdad = Calendar.current.date(byAdding: años, to: hoy)
        let miFecha = Calendar.current.date(from: self.fecha)
        
        //verifica que la fecha sea valida y que la persona sea mayor de edad
        if self.fecha.isValidDate(in: .current) && miFecha! < fechaMinimaMayoriaEdad!{
            print("Fecha Valida")
            return true
        } else {
            print("Fecha invalida o la persona es menor de edad. Vuelve a ingresar los datos")
            return false
        }
    }
    
    func imprimeDatosPersonales() {
        print("\(self.nombreParaGenerarClave)")
    }
    
    //pide todos los datos de las persona y los asigna a las variables de la estructura.
    mutating func pideDatosPersonaFisica(){
        var respuesta = false
        var nombre : String = ""
        
        while !respuesta {
            (nombre, respuesta) = pideNombrePersonaFisica(nombre: "nombre")
        }
        
        self.nombre = nombre
        
        respuesta = false
        var apellidoPaterno : String = ""
        
        while !respuesta {
            (apellidoPaterno, respuesta) = pideApellidoPersonaFisica(apellido: "apellido paterno")
        }
        
        self.apellidoPaterno = apellidoPaterno
        
        respuesta = false
        var apellidoMaterno : String = ""
        
        while !respuesta {
            (apellidoMaterno, respuesta) = pideApellidoPersonaFisica(apellido: "apellido materno")
        }
        
        self.apellidoMaterno = apellidoMaterno
        
        self.nombreParaGenerarClave = apellidoPaterno
        self.nombreParaGenerarClave.append(" ")
        self.nombreParaGenerarClave.append("\(apellidoMaterno)")
        self.nombreParaGenerarClave.append(" ")
        self.nombreParaGenerarClave.append("\(nombre)")
        
        repeat {
            self.pideFecha()
        }while(!self.validaFecha())
        
        
    }//func pideDatos
    
    //genera las siglas del nombre siguiendo las reglas.
    mutating func generaSiglasNombre(){
        var siglas : String = ""
        //si no tiene apellido materno y si el paterno tiene mas de una letra
        if self.apellidoMaterno == "" && self.apellidoPaterno.count > 1{
            siglas.append(self.apellidoPaterno.first!)
            siglas.append(self.apellidoPaterno[1])
            siglas.append(self.nombre.first!)
            siglas.append(self.nombre[1])
        //si no tiene apellido materno y si el paterno tiene una letra
        }else if self.apellidoMaterno == "" && self.apellidoPaterno.count == 1{
            siglas.append(self.apellidoPaterno.first!)
            siglas.append("X")
            siglas.append(self.nombre.first!)
            siglas.append(self.nombre[1])
        //s tiene materno pero el paterno tiene menos de 3 letras
        }else if self.apellidoPaterno.count < 3 {
            siglas.append(self.apellidoPaterno.first!)
            siglas.append(self.apellidoMaterno.first!)
            siglas.append(self.nombre.first!)
            siglas.append(self.nombre[1])
        } else {
        //caso normal
            siglas.append(self.apellidoPaterno.first!)
            //busca la segunda vocal
            let vocales = ["A","E","I","O","U"]
            var i = 1
            var encontrado = false
            while i < self.apellidoPaterno.count && !encontrado{
                if vocales.contains(self.apellidoPaterno[i]){
                    siglas.append(self.apellidoPaterno[i])
                    encontrado = true
                }
                i += 1
                // si no tiene segunda vocal agrega una x
                if i == self.apellidoPaterno.count && !encontrado {
                    siglas.append("X")
                }
            }
            siglas.append(self.apellidoMaterno.first!)
            siglas.append(self.nombre.first!)
        }
        
        //busca coincidencias en tabla 4
        let res =  tabla4.filter { (key, value) in key.contains(siglas) }
        //si encontro coincidencias cambia el valor de siglas
        if res.count != 0{
            siglas =  res[siglas]!
        }
        
        self.siglasNombre = siglas
        
    }//func generaSiglasNombre
    
    //pide el nombre de la persona, el argumento es para interactuar con el usuario.
    //regresa el string depurado y true si cumple con las condiciones.
    func pideNombrePersonaFisica(nombre valorDeEntrada: String) -> (String, Bool) {
        let entradaYSalida = EntradaYSalida()
        entradaYSalida.imprimeAConsola("Ingresa el \(valorDeEntrada.uppercased()) de la persona. No debe incluir letras con acentos, números, caracteres especiales y tampoco puede ir vacio.")
        var nombrePorAsignar = entradaYSalida.obtieneInput()
        
        let validaStr = Validaciones()
        let resultado = validaStr.validaNombreOApellido(str: nombrePorAsignar)
        nombrePorAsignar = nombrePorAsignar.uppercased()
        let arreglo = nombrePorAsignar.components(separatedBy: " ")
        
        if arreglo.count > 1 && nombrePorAsignar != "JOSE MARIA" && nombrePorAsignar != "MARIA JOSE"{
            nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "MARIA ", with: "")
            nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "JOSE ", with: "")
        } else if arreglo.count > 1 && nombrePorAsignar == "JOSE MARIA"{
            nombrePorAsignar = "MARIA"
        } else if arreglo.count > 1 && nombrePorAsignar == "MARIA JOSE"{
            nombrePorAsignar = "JOSE"
        }
        
        if resultado {
            if nombrePorAsignar == ""{
                print("El \(valorDeEntrada) no puede ir vacio.")
                return ("", false)
            } else {
                return (nombrePorAsignar.uppercased(), resultado)
            }
        } else {
            print("\(nombrePorAsignar) contiene carácteres no permitidos.")
            return (nombrePorAsignar.replacingOccurrences(of: "", with: ""), resultado)
        }
    }
    
    //pide el apellido de la persona, el argumento es para interactuar con el usuario.
    //regresa el string depurado y true si cumple con las condiciones.
    func pideApellidoPersonaFisica(apellido valorDeEntrada: String) -> (String, Bool) {
        let entradaYSalida = EntradaYSalida()
        if valorDeEntrada == "apellido paterno" {
            entradaYSalida.imprimeAConsola("Ingresa el \(valorDeEntrada.uppercased()) de la persona. No debe incluir letras con acentos, números, caracteres especiales y tampoco puede ir vacio.")
        } else if valorDeEntrada == "apellido materno" {
            entradaYSalida.imprimeAConsola("Ingresa el \(valorDeEntrada.uppercased()) de la persona. No debe incluir letras con acentos, números ni caracteres especiales. Si no tiene presiona ENTER.")
        }
        
        var nombrePorAsignar = entradaYSalida.obtieneInput()
        
        let validaStr = Validaciones()
        let resultado = validaStr.validaNombreOApellido(str: nombrePorAsignar)
        nombrePorAsignar = nombrePorAsignar.uppercased()
        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "DE ", with: "")
        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "DEL ", with: "")
        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "LA ", with: "")
        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "LOS ", with: "")
        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "LAS ", with: "")
        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "Y ", with: "")
        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "MC", with: "")
        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "MAC", with: "")
        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "VON ", with: "")
        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "VAN ", with: "")
        
        if resultado {
            if valorDeEntrada == "apellido paterno" && nombrePorAsignar == ""{
                print("El \(valorDeEntrada) no puede ir vacio.")
                return ("", false)
            } else if valorDeEntrada == "apellido paterno" && nombrePorAsignar != ""{
                return (nombrePorAsignar, resultado)
            } else {
                return (nombrePorAsignar, resultado)
            }
        } else {
            print("\(nombrePorAsignar) contiene carácteres no permitidos.")
            return (nombrePorAsignar.replacingOccurrences(of: "", with: ""), resultado)
        }
    }

}
