//
//  ClutchIntroViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/01.
//
import UIKit
import SnapKit
import SwiftyGif

class ClutchIntroViewController: UIViewController, UIScrollViewDelegate {
    //MARK: - UI propereties
    lazy var navigationBar = UINavigationBar()
    
    //스크롤을 위한 스크롤 뷰
    lazy var scrollview:UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    //스크롤 뷰 안에 들어갈 내용을 표시할 뷰
    let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var clutchGraphic:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Clutch.mainGreen
        
        return view
    }()
    
    lazy var gifImage:UIImageView = {
        do {
            let gif = try UIImage(gifName: "report_done.gif")
            let imageview = UIImageView(gifImage: gif, loopCount: -1) // Will loop 3 forever
            
            return imageview
        }
        catch {
            let imageView = UIImageView()
            let iamge = UIImage(named: "clutch_logo")
            imageView.image = iamge

            return imageView
        }
    }()
    
    lazy var clutchIntroTitle:UILabel = {
        let label = UILabel()
        let text = "클러치를 소개할게요!"
        label.text = text
        label.font = .Clutch.headtitlebold
        label.textColor = .black
        
        return label
    }()
    
    lazy var mainCopyTextView:UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        view.layer.cornerRadius = 18
        
        return view
    }()
    
    lazy var mainCopyText:UILabel = {
        let label = UILabel()
        let text = "클러치는 최근 불거진 사회적 이슈인 ‘전세 사기’를\n예방하고,해결하고자 하는 서비스 입니다."
        label.text = text
        label.font = .Clutch.baseMedium
        label.textColor = .black
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var clutchIntroText:UILabel = {
        let label = UILabel()
        
        let text = "공시 지가에 의한 시세를 파악해, 계약 전에 전세사기 위험성을 체크할 수 있는 로직을 제공합니다.\n또한, 전세 사기 신고 접수 서비스를 통해 전세 사기 피해를 구제하고 피해금액을 피해자에게 제공합니다.\n\n이를 통해 법원에서 공시한 연 12%의 이율로 경제적 가치를 안정적으로 얻을 수 있으며, 사회적 문제로 대두된 보증금 미반환 피해 사고를 해결한다는 점에서 사회적 가치도 창출합니다.\n\n궁극적으로 저희 서비스가 잘 활성화 되어, 이러한 피해자가 0명/ 피해금액이 0원이 되는 것을 목표합니다."
        label.text = text
        label.font = .Clutch.baseMedium
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    //스크롤 기능을 탑재한 버튼
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        button.backgroundColor = .Clutch.mainDarkGreen
        // Highlighted 상태일 때 배경색
        let iamge = image(withColor: .Clutch.mainGreen!)
        button.setBackgroundImage(iamge, for: .highlighted)
        
        button.layer.shadowColor = UIColor.Clutch.mainDarkGreen?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 30
        button.layer.shadowOpacity = 0.8
        button.layer.masksToBounds = false
        return button
    }()
    
    //MARK: - define method
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextButton.layer.shadowPath = UIBezierPath(roundedRect: nextButton.bounds, cornerRadius: nextButton.layer.cornerRadius).cgPath
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        constraints()
    }
    //뷰관련 셋
    func setView() {
        addsubview()
        setscrollview()
        setNavigationBar()
        self.view.backgroundColor = .Clutch.mainWhite
    }
    //addsubview
    func addsubview() {
        [scrollview, navigationBar, nextButton].forEach { view in
            self.view.addSubview(view)
        }
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        [clutchGraphic, mainCopyTextView, mainCopyText, clutchIntroTitle, clutchIntroText].forEach { view in
            contentView.addSubview(view)
        }
        clutchGraphic.addSubview(gifImage)
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        let backButton = UIBarButtonItem(
            image:UIImage(named: "btn_arrow_big"),
            style: .plain, target: self,
            action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.setItems([navigationItem], animated: false)
//        navigationBar.barTintColor = .Clutch.mainWhite // 배경색 변경
        navigationBar.setBackgroundImage(UIImage(), for: .default) // 배경 색 투명하게
        navigationBar.shadowImage = UIImage() // 테두리 없애기
    }
    
    //스크롤 뷰관련 셋
    func setscrollview() {
        scrollview.delegate = self
    }
    
    func constraints() {
        let leading = 16
        
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
        }
        
        //스크롤 뷰 오토레이아웃
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //contentView 오토레이아웃
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.frame.height * 3)
            
        }
        //버튼 오토레이아웃
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(360)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
        }
        //clutchGraphic 오토 레이이아웃
        clutchGraphic.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(273)
            make.top.equalToSuperview()
        }
        
//        //gifImage 오토 레이아웃
        gifImage.snp.makeConstraints { make in
            make.leading.equalTo(clutchGraphic).offset(20)
            make.trailing.equalTo(clutchGraphic).offset(-20)
            make.top.equalTo(clutchGraphic).offset(100)
            make.bottom.equalTo(clutchGraphic).offset(-20)
        }
        
        //clutchIntroTitl의 오토레이아웃
        clutchIntroTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(305)
            make.leading.equalToSuperview().offset(leading)
        }
        
        //mainCopyTextView 오토레이아웃
        mainCopyTextView.snp.makeConstraints { make in
            make.width.equalTo(360)
            make.height.equalTo(86)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(369)
        }
        
        //mainCopyText의 오토레이아웃
        mainCopyText.snp.makeConstraints { make in
            make.center.equalTo(mainCopyTextView.snp.center)
        }
        
        clutchIntroText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(340)
            make.top.equalTo(484)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // 버튼 클릭 시 스크롤되도록 하는 메서드
    @objc func ButtonTapped(_ sender: UIButton) {
        let offsetY = scrollview.contentSize.height / 10
        let contentOffset = CGPoint(x: 0, y: scrollview.contentOffset.y + offsetY)
        
        // Check if the content offset reaches the bottom of the scroll view
        if contentOffset.y >= scrollview.contentSize.height - scrollview.bounds.height {
            // Scroll to the top
            let topOffset = CGPoint(x: 0, y: 0)
            scrollview.setContentOffset(topOffset, animated: true)
        } else {
            // Scroll by 1/5 of the height
            scrollview.setContentOffset(contentOffset, animated: true)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}

