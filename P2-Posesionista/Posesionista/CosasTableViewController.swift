//
//  CosasTableViewController.swift
//  Posesionista
//
//  Created by Arce Anguiano Rodrigo Roberto on 10/9/19.
//  Copyright © 2019 Arce Anguiano Rodrigo Roberto. All rights reserved.
//

import UIKit

class CosasTableViewController: UITableViewController {

    var miInventario : Inventario!
    let inventarioDeImagenes = InventarioDeImagenes()
    var alerta : UIAlertController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let imagen = UIImageView(image: UIImage(named: "fondo.jpg"))
        self.tableView.backgroundView = imagen
        miInventario.verificaSeccionCosa()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var suma = 0

            switch section {
            case 0:
                for cosa in self.miInventario.cosas0 {
                    suma += cosa.valorEnPesos
                }
                return "# De cosas: \(self.miInventario.cosas0.count)       $:\(suma)"

            case 1:
                for cosa in self.miInventario.cosas1 {
                    suma += cosa.valorEnPesos
                }
                return "# De cosas: \(self.miInventario.cosas1.count)       $:\(suma)"

            case 2:
                for cosa in self.miInventario.cosas2 {
                    suma += cosa.valorEnPesos
                }
                return "# De cosas: \(self.miInventario.cosas2.count)       $:\(suma)"

            case 3:
                for cosa in self.miInventario.cosas3 {
                    suma += cosa.valorEnPesos
                }
                return "# De cosas: \(self.miInventario.cosas3.count)       $:\(suma)"

            case 4:
                for cosa in self.miInventario.cosas4 {
                    suma += cosa.valorEnPesos
                }
                return "# De cosas: \(self.miInventario.cosas4.count)       $:\(suma)"

            case 5:
                for cosa in self.miInventario.cosas5 {
                    suma += cosa.valorEnPesos
                }
                return "# De cosas: \(self.miInventario.cosas5.count)       $:\(suma)"

            case 6:
                for cosa in self.miInventario.cosas6 {
                    suma += cosa.valorEnPesos
                }
                return "# De cosas: \(self.miInventario.cosas6.count)       $:\(suma)"

            case 7:
                for cosa in self.miInventario.cosas7 {
                    suma += cosa.valorEnPesos
                }
                return "# De cosas: \(self.miInventario.cosas7.count)       $:\(suma)"

            case 8:
                for cosa in self.miInventario.cosas8 {
                    suma += cosa.valorEnPesos
                }
                return "# De cosas: \(self.miInventario.cosas8.count)       $:\(suma)"

            case 9:
                for cosa in self.miInventario.cosas9 {
                    suma += cosa.valorEnPesos
                }
                return "# De cosas: \(self.miInventario.cosas9.count)       $:\(suma)"
            case 10:
                return "FIN DEL INVENTARIO"
            default:
                return "hola"
            }

        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 11
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let celdaEncabezado = tableView.dequeueReusableCell(withIdentifier: "encabezadoCell") as! EncabezadoTableViewCell
        let vista = UIView()
        celdaEncabezado.contentView.backgroundColor = .lightGray
        var suma = 0
        
        switch (section) {
        case 0:
            celdaEncabezado.labelEncabezado.text = "00"
        case 1:
            celdaEncabezado.labelEncabezado.text = "100"
        case 2:
            celdaEncabezado.labelEncabezado.text = "200"
        case 3:
            celdaEncabezado.labelEncabezado.text = "300"
        case 4:
            celdaEncabezado.labelEncabezado.text = "400"
        case 5:
            celdaEncabezado.labelEncabezado.text = "500"
        case 6:
            celdaEncabezado.labelEncabezado.text = "600"
        case 7:
            celdaEncabezado.labelEncabezado.text = "700"
        case 8:
            celdaEncabezado.labelEncabezado.text = "800"
        case 9:
            celdaEncabezado.labelEncabezado.text = "900"
        case 10:
            for cosa in self.miInventario.todasLasCosas {
                suma += cosa.valorEnPesos
            }
            celdaEncabezado.labelEncabezado.text = "# TOTAL De cosas: \(self.miInventario.todasLasCosas.count)       $ TOTAL :\(suma)"
            celdaEncabezado.contentView.backgroundColor = .yellow
        default:
            celdaEncabezado.labelEncabezado.text = "Error"
        }
        
        celdaEncabezado.labelEncabezado.sizeToFit()
//        vista.addSubview(celdaEncabezado)
        
        celdaEncabezado.contentView.addSubview(vista)
        
        return celdaEncabezado.contentView
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return self.miInventario.cosas0.count
        case 1:
            return self.miInventario.cosas1.count
        case 2:
            return self.miInventario.cosas2.count
        case 3:
            return self.miInventario.cosas3.count
        case 4:
            return self.miInventario.cosas4.count
        case 5:
            return self.miInventario.cosas5.count
        case 6:
            return self.miInventario.cosas6.count
        case 7:
            return self.miInventario.cosas7.count
        case 8:
            return self.miInventario.cosas8.count
        case 9:
            return self.miInventario.cosas9.count
        case 10:
            return 0
        default:
            return self.miInventario.todasLasCosas.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cosaCell", for: indexPath) as! CosaTableViewCell
        var item : Cosa!
        
        switch indexPath.section {
        case 0:
            item = self.miInventario.cosas0[indexPath.row]
        case 1:
            item = self.miInventario.cosas1[indexPath.row]
        case 2:
            item = self.miInventario.cosas2[indexPath.row]
        case 3:
            item = self.miInventario.cosas3[indexPath.row]
        case 4:
            item = self.miInventario.cosas4[indexPath.row]
        case 5:
            item = self.miInventario.cosas5[indexPath.row]
        case 6:
            item = self.miInventario.cosas6[indexPath.row]
        case 7:
            item = self.miInventario.cosas7[indexPath.row]
        case 8:
            item = self.miInventario.cosas8[indexPath.row]
        case 9:
            item = self.miInventario.cosas9[indexPath.row]
        default:
            print("error al cargar celdas")
        }
        
        cell.labelDeNombre.text = item.nombre
        cell.labelDePrecio.text = "$\(item.valorEnPesos)"
        cell.labelDeSerie.text = item.numeroDeSerie
//        cell.textLabel?.text = item.nombre
//        cell.detailTextLabel?.text = "$\(item.valorEnPesos)"
        
        return cell
    }
    
    
//    @IBAction func cambiaModoDeEdicion(_ sender: UIButton) {
//        if isEditing {
//            sender.setTitle("Editar", for: .normal)
//            setEditing(false, animated: true)
//        } else {
//            sender.setTitle("Listo", for: .normal)
//            setEditing(true, animated: true)
//        }
//    }
    
    
    @IBAction func añadeCosa(_ sender: UIBarButtonItem) {
        let nuevaCosa = miInventario.creaCosa()
        var indiceDeNuevaCosa : Int!
        var indexPath = IndexPath()
        
        switch nuevaCosa.seccion {
        case 0:
            indiceDeNuevaCosa = miInventario.cosas0.firstIndex(of: nuevaCosa)!
            indexPath = IndexPath(row: indiceDeNuevaCosa, section: 0)
        case 1:
            indiceDeNuevaCosa = miInventario.cosas1.firstIndex(of: nuevaCosa)!
            indexPath = IndexPath(row: indiceDeNuevaCosa, section: 1)
        case 2:
            indiceDeNuevaCosa = miInventario.cosas2.firstIndex(of: nuevaCosa)!
            indexPath = IndexPath(row: indiceDeNuevaCosa, section: 2)
        case 3:
            indiceDeNuevaCosa = miInventario.cosas3.firstIndex(of: nuevaCosa)!
            indexPath = IndexPath(row: indiceDeNuevaCosa, section: 3)
        case 4:
            indiceDeNuevaCosa = miInventario.cosas4.firstIndex(of: nuevaCosa)!
            indexPath = IndexPath(row: indiceDeNuevaCosa, section: 4)
        case 5:
            indiceDeNuevaCosa = miInventario.cosas5.firstIndex(of: nuevaCosa)!
            indexPath = IndexPath(row: indiceDeNuevaCosa, section: 5)
        case 6:
            indiceDeNuevaCosa = miInventario.cosas6.firstIndex(of: nuevaCosa)!
            indexPath = IndexPath(row: indiceDeNuevaCosa, section: 6)
        case 7:
            indiceDeNuevaCosa = miInventario.cosas7.firstIndex(of: nuevaCosa)!
            indexPath = IndexPath(row: indiceDeNuevaCosa, section: 7)
        case 8:
            indiceDeNuevaCosa = miInventario.cosas8.firstIndex(of: nuevaCosa)!
            indexPath = IndexPath(row: indiceDeNuevaCosa, section: 8)
        case 9:
            indiceDeNuevaCosa = miInventario.cosas9.firstIndex(of: nuevaCosa)!
            indexPath = IndexPath(row: indiceDeNuevaCosa, section: 9)
        default:
            print("error al añadir cosa nueva")
        }
        
        //let ultimaFila = tableView.numberOfRows(inSection: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //cong¡figura alerta
            self.alerta = UIAlertController(title: "¿Seguro que quiere borrar?", message: "Confirma o cancela", preferredStyle: .alert)
            
            self.alerta.addAction(UIAlertAction(title:"OK", style: .default, handler:  { action in
                // Delete the row from the data source
                var cosaABorrar : Cosa!
                
                switch indexPath.section {
                case 0:
                    cosaABorrar = self.miInventario.cosas0[indexPath.row]
                case 1:
                    cosaABorrar = self.miInventario.cosas1[indexPath.row]
                case 2:
                    cosaABorrar = self.miInventario.cosas2[indexPath.row]
                case 3:
                    cosaABorrar = self.miInventario.cosas3[indexPath.row]
                case 4:
                    cosaABorrar = self.miInventario.cosas4[indexPath.row]
                case 5:
                    cosaABorrar = self.miInventario.cosas5[indexPath.row]
                case 6:
                    cosaABorrar = self.miInventario.cosas6[indexPath.row]
                case 7:
                    cosaABorrar = self.miInventario.cosas7[indexPath.row]
                case 8:
                    cosaABorrar = self.miInventario.cosas8[indexPath.row]
                case 9:
                    cosaABorrar = self.miInventario.cosas9[indexPath.row]
                default:
                    print("error al borrar cosa")
                }
                
                self.miInventario.eliminaCosa(cosaAELiminar: cosaABorrar)
                self.inventarioDeImagenes.borraImagen(paraLaLLave: cosaABorrar.llaveCosa)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }))
            
            self.alerta.addAction(UIAlertAction(title:"Cancelar", style: .default, handler: nil))
            
            self.present(self.alerta, animated: true, completion: nil)
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        if fromIndexPath.section == to.section {
            miInventario.reordena(de: fromIndexPath.row, hacia: to.row, seccion: to.section)
        } else {
            tableView.reloadData()
        }
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["00","100","200","300","400","500","600","700","800","900"]
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MuestraDetalle" {
            if let filaSeleccionada = tableView.indexPathForSelectedRow {
                let detalleVC = segue.destination as! DetalleViewController
                
                switch filaSeleccionada.section {
                case 0:
                    detalleVC.cosaADetallar = miInventario.cosas0[filaSeleccionada.row]
                case 1:
                    detalleVC.cosaADetallar = miInventario.cosas1[filaSeleccionada.row]
                case 2:
                    detalleVC.cosaADetallar = miInventario.cosas2[filaSeleccionada.row]
                case 3:
                    detalleVC.cosaADetallar = miInventario.cosas3[filaSeleccionada.row]
                case 4:
                    detalleVC.cosaADetallar = miInventario.cosas4[filaSeleccionada.row]
                case 5:
                    detalleVC.cosaADetallar = miInventario.cosas5[filaSeleccionada.row]
                case 6:
                    detalleVC.cosaADetallar = miInventario.cosas6[filaSeleccionada.row]
                case 7:
                    detalleVC.cosaADetallar = miInventario.cosas7[filaSeleccionada.row]
                case 8:
                    detalleVC.cosaADetallar = miInventario.cosas8[filaSeleccionada.row]
                case 9:
                    detalleVC.cosaADetallar = miInventario.cosas9[filaSeleccionada.row]
                default:
                    print("error en segue")
                }
                
                detalleVC.inventarioDeImagenes = self.inventarioDeImagenes
            }
        }
    }
    

}
