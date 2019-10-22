//
//  PersonaMoral.swift
//  P0-RFC
//
//  Created by Rodrigo on 10/1/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

struct PersonaMoral : Persona {
    
    
    //atributos del protocolo
    var fecha = DateComponents()
    var siglasFecha: String
    var siglasNombre: String
    var claveDiferenciadora: String
    var digitoVerificador: String
    var nombreParaGenerarClave: String
    var RFC : String
    //atributos propios
    var nombre : [String]
    
    //valida que la fecha exista y que no sea futura. regresa true si cumple las condiciones
    func validaFecha() -> Bool {
        var unDia = DateComponents()
        unDia.setValue(1, for: .day)
        
        let hoy = Date()
        let mañana = Calendar.current.date(byAdding: unDia, to: hoy)
        let miFecha = Calendar.current.date(from: self.fecha)
        
        //verifica que la fecha sea valida y no sea futura
        if self.fecha.isValidDate(in: .current) && miFecha! < mañana! {
            return true
        } else {
            print("La fecha ingresada no es valida.")
            return false
        }
    }//func validaFecha
    
    //pide nombre y fecha
    mutating func pideDatosPersonaMoral(){
        var respuesta = false
        var nombre : [String] = []
        
        while !respuesta {
            (nombre, respuesta) = pideNombrePersonaMoral(nombre: "nombre")
        }
        
        self.nombre = nombre
        
        repeat {
            self.pideFecha()
        }
            while(!self.validaFecha())
    }//func pideDatos
    
    //Pide nombre. El argumento es para interactuar con el usuario.
    //Regresa un arreglo con las palabras del nombre y true si el nombre por asignar es valido.
    mutating func pideNombrePersonaMoral(nombre valorDeEntrada: String) -> ([String], Bool) {
        let entradaYSalida = EntradaYSalida()
        entradaYSalida.imprimeAConsola("Ingresa el \(valorDeEntrada.uppercased()) de la persona. No debe incluir letras con acentos, caracteres especiales y tampoco puede ir vacio.")
        var nombrePorAsignar = entradaYSalida.obtieneInput()
        
        let validaStr = Validaciones()
        let resultado = validaStr.validaNombreMoral(str: nombrePorAsignar)
        nombrePorAsignar = nombrePorAsignar.uppercased()
        
        if resultado {
            if nombrePorAsignar == ""{
                print("El \(valorDeEntrada) no puede ir vacio.")
                return ([], false)
            } else {
                nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "", with: "")
                var arreglo = nombrePorAsignar.components(separatedBy: " ")
                var sinSociedades : [String] = []
                var depurado : [String] = []
                
                //tranforma elementos numericos en palabras
                for elemento in arreglo{
                    let numero = Int(elemento)
                    if numero != nil {
                        let formateador : NumberFormatter = NumberFormatter()
                        formateador.locale = Locale(identifier: "es_ES")
                        formateador.numberStyle = NumberFormatter.Style.spellOut
                        let numeroTraducido = formateador.string(from: NSNumber(value: numero!))!
                        nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: elemento, with: numeroTraducido)
                    }
                }
                
                nombrePorAsignar = nombrePorAsignar.uppercased()
                
                self.nombreParaGenerarClave = nombrePorAsignar
                nombreParaGenerarClave = self.nombreParaGenerarClave.replacingOccurrences(of: ".", with: "")
                nombreParaGenerarClave = self.nombreParaGenerarClave.replacingOccurrences(of: ",", with: "")
                
                //Separa por comas para buscar nombres de sociedades
                arreglo = nombrePorAsignar.components(separatedBy: ", ")
                //si un elemento de arreglo no es tipo de sociedad envialo a sinSociedades
                for i in 0..<arreglo.count{
                    if !tabla5.contains(arreglo[i]){
                        sinSociedades.append(arreglo[i])
                    }
                }
                
                nombrePorAsignar = sinSociedades.joined(separator: " ")
                nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: ".", with: " ")
                nombrePorAsignar = nombrePorAsignar.replacingOccurrences(of: "  ", with: " ")
                //vuelve a separarlo por espacios para buscar palabras prohibidas especificas
                arreglo = nombrePorAsignar.components(separatedBy: " ")
                for i in 0..<arreglo.count{
                    if !tabla5.contains(arreglo[i]){
                        depurado.append(arreglo[i])
                    }
                }
                
                //quita posibles elementos vacios del arreglo
                nombrePorAsignar = depurado.joined(separator: " ")
                depurado = []
                arreglo = nombrePorAsignar.components(separatedBy: " ")
                for i in 0..<arreglo.count{
                    if arreglo[i] != "" {
                        depurado.append(arreglo[i])
                    }
                }
                
                return (depurado, resultado)
            }
        } else {
            print("\(nombrePorAsignar) contiene carácteres no permitidos.")
            return ([], resultado)
        }
    }//func pideNombrePersonaMoral
    
    //genera las siglas siguiendo las reglas.
    mutating func generaSiglasNombre() {
        var siglasNombre : String = " "
        
        if self.nombre.count > 2 { //si el nombre contiene mas de dos palabras
            siglasNombre.append(nombre[0].first!)
            siglasNombre.append(nombre[1].first!)
            siglasNombre.append(nombre[2].first!)
        } else if self.nombre.count > 1 { //si el nombre contiene dos palabras
            if self.nombre[1].count > 1{
                siglasNombre.append(nombre[0].first!)
                siglasNombre.append(nombre[1].first!)
                siglasNombre.append(nombre[1][1])
            } else { // si no existen suficientes letras
                siglasNombre.append(nombre[0].first!)
                siglasNombre.append(nombre[1].first!)
                siglasNombre.append("X")
            }
        } else if self.nombre.count == 1 { //si el nombre contiene una palabra
            if self.nombre[0].count > 2 {
                siglasNombre.append(nombre[0].first!)
                siglasNombre.append(nombre[0][1])
                siglasNombre.append(nombre[0][2])
            } else if self.nombre[0].count > 1 { // si no existen suficientes letras
                siglasNombre.append(nombre[0].first!)
                siglasNombre.append(nombre[0][1])
                siglasNombre.append("X")
            } else { // si no existen suficientes letras
                siglasNombre.append(nombre[0].first!)
                siglasNombre.append("X")
                siglasNombre.append("X")
            }
        } else { // si el nombre está vacio
            siglasNombre.append("XXX")
        }
        
        self.siglasNombre = siglasNombre
        
    }//func generaSiglasNombre
    
    
}// struct PersonaMoral
