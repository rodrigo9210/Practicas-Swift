//
//  Inventario.swift
//  Posesionista
//
//  Created by Arce Anguiano Rodrigo Roberto on 10/9/19.
//  Copyright © 2019 Arce Anguiano Rodrigo Roberto. All rights reserved.
//

import Foundation

class Inventario {
    var todasLasCosas = [Cosa]()
    var cosas0 = [Cosa]()
    var cosas1 = [Cosa]()
    var cosas2 = [Cosa]()
    var cosas3 = [Cosa]()
    var cosas4 = [Cosa]()
    var cosas5 = [Cosa]()
    var cosas6 = [Cosa]()
    var cosas7 = [Cosa]()
    var cosas8 = [Cosa]()
    var cosas9 = [Cosa]()
    
    let rutaDelInventarioEnElDisco : URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("cosas.archivo")
    }()
    
    init() {
        do {
            let data = try Data(contentsOf: self.rutaDelInventarioEnElDisco)
            do {
                let cosasGuardadas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                self.todasLasCosas = cosasGuardadas as! [Cosa]
                
                for cosa in todasLasCosas{ // revisa todas las cosas del inventario
                    switch cosa.seccion { // dependiendo de su seccion los envia al arreglo correspondiente
                    case 0:
                        self.cosas0.append(cosa)
                    case 1:
                        self.cosas1.append(cosa)
                    case 2:
                        self.cosas2.append(cosa)
                    case 3:
                        self.cosas3.append(cosa)
                    case 4:
                        self.cosas4.append(cosa)
                    case 5:
                        self.cosas5.append(cosa)
                    case 6:
                        self.cosas6.append(cosa)
                    case 7:
                        self.cosas7.append(cosa)
                    case 8:
                        self.cosas8.append(cosa)
                    case 9:
                        self.cosas9.append(cosa)
                    default:
                        print("error al cargar cosas")
                    }
                }
                
            } catch {
                print("Error al deserializar los datos \(error.localizedDescription)")
            }
        } catch {
            print("Error al leer del disco \(error.localizedDescription)")
        }
    }
    
    @discardableResult func creaCosa() -> Cosa {
        let cosa = Cosa()
        self.todasLasCosas.append(cosa)
        
        switch cosa.seccion { //dependiendo de la seccion de la cosa agregala a al arreglo correspondiente
        case 0:
            self.cosas0.append(cosa)
            return cosas0.last!
        case 1:
            self.cosas1.append(cosa)
            return cosas1.last!
        case 2:
            self.cosas2.append(cosa)
            return cosas2.last!
        case 3:
            self.cosas3.append(cosa)
            return cosas3.last!
        case 4:
            self.cosas4.append(cosa)
            return cosas4.last!
        case 5:
            self.cosas5.append(cosa)
            return cosas5.last!
        case 6:
            self.cosas6.append(cosa)
            return cosas6.last!
        case 7:
            self.cosas7.append(cosa)
            return cosas7.last!
        case 8:
            self.cosas8.append(cosa)
            return cosas8.last!
        case 9:
            self.cosas9.append(cosa)
            return cosas9.last!
        default:
            print("error al crear cosa en inventario")
            return cosa
        }
        
        
    }
    
    func eliminaCosa(cosaAELiminar: Cosa){
        
        switch cosaAELiminar.seccion { //dependiendo de la seccion de la cosa la elimina del arreglo correspondiente
        case 0:
            if let indiceDeCosa = self.cosas0.firstIndex(of: cosaAELiminar) {
                cosas0.remove(at: indiceDeCosa)
            }
        case 1:
            if let indiceDeCosa = self.cosas1.firstIndex(of: cosaAELiminar) {
                cosas1.remove(at: indiceDeCosa)
            }
        case 2:
            if let indiceDeCosa = self.cosas2.firstIndex(of: cosaAELiminar) {
                cosas2.remove(at: indiceDeCosa)
            }
        case 3:
            if let indiceDeCosa = self.cosas3.firstIndex(of: cosaAELiminar) {
                cosas3.remove(at: indiceDeCosa)
            }
        case 4:
            if let indiceDeCosa = self.cosas4.firstIndex(of: cosaAELiminar) {
                cosas4.remove(at: indiceDeCosa)
            }
        case 5:
            if let indiceDeCosa = self.cosas5.firstIndex(of: cosaAELiminar) {
                cosas5.remove(at: indiceDeCosa)
            }
        case 6:
            if let indiceDeCosa = self.cosas6.firstIndex(of: cosaAELiminar) {
                cosas6.remove(at: indiceDeCosa)
            }
        case 7:
            if let indiceDeCosa = self.cosas7.firstIndex(of: cosaAELiminar) {
                cosas7.remove(at: indiceDeCosa)
            }
        case 8:
            if let indiceDeCosa = self.cosas8.firstIndex(of: cosaAELiminar) {
                cosas8.remove(at: indiceDeCosa)
            }
        case 9:
            if let indiceDeCosa = self.cosas9.firstIndex(of: cosaAELiminar) {
                cosas9.remove(at: indiceDeCosa)
            }
        default:
            print("error al eliminar cosa en inventario")
        }
        
        if let indiceDeCosa = todasLasCosas.firstIndex(of: cosaAELiminar) { // y la elimina del arreglo que tiene todo
            todasLasCosas.remove(at: indiceDeCosa)
        }
        
    }
    
    func reordena(de: Int, hacia: Int, seccion: Int){
        if de == hacia {
            return
        }
        
        switch seccion {
        case 0:
            let cosaAMover = self.cosas0[de]
            self.cosas0.remove(at: de)
            self.cosas0.insert(cosaAMover, at: hacia)
        case 1:
            let cosaAMover = self.cosas1[de]
            self.cosas1.remove(at: de)
            self.cosas1.insert(cosaAMover, at: hacia)
        case 2:
            let cosaAMover = self.cosas2[de]
            self.cosas2.remove(at: de)
            self.cosas2.insert(cosaAMover, at: hacia)
        case 3:
            let cosaAMover = self.cosas3[de]
            self.cosas3.remove(at: de)
            self.cosas3.insert(cosaAMover, at: hacia)
        case 4:
            let cosaAMover = self.cosas4[de]
            self.cosas4.remove(at: de)
            self.cosas4.insert(cosaAMover, at: hacia)
        case 5:
            let cosaAMover = self.cosas5[de]
            self.cosas5.remove(at: de)
            self.cosas5.insert(cosaAMover, at: hacia)
        case 6:
            let cosaAMover = self.cosas6[de]
            self.cosas6.remove(at: de)
            self.cosas6.insert(cosaAMover, at: hacia)
        case 7:
            let cosaAMover = self.cosas7[de]
            self.cosas7.remove(at: de)
            self.cosas7.insert(cosaAMover, at: hacia)
        case 8:
            let cosaAMover = self.cosas8[de]
            self.cosas8.remove(at: de)
            self.cosas8.insert(cosaAMover, at: hacia)
        case 9:
            let cosaAMover = self.cosas9[de]
            self.cosas9.remove(at: de)
            self.cosas9.insert(cosaAMover, at: hacia)
        default:
            print("error al reordenar")
        }
        
    }
    
    func guardaEnDisco() -> Bool {
        print("El inventario se guardara en: \(self.rutaDelInventarioEnElDisco.path)")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self.todasLasCosas, requiringSecureCoding: false) //2. Serializar
            do {
                try data.write(to: self.rutaDelInventarioEnElDisco, options: [.atomic]) // las funciones atomicas no se interrumpen NUNCA
                return true
            } catch {
                print("Error al guardar a disco \(error.localizedDescription)")
            }
        } catch {
            print("Error al serializar el inventario: \(error.localizedDescription)")
        }
        return false
    }
    
    //verifica todas las secciones de todas las cosas para reordenarlas
    func verificaSeccionCosa() {
        
        var i = 0
        
        while i < cosas0.count { // revisa todas las cosas de una seccion
            if cosas0[i].seccion != 0 {
                switch cosas0[i].seccion { // si si atributo seccion no es el que deberia lo agrega a la seccion debida
                case 1:
                    cosas1.append(cosas0[i])
                case 2:
                    cosas2.append(cosas0[i])
                case 3:
                    cosas3.append(cosas0[i])
                case 4:
                    cosas4.append(cosas0[i])
                case 5:
                    cosas5.append(cosas0[i])
                case 6:
                    cosas6.append(cosas0[i])
                case 7:
                    cosas7.append(cosas0[i])
                case 8:
                    cosas8.append(cosas0[i])
                case 9:
                    cosas9.append(cosas0[i])
                default:
                    print("error al reordenar")
                }
                cosas0.remove(at: i) // y lo elimina en la que no deberia estar
            }
            i += 1
        } // for cosas0
        
        i = 0
        
        while i < cosas1.count {
            if cosas1[i].seccion != 1 {
                switch cosas1[i].seccion {
                case 0:
                    cosas0.append(cosas1[i])
                case 2:
                    cosas2.append(cosas1[i])
                case 3:
                    cosas3.append(cosas1[i])
                case 4:
                    cosas4.append(cosas1[i])
                case 5:
                    cosas5.append(cosas1[i])
                case 6:
                    cosas6.append(cosas1[i])
                case 7:
                    cosas7.append(cosas1[i])
                case 8:
                    cosas8.append(cosas1[i])
                case 9:
                    cosas9.append(cosas1[i])
                default:
                    print("error al reordenar")
                }
                cosas1.remove(at: i)
            }
            i += 1
        } // for cosas 1
        
        i = 0
        
        while i < cosas2.count {
            if cosas2[i].seccion != 2 {
                switch cosas2[i].seccion {
                case 0:
                    cosas0.append(cosas2[i])
                case 1:
                    cosas1.append(cosas2[i])
                case 3:
                    cosas3.append(cosas2[i])
                case 4:
                    cosas4.append(cosas2[i])
                case 5:
                    cosas5.append(cosas2[i])
                case 6:
                    cosas6.append(cosas2[i])
                case 7:
                    cosas7.append(cosas2[i])
                case 8:
                    cosas8.append(cosas2[i])
                case 9:
                    cosas9.append(cosas2[i])
                default:
                    print("error al reordenar")
                }
                cosas2.remove(at: i)
            }
            i += 1
        } // for cosas 2
        
        i = 0
        
        while i < cosas3.count {
            if cosas3[i].seccion != 3 {
                switch cosas3[i].seccion {
                case 0:
                    cosas0.append(cosas3[i])
                case 1:
                    cosas1.append(cosas3[i])
                case 2:
                    cosas2.append(cosas3[i])
                case 4:
                    cosas4.append(cosas3[i])
                case 5:
                    cosas5.append(cosas3[i])
                case 6:
                    cosas6.append(cosas3[i])
                case 7:
                    cosas7.append(cosas3[i])
                case 8:
                    cosas8.append(cosas3[i])
                case 9:
                    cosas9.append(cosas3[i])
                default:
                    print("error al reordenar")
                }
                cosas3.remove(at: i)
            }
            i += 1
        } // for cosas 3
        
        i = 0
        
        while i < cosas4.count {
            if cosas4[i].seccion != 4 {
                switch cosas4[i].seccion {
                case 0:
                    cosas0.append(cosas4[i])
                case 1:
                    cosas1.append(cosas4[i])
                case 2:
                    cosas2.append(cosas4[i])
                case 3:
                    cosas3.append(cosas4[i])
                case 5:
                    cosas5.append(cosas4[i])
                case 6:
                    cosas6.append(cosas4[i])
                case 7:
                    cosas7.append(cosas4[i])
                case 8:
                    cosas8.append(cosas4[i])
                case 9:
                    cosas9.append(cosas4[i])
                default:
                    print("error al reordenar")
                }
                cosas4.remove(at: i)
            }
             i += 1
        } // for cosas 4
        
        i = 0
        
        while i < cosas5.count {
            if cosas5[i].seccion != 5 {
                switch cosas5[i].seccion {
                case 0:
                    cosas0.append(cosas5[i])
                case 1:
                    cosas1.append(cosas5[i])
                case 2:
                    cosas2.append(cosas5[i])
                case 3:
                    cosas3.append(cosas5[i])
                case 4:
                    cosas4.append(cosas5[i])
                case 6:
                    cosas6.append(cosas5[i])
                case 7:
                    cosas7.append(cosas5[i])
                case 8:
                    cosas8.append(cosas5[i])
                case 9:
                    cosas9.append(cosas5[i])
                default:
                    print("error al reordenar")
                }
                cosas5.remove(at: i)
            }
            i += 1
        } // for cosas 5
        
        i = 0
        
        while i < cosas6.count {
            if cosas6[i].seccion != 6 {
                switch cosas6[i].seccion {
                case 0:
                    cosas0.append(cosas6[i])
                case 1:
                    cosas1.append(cosas6[i])
                case 2:
                    cosas2.append(cosas6[i])
                case 3:
                    cosas3.append(cosas6[i])
                case 4:
                    cosas4.append(cosas6[i])
                case 5:
                    cosas5.append(cosas6[i])
                case 7:
                    cosas7.append(cosas6[i])
                case 8:
                    cosas8.append(cosas6[i])
                case 9:
                    cosas9.append(cosas6[i])
                default:
                    print("error al reordenar")
                }
                cosas6.remove(at: i)
            }
            i += 1
        } // for cosas 6
        
        i = 0
        
        while i < cosas7.count {
            if cosas7[i].seccion != 7 {
                switch cosas7[i].seccion {
                case 0:
                    cosas0.append(cosas7[i])
                case 1:
                    cosas1.append(cosas7[i])
                case 2:
                    cosas2.append(cosas7[i])
                case 3:
                    cosas3.append(cosas7[i])
                case 4:
                    cosas4.append(cosas7[i])
                case 5:
                    cosas5.append(cosas7[i])
                case 6:
                    cosas6.append(cosas7[i])
                case 8:
                    cosas8.append(cosas7[i])
                case 9:
                    cosas9.append(cosas7[i])
                default:
                    print("error al reordenar")
                }
                cosas7.remove(at: i)
            }
            i += 1
        } // for cosas 7
        
        i = 0
        
        while i < cosas8.count {
            if cosas8[i].seccion != 8 {
                switch cosas8[i].seccion {
                case 0:
                    cosas0.append(cosas8[i])
                case 1:
                    cosas1.append(cosas8[i])
                case 2:
                    cosas2.append(cosas8[i])
                case 3:
                    cosas3.append(cosas8[i])
                case 4:
                    cosas4.append(cosas8[i])
                case 5:
                    cosas5.append(cosas8[i])
                case 6:
                    cosas6.append(cosas8[i])
                case 7:
                    cosas7.append(cosas8[i])
                case 9:
                    cosas9.append(cosas8[i])
                default:
                    print("error al reordenar")
                }
                cosas8.remove(at: i)
            }
            i += 1
        } // for cosas 8
        
        i = 0
        
        while i < cosas9.count {
            if cosas9[i].seccion != 9 {
                switch cosas9[i].seccion {
                case 0:
                    cosas0.append(cosas9[i])
                case 1:
                    cosas1.append(cosas9[i])
                case 2:
                    cosas2.append(cosas9[i])
                case 3:
                    cosas3.append(cosas9[i])
                case 4:
                    cosas4.append(cosas9[i])
                case 5:
                    cosas5.append(cosas9[i])
                case 6:
                    cosas6.append(cosas9[i])
                case 7:
                    cosas7.append(cosas9[i])
                case 8:
                    cosas8.append(cosas9[i])
                default:
                    print("error al reordenar")
                }
                cosas9.remove(at: i)
            }
            i += 1
        } // for cosas 9
        
    }
    
    
}
