//
//  StreamsViewController.swift
//  Eureka
//
//  Created by Luke Mueller on 15.10.17.
//  Copyright © 2017 Jugend hackt. All rights reserved.
//

import UIKit

class StreamsViewController: UIViewController {
    
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Planned", "Done"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
        return sc
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView = segmentedControl
        
        NSLayoutConstraint.activate([
        ])
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openCreatorAction)), animated: true)
    }
    
    func segmentControlChanged(_ sender: UISegmentedControl) {
        print("Hello")
    }
    
    func openCreatorAction(_ sender: UIBarButtonItem) {
        present(UINavigationController(rootViewController: CreateEventViewController()), animated: true, completion: nil)
    }

}
