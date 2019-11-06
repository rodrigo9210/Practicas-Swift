//
//  File.swift
//  Posesionista
//
//  Created by Arce Anguiano Rodrigo Roberto on 10/9/19.
//  Copyright © 2019 Arce Anguiano Rodrigo Roberto. All rights reserved.
//

import Foundation

class Cosa : NSObject, NSCoding {
    
    var nombre : String = ""
    var valorEnPesos : Int
    var numeroDeSerie : String?
    var seccion: Int
    let fechaDeCreacion : Date
    let llaveCosa : String
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.nombre, forKey: "nombre")
        aCoder.encode(self.valorEnPesos, forKey: "valorEnPesos")
        aCoder.encode(self.numeroDeSerie, forKey: "numeroDeSerie")
        aCoder.encode(self.fechaDeCreacion, forKey: "fechaDeCreacion")
        aCoder.encode(self.llaveCosa, forKey: "llaveCosa")
        aCoder.encode(self.seccion, forKey: "seccion")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.nombre = aDecoder.decodeObject(forKey: "nombre") as! String
        self.valorEnPesos = aDecoder.decodeInteger(forKey: "valorEnPesos")
        self.numeroDeSerie = aDecoder.decodeObject(forKey: "numeroDeSerie") as! String?
        self.fechaDeCreacion = aDecoder.decodeObject(forKey: "fechaDeCreacion") as! Date
        self.llaveCosa = aDecoder.decodeObject(forKey: "llaveCosa") as! String
        self.seccion = aDecoder.decodeInteger(forKey: "seccion")
        super.init()
    }
    
    init(nombre: String, valor: Int, serie: String?, alta: Date, seccion: Int) {
        self.nombre = nombre
        self.valorEnPesos = valor
        self.numeroDeSerie = serie
        self.fechaDeCreacion = alta
        self.llaveCosa = UUID().uuidString
        self.seccion = seccion
        super.init()
    }
    
    override convenience init(){
        let sustantivos = ["aguacate", "termo", "audifonos"]
        let adjetivos = ["verde", "viejo", "caro"]
        
        let nombreAleatorio = "\(sustantivos.randomElement()!) \(adjetivos.randomElement()!)"
        let valorAleatorio = Int.random(in: 0...1000)
        let serieAleatorio = UUID().uuidString.components(separatedBy: "-").first!
        var seccion: Int!
        
        switch valorAleatorio {
        case 0..<100:
            seccion = 0
        case 100..<200:
            seccion = 1
        case 200..<300:
            seccion = 2
        case 300..<400:
            seccion = 3
        case 400..<500:
            seccion = 4
        case 500..<600:
            seccion = 5
        case 600..<700:
            seccion = 6
        case 700..<800:
            seccion = 7
        case 800..<900:
            seccion = 8
        case 900..<1001:
            seccion = 9
        default:
            print("Esto no pasa")
        }
        
        self.init(nombre: nombreAleatorio, valor: valorAleatorio, serie:serieAleatorio, alta: Date(), seccion: seccion)
    }
    
}//class Cosa
