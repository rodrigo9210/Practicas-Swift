//
//  Persona.swift
//  P0-RFC
//
//  Created by Rodrigo on 9/27/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

protocol Persona {
    var fecha : DateComponents { get set }
    var siglasFecha: String { get set }
    var siglasNombre: String { get set }
    var claveDiferenciadora: String { get set }
    var digitoVerificador: String { get set }
    var nombreParaGenerarClave: String { get set }
    var RFC : String { get set }
    
    func validaFecha() -> Bool
}
