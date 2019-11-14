//
//  InventarioDeThumbnails.swift
//  Posesionista
//
//  Created by Rodrigo on 11/11/19.
//  Copyright © 2019 Arce Anguiano Rodrigo Roberto. All rights reserved.
//

import UIKit

class InventarioDeThumbnails {
    
    let cache = NSCache<NSString, UIImage>()
    
    func setThumbnail(thumb: UIImage, paraLaLLave llave: String){
        cache.setObject(thumb, forKey: llave as NSString)
        let url = urlDeThumbEnDisco(paraLlave: llave)
        if let data = thumb.jpegData(compressionQuality: 0.5) {
            try? data.write(to: url, options: [.atomic])
        }
    }
    
    func borraThumb(paraLaLLave llave: String){
        cache.removeObject(forKey: llave as NSString)
        try? FileManager.default.removeItem(at: urlDeThumbEnDisco(paraLlave: llave))
    }
    
    func getThumb(paraLaLLave llave: String) -> UIImage?{
        if let thumbExistente = cache.object(forKey: llave as NSString) {
            return thumbExistente
        }
        
        let url = urlDeThumbEnDisco(paraLlave: llave)
        guard let thumbEnDisco = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(thumbEnDisco, forKey: llave as NSString)
        return thumbEnDisco
    }
    
    func urlDeThumbEnDisco(paraLlave llave: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(llave)
    }
    
}//CLASS
