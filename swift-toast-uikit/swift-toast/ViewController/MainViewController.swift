//
//  ViewController.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapToastButton(_ sender: UIButton) {
        let config = ToastConfiguration(background: .color(color: UIColor.red))
        let toast = Toast.text("Hello, World!", config: config)
        toast.show()
    }

}

