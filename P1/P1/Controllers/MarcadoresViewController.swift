//
//  MarcadoresViewController.swift
//  P1
//
//  Created by Rodrigo on 10/14/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit

class MarcadoresViewController: UIViewController {
    
    
    @IBOutlet weak var puntuacion1: UILabel!
    @IBOutlet weak var puntuacion2: UILabel!
    @IBOutlet weak var puntuacion3: UILabel!
    @IBOutlet weak var puntuacion4: UILabel!
    @IBOutlet weak var puntuacion5: UILabel!
    @IBOutlet weak var maximaPuntuacion: UILabel!
    var puntos: Int!
    var misPuntuaciones = Marcadores()
    
    override func viewDidLoad() {
        if self.misPuntuaciones.fechaPuntuacionMaxima != nil {
            let fechaMaxima: String = formateaFecha(fecha: self.misPuntuaciones.fechaPuntuacionMaxima)
            self.maximaPuntuacion.text = "\(String(describing: self.misPuntuaciones.puntuacionMaxima!)) puntos en \(fechaMaxima)"
        } else {
            self.maximaPuntuacion.text = "No hay puntuación registrada."
        }
        self.maximaPuntuacion.sizeToFit()
        self.puntuacion1.text = ""
        self.puntuacion2.text = ""
        self.puntuacion3.text = ""
        self.puntuacion4.text = ""
        self.puntuacion5.text = ""
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.puntos == nil {
            
        } else {
            asignaPuntuaciones(puntos: self.puntos)
        }
        
        //carga puntuaciones en labels
        for i in 0..<self.misPuntuaciones.puntosRecientes.count {
            let fechaFormateada = formateaFecha(fecha: self.misPuntuaciones.fechasRecientes[i])
            switch i {
            case 0:
                self.puntuacion1.text = "\(String(describing: self.misPuntuaciones.puntosRecientes[0])) puntos en \(fechaFormateada)"
            case 1:
                self.puntuacion2.text = "\(String(describing: self.misPuntuaciones.puntosRecientes[1])) puntos en \(fechaFormateada)"
            case 2:
                self.puntuacion3.text = "\(String(describing: self.misPuntuaciones.puntosRecientes[2])) puntos en \(fechaFormateada)"
            case 3:
                self.puntuacion4.text = "\(String(describing: self.misPuntuaciones.puntosRecientes[3])) puntos en \(fechaFormateada)"
            case 4:
                self.puntuacion5.text = "\(String(describing: self.misPuntuaciones.puntosRecientes[4])) puntos en \(fechaFormateada)"
            default:
                print("Esto no deberia pasar")
                
            }
        }
        
    }
    
    //cambia la puntuacion mas alta de tal modo que el usuario pueda ver si acaba de romper el record
    override func viewDidAppear(_ animated: Bool) {
        if self.puntos == nil {
            
        }
        else if self.puntos! > self.misPuntuaciones.puntuacionMaxima! {
            UserDefaults.standard.set(puntos, forKey: "puntuacionMaxima")
            UserDefaults.standard.set(Date(), forKey: "fechaPuntuacionMaxima")
            let puntuacionMaxima: Int? = UserDefaults.standard.integer(forKey: "puntuacionMaxima")
            let fechaPuntuacionMaxima: Date? = UserDefaults.standard.object(forKey: "fechaPuntuacionMaxima") as? Date
            let fechaMaxima: String = formateaFecha(fecha: fechaPuntuacionMaxima!)
            self.maximaPuntuacion.text = "\(String(describing: puntuacionMaxima!)) puntos en \(fechaMaxima)"
            self.maximaPuntuacion.sizeToFit()
            self.maximaPuntuacion.textColor = .red
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.maximaPuntuacion.textColor = .black
    }
    
    func asignaPuntuaciones(puntos: Int){
        self.misPuntuaciones.añadePuntacion(nuevosPuntos: puntos)
    }
    
    //recibe una fecha y regresa un string formateado
    func formateaFecha(fecha: Date) -> String {
        let calendario = Calendar.current
        let año = calendario.component(.year, from: fecha)
        let mes = calendario.component(.month, from: fecha)
        let dia = calendario.component(.day, from: fecha)
        let hora = calendario.component(.hour, from: fecha)
        let minuto = calendario.component(.minute, from: fecha)
        var horaFormateada = ""
        
        if hora > 9 {
            horaFormateada.append(String(hora))
        } else {
            let horaConCeros = String(format: "%02d", hora)
            horaFormateada.append(horaConCeros)
        }
        
        horaFormateada.append(":")
        
        if minuto > 9 {
            horaFormateada.append(String(minuto))
        } else {
            let minutosConCeros = String(format: "%02d", minuto)
            horaFormateada.append(minutosConCeros)
        }
        
        return "\(dia)-\(mes)-\(año) \(horaFormateada)"
    }

    //Borra marcadores de etiquetas y de registros
    @IBAction func borrarMarcadores(_ sender: UIButton) {
        self.maximaPuntuacion.text = "No hay puntuación registrada."
        self.maximaPuntuacion.textColor = .black
        self.maximaPuntuacion.sizeToFit()
        self.puntuacion1.text = ""
        self.puntuacion2.text = ""
        self.puntuacion3.text = ""
        self.puntuacion4.text = ""
        self.puntuacion5.text = ""
        UserDefaults.standard.removeObject(forKey: "puntuacionMaxima")
        UserDefaults.standard.removeObject(forKey: "fechaPuntuacionMaxima")
        UserDefaults.standard.removeObject(forKey: "puntosRecientes")
        UserDefaults.standard.removeObject(forKey: "fechasRecientes")
    }
}
