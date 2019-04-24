//
//  UtilProtocol.swift
//  WithNovation
//
//  Created by 김주연 on 24/04/2019.
//  Copyright © 2019 김주연. All rights reserved.
//

import UIKit

protocol UtilProtocol {

}

extension UtilProtocol {
    
    func alert(message:String, done:String, view:UIViewController, completion:@escaping(_ ok:Bool) -> Void) {
        
        let alertController = UIAlertController(title:nil, message:message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title:done, style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            completion(true)
        }
        let cancelAction = UIAlertAction(title:"취소", style: UIAlertAction.Style.cancel, handler: { alert in
            completion(false)
        })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        view.present(alertController,animated: true,completion: nil)
        
    }
    
}
