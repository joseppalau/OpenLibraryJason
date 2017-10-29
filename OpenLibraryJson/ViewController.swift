//
//  ViewController.swift
//  OpenLibraryJson
//
//  Created by Administrador on 25/10/17.
//  Copyright © 2017 palauturf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tituloText: UILabel!
    
    @IBOutlet weak var autoresText: UILabel!
    
    @IBOutlet weak var imagenPortada: UIImageView!
    
    @IBOutlet weak var numISBN: UITextField!
    
    @IBOutlet weak var estado: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        numISBN.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }

    
    @IBAction func backgroundTap(sender: UIControl) {
        
        numISBN.resignFirstResponder()
        
    }
    
    
    @IBAction func textFieldDoneEditing(sender: UITextField!) {
        
        sender.resignFirstResponder()
        self.autoresText.text = ""
        sincrono()
        
    }
    
    
    func sincrono() {
    
        var listadoAutores: String = ""
        self.tituloText.text = ""
        imagenPortada.image = nil
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(self.numISBN.text!)"
        let url = NSURL(string: urls)
        let datos: NSData? = NSData(contentsOf: url! as URL)
    
        if datos != nil {
            
            do {
                let json = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                let dic1 = json as! NSDictionary
                let dic2 = dic1["ISBN:\(self.numISBN.text!)"] as! NSDictionary
                self.tituloText.text = dic2["title"] as! NSString as String
                let dic3 = dic2["authors"] as! NSArray
                
                var autor: String = ""
                
                for i in 0..<dic3.count {
                
                        let dic = dic3[i] as! NSDictionary
                        autor = dic["name"] as! NSString as String
                        listadoAutores += "\(autor) "
                    }
                
                self.autoresText.text = listadoAutores
                let dic4 = dic2["cover"] as! NSDictionary
                let dic5 = dic4["large"] as! NSString as String
                
                let url = NSURL(string: dic5)
                
                let datos2: NSData? = NSData(contentsOf: url! as URL)
                let imagen = UIImage(data: datos2! as Data)
                imagenPortada.image = imagen
                
                estado.backgroundColor = UIColor(red: 94/255, green: 173/255, blue: 53/255, alpha: 1)
                estado.text = "Conexión Correcta"
            
            }
            catch  {
            
            }
        }
        else {
            estado.backgroundColor = UIColor(red: 170/255, green: 39/255, blue: 59/255, alpha: 1)
            estado.text = "Fallo Conexión"
        }
    }

}
    
/*var nombreAutores: String = ""

 dic3 {
 let dic = dic3[i] as! NSSingleObjectArrayI
 let nombreAutor = dic["name"] as! NSString as String
 nombreautores += nombreAutor + ""
 }
 
 self.autoresText.text = nombreautores
 var nombreautores: String = ""
 */



