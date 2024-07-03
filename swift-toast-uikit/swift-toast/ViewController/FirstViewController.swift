//
//  SubViewController.swift
//  swift-toast
//
//  Created by 김건우 on 7/3/24.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapToastButton(_ sender: Any) {
        let viewConfig = ToastViewConfiguration(minWidth: 300)
//        let config = ToastConfiguration(allowToastOverlap: false)
        let config = ToastConfiguration(background: .color(color: UIColor.red))
        let toast = Toast.default(
            image: UIImage(systemName: "trash")!,
            title: "파일이 삭제되었습니다",
            viewConfig: viewConfig,
            config: config
        )
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
