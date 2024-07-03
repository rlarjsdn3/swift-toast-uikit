//
//  SecondViewController.swift
//  swift-toast
//
//  Created by 김건우 on 7/3/24.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapToastButton(_ sender: UIButton) {
        let config = ToastConfiguration(enteringAnimation: .scaleAndSlide(scaleX: 0.9, scaleY: 0.9, x: 0, y: -100))
        let toast = Toast.text("Hello, World!", subtitle: "UIKit", config: config)
        toast.show()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
