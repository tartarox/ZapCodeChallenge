//
//  ObjectManager.swift
//  ZapCodeChallenge
//
//  Created by Fabio Yudi Takahara on 13/09/16.
//  Copyright © 2016 Fabio Yudi Takahara. All rights reserved.
//

import UIKit

class ObjectManager: NSObject {
    
    class func getImmobileObjects() -> NSArray {
        
        //Retrieve information from Json
        let jsonDictionary = JsonManager.getObjectFromJson("imoveis")
        
        let imovelArray = jsonDictionary.valueForKey("Imoveis")?.valueForKey("Imoveis") as! NSArray
        
        //Create a Array with Immobile objects
        let immobileObjectsArray = [].mutableCopy()
        
        for immobileDictionary in imovelArray {
            
            //Create Immobile Object first
            let immobileObject = ImmobileObject()
            immobileObject.code = immobileDictionary.valueForKey("CodImovel") as! Int
            
            immobileObject.neighborhood =       immobileDictionary.valueForKey("Endereco")!.valueForKey("Bairro") as! String
            immobileObject.cep =                immobileDictionary.valueForKey("Endereco")!.valueForKey("CEP") as! String
            immobileObject.city =               immobileDictionary.valueForKey("Endereco")!.valueForKey("Cidade") as! String
            immobileObject.complement =         immobileDictionary.valueForKey("Endereco")!.valueForKey("Complemento") as! String
            immobileObject.state =              immobileDictionary.valueForKey("Endereco")!.valueForKey("Estado") as! String
            immobileObject.address =            immobileDictionary.valueForKey("Endereco")!.valueForKey("Logradouro") as! String
            immobileObject.number =             immobileDictionary.valueForKey("Endereco")!.valueForKey("Numero") as! String
            immobileObject.fullAddress =        String(format: "%@ - %@", immobileObject.address, immobileObject.neighborhood)
            
            
            if immobileDictionary.valueForKey("PrecoLocacao") != nil {
                immobileObject.locationPrice =      immobileDictionary.valueForKey("PrecoLocacao") as! Int
            }
            
            if immobileDictionary.valueForKey("PrecoVenda") != nil {
                immobileObject.sellPrice =          immobileDictionary.valueForKey("PrecoVenda") as! Int
            }
            
            immobileObject.subTypeImmobile =    immobileDictionary.valueForKey("SubtipoImovel") as! String
            immobileObject.immobileType =       immobileDictionary.valueForKey("TipoImovel") as! String
            immobileObject.zapId =              immobileDictionary.valueForKey("ZapID") as! String
            
            //Manage Photos
            let immobilePhotoArray = [].mutableCopy()
            let photoArray = immobileDictionary.valueForKey("Fotos") as! NSArray
            for photoDictionary in photoArray {
                
                let photoObject = PhotoObject()
                photoObject.codImobiliaria =    photoDictionary.valueForKey("CodImobiliaria") as! Int
                photoObject.photoDescription =  photoDictionary.valueForKey("Descricao") as! String
                photoObject.origin =            photoDictionary.valueForKey("Origem") as! String
                photoObject.main =              photoDictionary.valueForKey("Principal") as! Bool
                photoObject.imageUrl =          photoDictionary.valueForKey("UrlImagem") as! String
                
                immobilePhotoArray.addObject(PhotoObject)
                
                //Set the Main Image
                if photoObject.main {
                    
                    immobileObject.mainImage = photoObject.imageUrl
                    
                }
                
            }
            
            immobileObject.photoArray = immobilePhotoArray as! NSArray
            
            //Manage Price Label to display or hidden
            if immobileObject.locationPrice == 0 {
                
                immobileObject.locationString = ""

            }
            
            immobileObjectsArray.addObject(immobileObject)
        }
 
        return immobileObjectsArray as! NSArray
        
    }
    
    class func getImmobileDetailObjects(immobileCode: String) -> ImmobileDetailObject {
        
        let jsonDictionary = JsonManager.getObjectFromJson(immobileCode)        
        let immobileDetailObject = ImmobileDetailObject()
        
        immobileDetailObject.area =         jsonDictionary.valueForKey("Imovel")!.valueForKey("AreaTotal") as! Int
        immobileDetailObject.areaUtil =     jsonDictionary.valueForKey("Imovel")!.valueForKey("AreaUtil") as! Int
        immobileDetailObject.sleepRoom =    jsonDictionary.valueForKey("Imovel")!.valueForKey("Dormitorios") as! Int
        immobileDetailObject.suits =        jsonDictionary.valueForKey("Imovel")!.valueForKey("Suites") as! Int
        immobileDetailObject.carSeats =     jsonDictionary.valueForKey("Imovel")!.valueForKey("Vagas") as! Int
        
        return immobileDetailObject
    }
}
