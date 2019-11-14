//
//  FechaViewController.swift
//  Posesionista
//
//  Created by Rodrigo on 11/11/19.
//  Copyright © 2019 Arce Anguiano Rodrigo Roberto. All rights reserved.
//

import UIKit

class FechaViewController: UIViewController, UINavigationControllerDelegate{

    @IBOutlet var pickerFecha: UIDatePicker!
    
    var cosaADetallar: Cosa!
    
    let formatoDeFecha : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    } ()
    
    //toma el valor de la cosa y lo pone en el titulo
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        navigationItem.title = formatoDeFecha.string(from: cosaADetallar.fechaDeCreacion)
        self.pickerFecha.maximumDate = Date() //impide fechas futuras
    }
    
    //revisa cambios en el picker de fecha
    @IBAction func cambiaFecha(_ sender: UIDatePicker) {
        cosaADetallar.fechaDeCreacion = self.pickerFecha.date
        print("\(formatoDeFecha.string(from: cosaADetallar.fechaDeCreacion))")
    }
    
    //asigna la fecha de creacion antes de que la vista desaparezca
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cosaADetallar.fechaDeCreacion = self.pickerFecha.date
        print("\(String(describing: cosaADetallar.fechaDeCreacion))")
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
