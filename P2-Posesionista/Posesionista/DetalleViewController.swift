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
    var nombreVacio = false
    @IBOutlet weak var campoSerie: UITextField!
    var serieVacio = false
    @IBOutlet weak var campoPrecio: UITextField!
    var precioVacio = false
    @IBOutlet weak var labelFecha: UILabel!
    @IBOutlet weak var foto: UIImageView!
    var alerta : UIAlertController!
    @IBOutlet var botonBorrarFoto: UIBarButtonItem!
    
    var cosaADetallar: Cosa! {
        didSet { //Property Observer
            navigationItem.title = self.cosaADetallar.nombre
        }
    }
    let formatoDeFecha : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    } ()
    
    let formatoDePrecio : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    } ()
    
    var inventarioDeImagenes : InventarioDeImagenes!
    var inventarioDeThumbNail : InventarioDeThumbnails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
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
        
        if self.foto.image == nil {
            self.foto.image = UIImage(named: "default.png")
            self.botonBorrarFoto.isEnabled = false
            self.botonBorrarFoto.tintColor = .clear
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.labelFecha.text = formatoDeFecha.string(from: cosaADetallar.fechaDeCreacion)
    }
    
    @objc func didTap() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //revisa cambios mientras se edita el campo nombre
    @IBAction func edicionNombre(_ sender: Any) {
        if (self.campoNombre.text?.isEmpty ?? true) || (self.campoSerie.text?.isEmpty ?? true) || (self.campoPrecio.text?.isEmpty ?? true) {
            navigationController?.navigationBar.isUserInteractionEnabled = false
            navigationController?.navigationBar.tintColor = .lightGray
            
            self.alerta = UIAlertController(title: "No puedes dejar campos vacíos.", message: "", preferredStyle: .alert)
            
            self.alerta.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            
            self.present(self.alerta, animated: true, completion: nil)
            navigationController?.navigationBar.isUserInteractionEnabled = true
            navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2588235294, green: 0.5215686275, blue: 0.9568627451, alpha: 1)
        }
    }
    
    //revisa cambios mientras se edita el campo serie
    @IBAction func edicionSerie(_ sender: Any) {
        if (self.campoNombre.text?.isEmpty ?? true) || (self.campoSerie.text?.isEmpty ?? true) || (self.campoPrecio.text?.isEmpty ?? true) {
            navigationController?.navigationBar.isUserInteractionEnabled = false
            navigationController?.navigationBar.tintColor = .lightGray
            
            self.alerta = UIAlertController(title: "No puedes dejar campos vacíos.", message: "", preferredStyle: .alert)
            
            self.alerta.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            
            self.present(self.alerta, animated: true, completion: nil)
        } else {
            navigationController?.navigationBar.isUserInteractionEnabled = true
            navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2588235294, green: 0.5215686275, blue: 0.9568627451, alpha: 1)
        }
    }
    
    //revisa cambios mientras se edita el campo de precio
    @IBAction func edicionPrecio(_ sender: Any) {
        if (self.campoNombre.text?.isEmpty ?? true) || (self.campoSerie.text?.isEmpty ?? true) || (self.campoPrecio.text?.isEmpty ?? true) {
            navigationController?.navigationBar.isUserInteractionEnabled = false
            navigationController?.navigationBar.tintColor = .lightGray
            
            self.alerta = UIAlertController(title: "No puedes dejar campos vacíos.", message: "", preferredStyle: .alert)
            
            self.alerta.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            
            self.present(self.alerta, animated: true, completion: nil)
        } else {
            navigationController?.navigationBar.isUserInteractionEnabled = true
            navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2588235294, green: 0.5215686275, blue: 0.9568627451, alpha: 1)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
            super.viewWillDisappear(animated)
            cosaADetallar.nombre = self.campoNombre.text ?? ""
            cosaADetallar.numeroDeSerie = self.campoSerie.text ?? ""
            if let valor = campoPrecio.text, let valorInt = formatoDePrecio.number(from: valor) {
                cosaADetallar.valorEnPesos = valorInt.intValue
                
                //si el nuevo valor es menor que 1001 es valido
                if valorInt.intValue < 1001 {
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
                } else { // si no es inyValue lo manda a la secion de ceros
                    cosaADetallar.valorEnPesos = 0
                    cosaADetallar.seccion = 0
                }
                
            } else { // si es mayor lo envia a la seccion de ceros
                cosaADetallar.valorEnPesos = 0
                cosaADetallar.seccion = 0
            }
//        }
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
    
    //borra foto y thumbnail
    @IBAction func borraFoto(_ sender: UIBarButtonItem) {
        self.foto.image = UIImage(named: "default.png")
        self.botonBorrarFoto.isEnabled = false
        self.botonBorrarFoto.tintColor = .clear
        self.inventarioDeImagenes.borraImagen(paraLaLLave: cosaADetallar.llaveCosa)
        self.inventarioDeThumbNail.borraThumb(paraLaLLave: cosaADetallar.llaveCosaT)
    }
    
    //asigna archivo a foto y thumbnail
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagen = info[.originalImage] as! UIImage
        var thumb = info[.originalImage] as! UIImage
        thumb = UIImage.resize(image: thumb, targetSize: CGSize(width: 52, height: 52))
        self.foto.image = imagen
        self.inventarioDeImagenes.setImagen(imagen: imagen, paraLaLLave: cosaADetallar.llaveCosa)
        self.inventarioDeThumbNail.setThumbnail(thumb: thumb, paraLaLLave: cosaADetallar.llaveCosaT)
        dismiss(animated: true, completion: nil)
        self.botonBorrarFoto.isEnabled = true
        self.botonBorrarFoto.tintColor  = #colorLiteral(red: 0.2588235294, green: 0.5215686275, blue: 0.9568627451, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fecha" {
                let fechaVC = segue.destination as! FechaViewController
                fechaVC.cosaADetallar = self.cosaADetallar
        }
    }

}
