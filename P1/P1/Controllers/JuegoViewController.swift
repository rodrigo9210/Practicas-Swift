//
//  JuegoViewController.swift
//  P1
//
//  Created by Rodrigo on 10/14/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit
import AVFoundation

class JuegoViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var sonido: AVAudioPlayer?
    @IBOutlet weak var labelDePuntuacion: UILabel!
    var puntuacion: Int!
    var coleccionDeObstaculos: [UIView]!
    
    var animador: UIDynamicAnimator!
    var colisionador: UICollisionBehavior!
    var pelotaDinamica: UIDynamicItemBehavior!
    var raquetaDinamica: UIDynamicItemBehavior!
    var empujador: UIPushBehavior!
    
    var pelota: UIView!
    var raqueta: UIView!
    var centroDeRaqueta: CGPoint!
    var piso : UIBezierPath!
    var alerta : UIAlertController!
    
    override func viewDidLoad() {
        self.labelDePuntuacion.text = "0"
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reproduceSonido(archivo: "inicio1.mp3")
        
        self.puntuacion = 0
        self.labelDePuntuacion.text = "\(self.puntuacion!)"
        self.animador = UIDynamicAnimator(referenceView: view)
        self.coleccionDeObstaculos = []
        
        //Crea Pelota
        self.pelota = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        self.pelota.backgroundColor = .orange
        self.pelota.layer.cornerRadius = 25.0
        self.pelota.layer.borderWidth = 0.0
        
        //Crea raqueta
        self.raqueta = UIView(frame: CGRect(x: Int(self.view.frame.maxX / 2) - 75, y: Int(self.view.frame.maxY - 45), width: Int(self.view.frame.width / 6), height:  Int(self.view.frame.height / 20)))
        self.raqueta.backgroundColor = .green
        self.centroDeRaqueta = self.raqueta.center
        
        //Agrega elementos a la vista
        self.view.addSubview(pelota)
        self.view.addSubview(raqueta)
        
        //inicializa manejadores de fisica y agregales elementos
        self.colisionador = UICollisionBehavior(items: [pelota, raqueta])
        self.pelotaDinamica = UIDynamicItemBehavior(items: [pelota])
        self.raquetaDinamica = UIDynamicItemBehavior(items: [raqueta])
        self.empujador = UIPushBehavior(items: [pelota], mode: .instantaneous)
        
        //configura empujador
        self.empujador.pushDirection = CGVector(dx: 1, dy: 1)
        self.empujador.magnitude = 1
        
        //agrega bordes independientes
        self.colisionador.addBoundary(withIdentifier: NSString("Piso"), from: CGPoint(x: 0, y: self.view.frame.maxY), to: CGPoint(x: self.view.frame.maxX, y: self.view.frame.maxY))
        self.colisionador.addBoundary(withIdentifier: NSString("Techo"), from: CGPoint(x: 0, y: 0), to: CGPoint(x: self.view.frame.maxX, y: 0))
        self.colisionador.addBoundary(withIdentifier: NSString("Izquierda"), from: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: self.view.frame.maxY))
        self.colisionador.addBoundary(withIdentifier: NSString("Derecha"), from: CGPoint(x: self.view.frame.maxX, y: 0), to: CGPoint(x: self.view.frame.maxX, y: self.view.frame.maxY))
        
        //configura dinamismo de la pelota
        self.pelotaDinamica.elasticity = 1.0
        self.pelotaDinamica.resistance = 0.0
        self.pelotaDinamica.friction = 0.0
        self.pelotaDinamica.allowsRotation = false
        
        //configura dinamismo de la raqueta
        self.raquetaDinamica.density = 100000.0
        self.raquetaDinamica.allowsRotation = false
        
        //Agrega manejadores al animador
        self.animador.addBehavior(self.colisionador)
        self.colisionador.collisionMode = .everything
        self.colisionador.collisionDelegate = self
        self.animador.addBehavior(self.pelotaDinamica)
        self.animador.addBehavior(self.raquetaDinamica)
        self.animador.addBehavior(self.empujador)
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self.view)
        
        let yPoint = self.centroDeRaqueta.y
        let centro = CGPoint(x: touchLocation.x, y: yPoint)
        
        self.raqueta.center = centro
        self.animador.updateItem(usingCurrentState: self.raqueta)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        //si la pelota toca el piso
        if identifier as? String == "Piso" && item as? UIView == self.pelota {
            reproduceSonido(archivo: "fin1.mp3")
            
            //cong¡figura alerta
            self.alerta = UIAlertController(title: "Perdiste", message: "Fin del Juego", preferredStyle: .alert)
            
            //configura la accion que dispara la alerta
            self.alerta.addAction(UIAlertAction(title:"OK", style: .default, handler:  {
                action in self.performSegue(withIdentifier: "sugue", sender: self)
            }))
            
            //remueve la pelota, su dinamismo y los limites de la pantalla
            self.pelotaDinamica.removeItem(self.pelota)
            self.pelota.removeFromSuperview()
            self.colisionador.removeAllBoundaries()
            
            //presenta la alera
            self.present(self.alerta, animated: true, completion: nil)
        }
        //si el contacto es con otro borde reproduce otro sonido
        else if identifier as? String == "Techo" || identifier as? String == "Izquierda" || identifier as? String == "Derecha"{
            reproduceSonido(archivo: "pared1.mp3")
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        
        //configura acciones para contacto entre raqueta y pelota
        if item1 as? UIView == self.pelota && item2 as? UIView == self.raqueta {
            reproduceSonido(archivo: "raqueta1.mp3")
            let blueValue = CGFloat.random(in: 0 ..< 1)
            let greenValue = CGFloat.random(in: 0 ..< 1)
            let redValue = CGFloat.random(in: 0 ..< 1)

            self.pelota.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
            
            //Suma puntos y actualiza etiqueta
            self.puntuacion += 1
            self.labelDePuntuacion.text = "\(self.puntuacion!)"
            self.labelDePuntuacion.sizeToFit()
            
            //agrega obstaculos cada 10 puntos
            if Double(self.puntuacion).remainder(dividingBy: 10) == 0 {
            
                var obstaculoValido = false
                while !obstaculoValido {
                
                    //genera parametros del obstaculo
                    var colisiona = false
                    let tipo = Int.random(in: 1...3)
                    let largo = 30 * CGFloat(tipo)
                    let x = CGFloat.random(in: 0...self.view.frame.maxX)
                    let y = CGFloat.random(in: 0...(self.view.frame.maxY * 0.6))
                
                    //genera obstaculo con parametros y agregalo transparente a la vista
                    let obstaculo = UIView(frame: CGRect(x: x, y: y, width: largo, height: 30))
                    obstaculo.backgroundColor = .clear
                    self.view.addSubview(obstaculo)
                    
                    //si se sale del margen cambia la condicion para que se salte la siguiente condicion
                    if (x + (largo * 2)) > self.view.frame.maxX {
                        obstaculoValido = true
                    }
                
                    //si no ha cambiado la condicion y no hay obstaculos previos
                    if self.coleccionDeObstaculos.isEmpty && !obstaculoValido{
                        //configura dinamismo del obstaculo
                        self.coleccionDeObstaculos.append(obstaculo)
                        let obstaculoDinamico = UIDynamicItemBehavior(items: [obstaculo])
                        obstaculoDinamico.isAnchored = true
                        obstaculoDinamico.allowsRotation = false
                        self.colisionador.addItem(obstaculo)
                        self.animador.addBehavior(obstaculoDinamico)
                        obstaculoValido = true
                    } else if !obstaculoValido{ // si la coleccion ya tiene elementos
                        var i = 0
                        colisiona = false
                        //revisa que no colisione con los obstaculos previamente añadidos
                        while i < self.coleccionDeObstaculos.count && !colisiona {
                            if obstaculo.frame.intersects(self.coleccionDeObstaculos[i].frame) {
                                colisiona = true
                            }
                            i += 1
                        }//while colisiona con obstaculos
                        
                    }//else
                    
                    //si colisiona remuevelo de la vista
                    if colisiona {
                        obstaculo.removeFromSuperview()
                    } else { //sino lo configura
                        switch tipo{ //cambio de color segun el tipo
                        case 1:
                            obstaculo.backgroundColor = .gray
                            obstaculo.alpha = 0.8
                        case 2:
                            obstaculo.backgroundColor = .black
                            obstaculo.alpha = 0.8
                        case 3:
                            obstaculo.backgroundColor = .lightGray
                            obstaculo.alpha = 0.4
                        default:
                            print("Esto no deberia pasar")
                        }//switch colores
                        
                        //configura dinamismo
                        self.coleccionDeObstaculos.append(obstaculo)
                        let obstaculoDinamico = UIDynamicItemBehavior(items: [obstaculo])
                        obstaculoDinamico.isAnchored = true
                        obstaculoDinamico.allowsRotation = false
                        self.colisionador.addItem(obstaculo)
                        self.animador.addBehavior(obstaculoDinamico)
                        obstaculoValido = true
                    }//else no colisiona
                    
                }//while obstaculoValido
                
            }//if cada numero de obstaculos
            
        }// if colision
    }//func cllissionBehavior
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is MarcadoresViewController
        {
            let siguiente = segue.destination as? MarcadoresViewController
            siguiente?.puntos = Int(self.labelDePuntuacion.text!)
        }
    }
    
    func reproduceSonido(archivo: String) {
        let path = Bundle.main.path(forResource: archivo, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            sonido = try AVAudioPlayer(contentsOf: url)
            sonido?.play()
        } catch {
            // couldn't load file :(
        }
    }

}//CLASS
