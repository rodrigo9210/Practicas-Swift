//
//  Extensiones.swift
//  Posesionista
//
//  Created by Rodrigo on 11/11/19.
//  Copyright © 2019 Arce Anguiano Rodrigo Roberto. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    //toma una imagen y un tamaño objetivo para entregar una copia de la imagen con otro tamaño
    class func resize(image: UIImage, targetSize: CGSize) -> UIImage {
        let tam = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var nuevoTam: CGSize
        if widthRatio > heightRatio {
            nuevoTam = CGSize(width: tam.width * heightRatio, height: tam.height * heightRatio)
        } else {
            nuevoTam = CGSize(width: tam.width * widthRatio,  height: tam.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: nuevoTam.width, height: nuevoTam.height)
        
        UIGraphicsBeginImageContextWithOptions(nuevoTam, false, 0)
        image.draw(in: rect)
        let nuevaImagen = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return nuevaImagen!
    }
}
