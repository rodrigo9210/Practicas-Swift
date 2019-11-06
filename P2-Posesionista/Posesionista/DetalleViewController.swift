//
//  DetalleViewController.swift
//  Posesionista
//
//  Created by Arce Anguiano Rodrigo Roberto on 10/16/19.
//  Copyright © 2019 Arce Anguiano Rodrigo Roberto. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var campoNombre: UITextField!
    @IBOutlet weak var campoSerie: UITextField!
    @IBOutlet weak var campoPrecio: UITextField!
    @IBOutlet weak var labelFecha: UILabel!
    @IBOutlet weak var foto: UIImageView!
    
    
    var cosaADetallar: Cosa! {
        didSet { //Property Observer
            navigationItem.title = self.cosaADetallar.nombre
        }
    }
    let formatoDeFecha : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    } ()
    
    let formatoDePrecio : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    } ()
    
    var inventarioDeImagenes : InventarioDeImagenes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.campoNombre.delegate = self
        self.campoPrecio.delegate = self
        self.campoPrecio.keyboardType = UIKeyboardType.numberPad
        self.campoSerie.delegate = self
        self.campoNombre.text = cosaADetallar.nombre
        self.campoSerie.text = cosaADetallar.numeroDeSerie
//        self.campoPrecio.text = "$\(cosaADetallar.valorEnPesos)"
//        self.labelFecha.text = "\(cosaADetallar.fechaDeCreacion)"
        self.campoPrecio.text = formatoDePrecio.string(from: NSNumber(value: self.cosaADetallar.valorEnPesos))
        self.labelFecha.text = formatoDeFecha.string(from: cosaADetallar.fechaDeCreacion)
        self.foto.image = self.inventarioDeImagenes.getImagen(paraLaLLave: cosaADetallar.llaveCosa)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cosaADetallar.nombre = self.campoNombre.text ?? ""
        cosaADetallar.numeroDeSerie = self.campoSerie.text ?? ""
        if let valor = campoPrecio.text, let valorInt = formatoDePrecio.number(from: valor) {
            cosaADetallar.valorEnPesos = valorInt.intValue
            
            switch valorInt.intValue {
            case 0..<100:
                cosaADetallar.seccion = 0
            case 100..<200:
                cosaADetallar.seccion = 1
            case 200..<300:
                cosaADetallar.seccion = 2
            case 300..<400:
                cosaADetallar.seccion = 3
            case 400..<500:
                cosaADetallar.seccion = 4
            case 500..<600:
                cosaADetallar.seccion = 5
            case 600..<700:
                cosaADetallar.seccion = 6
            case 700..<800:
                cosaADetallar.seccion = 7
            case 800..<900:
                cosaADetallar.seccion = 8
            case 900..<1001:
                cosaADetallar.seccion = 9
            default:
                print("Esto no pasa")
            }
            
        } else {
            cosaADetallar.valorEnPesos = 0
            cosaADetallar.seccion = 0
        }
    }
    
    @IBAction func tomaFoto(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagen = info[.originalImage] as! UIImage
        self.foto.image = imagen
        self.inventarioDeImagenes.setImagen(imagen: imagen, paraLaLLave: cosaADetallar.llaveCosa)
        dismiss(animated: true, completion: nil)
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
