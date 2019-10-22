//
//  Marcadores.swift
//  P1
//
//  Created by Rodrigo on 10/19/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

class Marcadores {
    
    var puntosRecientes = [Int]()
    var fechasRecientes = [Date]()
    var puntuacionMaxima: Int!
    var fechaPuntuacionMaxima: Date!
    
    init() {
        if UserDefaults.standard.array(forKey: "puntosRecientes") != nil {
            self.puntosRecientes = UserDefaults.standard.array(forKey: "puntosRecientes") as! [Int]
        } else {
            self.puntosRecientes = []
        }
        
        if UserDefaults.standard.array(forKey: "fechasRecientes") != nil {
            self.fechasRecientes = UserDefaults.standard.array(forKey: "fechasRecientes") as! [Date]
        } else {
            self.fechasRecientes = []
        }
        
        self.puntuacionMaxima = UserDefaults.standard.integer(forKey: "puntuacionMaxima")
        self.fechaPuntuacionMaxima = UserDefaults.standard.object(forKey: "fechaPuntuacionMaxima") as? Date
    }
    
    func añadePuntacion(nuevosPuntos: Int) {
        let fechaActual = Date()
        //si no hay puntuaciones o si no se ha alcanzado el maximo de puntuaciones permitidas solo añadelo
        if self.puntosRecientes.count < 5{
            self.puntosRecientes.insert(nuevosPuntos, at: 0)
            UserDefaults.standard.set(self.puntosRecientes, forKey: "puntosRecientes")
            self.fechasRecientes.insert(fechaActual, at: 0)
            UserDefaults.standard.set(self.fechasRecientes, forKey: "fechasRecientes")
        } else {
            self.puntosRecientes.removeLast()
            self.puntosRecientes.insert(nuevosPuntos, at: 0)
            UserDefaults.standard.set(self.puntosRecientes, forKey: "puntosRecientes")
            self.fechasRecientes.removeLast()
            self.fechasRecientes.insert(fechaActual, at: 0)
            UserDefaults.standard.set(self.fechasRecientes, forKey: "fechasRecientes")
        }
    }
}
