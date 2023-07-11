//
//  TransitionViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/11.
//

import UIKit

//화면 전환을 하는 다양한 메서드를 정리
//필요한 곳에 선택해서 사용할 것

class TransitionViewController: UIViewController {
    
    //샘플 버튼 UI
    lazy var sampleButton:UIButton = {
        let button = UIButton()
        //버튼에 타겟을 추가 -> 버튼 클릭 시 실행되는 메서드를 action에 정의
        //이때, action에 넘겨줄 함수는 @objc 형식으로 작성
        button.addTarget(self, action: #selector(ButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    //이때, action에 넘겨줄 함수
    @objc func ButtonTapped(_ sender: UIButton) {
        // 내부에 버튼 클릭 시 일어날 동작을 코드로 정의
    }
    
    // 샘플 뷰컨트롤러
    let viewcontroller = TransitionViewController()
    
    // modal view
    @objc func modalViewButtonTapped(_ sender: UIButton) {
        // 넘어갈 VC, 실행여부를 파라미터로 받음
        present(viewcontroller, animated: true)
    }
    
    //네비게이션 스택을 활용한 방식
    //루트 VC(네비게이션 컨트롤러를 소유하고 있는 VC)를 기준으로 push(스택에 추가), pop(스택에서 제거)를 활용해 화면 전환을 실행
    
    // push view
    @objc func pushViewButtonTapped(_ sender: UIButton) {
        // 넘어갈 VC, 실행여부를 파라미터로 받음
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    // pop view
    @objc func popViewButtonTapped(_ sender: UIButton) {
        //뒤로 가기 버튼 클릭 시, 현재 VC를 네비게이션 스택에서 제거
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
