//
//  Validaciones.swift
//  P0-RFC
//
//  Created by Rodrigo on 9/27/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

class Validaciones {
    
    //valida que el parametro no contenga caracteres prohibidos. Si los contiene regresa falso
    func validaNombreOApellido(str: String) -> Bool {
        let caracteresNoPermitidos = ["1","2","3","4","5","6","7","8","9","0","!","$","%","&","/","(",")","=","?","¿","¡","*","^","`","[","]","{","}",",",";","+",".",":","@","º","ª","-","_","á","à","ä","â","Á","À","Ä","é","è","ë","ê","ç","Ç", "É","È","Ë","Ê","í","ì","ï","î","Í","Ì","Ï","Î","ó","ò","ö","ô","Ó","Ò","Ö","Ô","ú","ù","ü","û","Ú","Ù","Ü","Û"]
        let resultado = caracteresNoPermitidos.contains(where: str.contains)
        return !resultado
    }
    
    //valida que parametro no contenga caracteres prohibidos. Si los contiene regresa falso
    func validaNombreMoral(str: String) -> Bool {
        let caracteresNoPermitidos = ["!","$","%","&","/","(",")","=","?","¿","¡","*","^","`","[","]","{","}",";","+",":","@","º","ª","-","_","á","à","ä","â","Á","À","Ä","é","è","ë","ê","ç","Ç", "É","È","Ë","Ê","í","ì","ï","î","Í","Ì","Ï","Î","ó","ò","ö","ô","Ó","Ò","Ö","Ô","ú","ù","ü","û","Ú","Ù","Ü","Û"]
        let resultado = caracteresNoPermitidos.contains(where: str.contains)
        return !resultado
    }
    
    //valida que el parametro no contenga caracteres prohibidos. Si los contiene regresa falso
    func validaNumero(num: String) -> Bool {
        let caracteresNoPermitidos = [" ","!","$","%","&","/","(",")","=","?","¿","¡","*","^","`","[","]","{","}",",",";","+",".",":","@","º","ª","-","_","á","à","ä","â","Á","À","Ä"," ","é","è","ë","ê","ç","Ç", "É","È","Ë","Ê","í","ì","ï","î","Í","Ì","Ï","Î","ó","ò","ö","ô","Ó","Ò","Ö","Ô","ú","ù","ü","û","Ú","Ù","Ü","Û","Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Ñ","Z","X","C","V","B","N","M","q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","ñ","z","x","c","v","b","n","m"]
        let resultado = caracteresNoPermitidos.contains(where: num.contains)
        return !resultado
    }
    
    //valida que el parametro este dentro de los parametros. Si lo está regresa true.
    func validaMes(mes: Int) -> Bool {
        if mes < 1 || mes > 12 {
            return false
        } else {
            return true
        }
    }
    
    //valida que el parametro este dentro de los parametros. Si lo está regresa true.
    func validaAño(año: Int) -> Bool {
        if año > Calendar.current.component(.year, from: Date()) || año < 1900{
            return false
        }
        else {
            return true
        }
    }
    
    //valida que el parametro este dentro de los parametros. Si lo está regresa true.
    func validaDia(dia: Int) -> Bool {
        if dia < 1 || dia > 31 {
            return false
        } else {
            return true
        }
    }
    
}
