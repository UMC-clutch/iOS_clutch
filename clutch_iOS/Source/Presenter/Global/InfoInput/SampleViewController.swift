//
//  SampleViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/21.
//

import UIKit

class SampleViewController: UIViewController {
    
    let textinput2 = TextInputView()
    let textinput = TextInputView()
    let ui = CheckContainer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Clutch.mainWhite
        self.view.addSubview(ui)
        self.view.addSubview(textinput)
        self.view.addSubview(textinput2)
        constraint()
    }
    
    func constraint() {
        ui.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(200)

        }
        
        textinput.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(100)
        }
        
        textinput2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(300)
        }
    }

}
