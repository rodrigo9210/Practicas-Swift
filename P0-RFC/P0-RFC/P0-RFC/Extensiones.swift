//
//  Extensiones.swift
//  P0-RFC
//
//  Created by Rodrigo on 9/30/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

extension Persona {
    
    mutating func pideFecha() {
        var respuesta = false
        var dia : String = ""
        
        while !respuesta {
            (dia, respuesta) = pideNumero(numeroAPedir: "dia")
        }
        
        self.fecha.day = Int(dia)
        
        respuesta = false
        var mes : String = ""
        
        while !respuesta {
            (mes, respuesta) = pideNumero(numeroAPedir: "mes")
        }
        
        self.fecha.month = Int(mes)
        
        respuesta = false
        var año : String = ""
        
        while !respuesta {
            (año, respuesta) = pideNumero(numeroAPedir: "año")
        }
        
        self.fecha.year = Int(año)
    }
    
    mutating func generaSiglasFecha(){
        var resultado : String = ""
        let año = self.fecha.year! % 100
        
        if año < 10 {
            resultado.append(String(format: "%02d", año))
        }else{
            resultado.append(String(año))
        }
        
        
        if self.fecha.month! < 10 {
            resultado.append(String(format: "%02d", self.fecha.month!))
        }else{
            resultado.append(String(self.fecha.month!))
        }
        
        if self.fecha.day! < 10 {
            resultado.append(String(format: "%02d", self.fecha.day!))
        }else{
            resultado.append(String(self.fecha.day!))
        }
        
        self.siglasFecha = resultado
    }
    
    mutating func generaClaveDiferenciadora(){
        var claveDiferenciadora : String = ""
        var codigo : String = "0"
        var suma : Double = 0
        var par : Double = 0
        var parString :  String = ""
        var unidades : Double = 0
        var multiplicacion : Double = 0
        var cociente : Int = 0
        var residuo : Int = 0
        
        //genera el codigo para realizar la suma posteriormente
        for letra in self.nombreParaGenerarClave {
            let res =  tabla1.filter { (key, value) in key.contains(letra) }
            codigo.append(res[String(letra)]!)
        }
        
        for i in 0..<codigo.count - 1{
            parString.append(codigo[i])
            parString.append(codigo[i+1])
            par = Double(parString)!
            unidades = par.truncatingRemainder(dividingBy: 10.0)
            multiplicacion = par * unidades
            suma += multiplicacion
            par = 0
            parString = ""
        }
        
        //toma hasta las centenas de la suma
        suma = suma.truncatingRemainder(dividingBy: 1000.0)
        cociente = Int(suma / 34)
        residuo = Int (suma.truncatingRemainder(dividingBy: 34))
        
        claveDiferenciadora.append(tabla2[cociente]!)
        claveDiferenciadora.append(tabla2[residuo]!)
        
        self.claveDiferenciadora = claveDiferenciadora
    }
    
    mutating func generaDigitoVerificador(){
        var digitoVerificador : String = ""
        var siglas : String = ""
        var suma : Double = 0
        var multiplicacion : Double = 0
        var valor : Double = 0
        
        siglas.append(self.siglasNombre)
        siglas.append(self.siglasFecha)
        siglas.append(self.claveDiferenciadora)
        
        for i in 0..<siglas.count{
            let res =  tabla3.filter { (key, value) in key.contains(siglas[i]) }
            valor = Double(res[siglas[i]]!)
            multiplicacion = valor * Double((14 - (i+1)))
            suma += multiplicacion
            valor = 0
        }
        
        suma = suma.truncatingRemainder(dividingBy: 11)
        
        if suma == 0 {
            digitoVerificador = "0"
        } else if (suma > 1 && suma < 10) {
            digitoVerificador = String(Int(11 - (suma.truncatingRemainder(dividingBy: 11))))
        } else {
            digitoVerificador = "A"
        }
        
        self.digitoVerificador = digitoVerificador
    }
    
    mutating func imprimeYGeneraRFC(){
        self.RFC = self.siglasNombre
        self.RFC.append("-")
        self.RFC.append(self.siglasFecha)
        self.RFC.append("-")
        self.RFC.append(self.claveDiferenciadora)
        self.RFC.append("-")
        self.RFC.append(self.digitoVerificador)
        print("RFC asignado:")
        print("\(self.RFC)")
    }
    
    
}
