//
//  CreateEventViewController.swift
//  Eureka
//
//  Created by Luke Mueller on 15.10.17.
//  Copyright © 2017 Jugend hackt. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    let placeField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Type in a place"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeAction)), animated: true)
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction)), animated: true)
    }
    
    func closeAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func doneAction(_ sender: UIBarButtonItem) {
        print("Ha")
    }


}
