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
    
    lazy var clutchGraphic:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_clutch_introduction")

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
        
        let text = "공시 지가에 의한 시세를 파악해, 계약 전에 전세사기 위험성을 체크할 수 있는 로직을 제공합니다.\n또한, 전세 사기 신고 접수 서비스를 통해 전세 사기 피해를 구제하고 피해금액을 피해자에게 제공합니다.\n\n이를 통해 법원에서 공시한 연 12%의 이율로 경제적 가치를 안정적으로 얻을 수 있으며, 사회적 문제로 대두된 보증금 미반환 피해 사고를 해결한다는 점에서 사회적 가치도 창출합니다.\n\n궁극적으로 저희 서비스가 잘 활성화 되어, 이러한 피해자가 0명 피해금액이 0원이 되는 것을 목표합니다."
        label.text = text
        label.font = .Clutch.baseMedium
        label.numberOfLines = 0
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var clutchIntroTextParagraph2Title:UILabel = {
        let label = UILabel()
        
        let text = "Q. 전세사기 위험성은 어떻게 판단하나요?."
        label.text = text
        label.font = .Clutch.subtitleBold
        label.numberOfLines = 1
        label.textColor = .black
        
        return label
    }()
    
    lazy var clutchIntroTextParagraph2:UILabel = {
        let label = UILabel()
        
        let text = "전세 사기 위험성은 자체적으로 구성한 로직에 의해 위험/안전으로 판단합니다.\n계약할 물건의 시세, 물건에 귀속된 대출금액, 계약 시 지급할 전세금을 토대로 합리적인 판단을 내립니다.\n\n이를 통해 가압류, 경매 등의 이슈에도 나의 보증금을 안전하게 지킬 수 있는지 알 수 있습니다. "
        label.text = text
        label.font = .Clutch.baseMedium
        label.numberOfLines = 0
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var clutchIntroWaringText:UILabel = {
        let label = UILabel()
        
        let text = "*해당 결과는 어떠한 법적 유효성이 없습니다. 해당 결과는 전세 계약에 있어서 위험성 정도를 판단하는데 참고하시기 바랍니다."
        label.text = text
        label.font = .Clutch.smallRegular
        label.textColor = .Clutch.textDarkGrey
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var clutchIntroTextParagraph3Title:UILabel = {
        let label = UILabel()
        
        let text = "Q. 전세사기 신고접수는 어떻게 이루어지나요?"
        label.text = text
        label.font = .Clutch.subtitleBold
        label.numberOfLines = 1
        label.textColor = .black
        
        return label
    }()
    
    lazy var clutchIntroTextParagraph3:UILabel = {
        let label = UILabel()
        
        let text = "전세사기 피해의 경우, 일정 조건을 충족하면 클러치에서 즉시 보증금을 지급합니다. 이를 통해 피해자는 아래의 문제에서 즉시 자유로워질 수 있습니다."
        label.text = text
        label.font = .Clutch.baseMedium
        label.numberOfLines = 0
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var clutchIntroTextParagraph4 :UILabel = {
        let label = UILabel()
        
        let text = """
    ㆍ민사 소송 평균 처리 기간: 364.1일
    ㆍ변호사선임비용: 780만원
    ㆍ보증금 대출 시 대출 이자 직접 상환 등
    """
        label.text = text
        label.font = .Clutch.baseMedium
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var clutchIntroTextParagraph5:UILabel = {
        let label = UILabel()
        
        let text = "클러치는 이후 피해자가 위임한 소송대리권/ 이익 취득권을 바탕으로 소송을 진행하고 이에 대한 지연 이자를 수취합니다. "
        label.text = text
        label.font = .Clutch.baseMedium
        label.numberOfLines = 0
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    //스크롤 기능을 탑재한 버튼
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("상단으로", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        button.backgroundColor = .Clutch.mainDarkGreen
        // Highlighted 상태일 때 배경색
        let iamge = image(withColor: .Clutch.mainGreen!)
        button.setBackgroundImage(iamge, for: .highlighted)
        button.layer.shadowColor = UIColor.Clutch.mainWhite?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 50
        button.layer.shadowOpacity = 10
        button.layer.masksToBounds = false
        return button
    }()
    
    //MARK: - define method
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        nextButton.layer.shadowPath = UIBezierPath(roundedRect: nextButton.bounds, cornerRadius: nextButton.layer.cornerRadius).cgPath
//    }

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
        [clutchGraphic, mainCopyTextView, mainCopyText, clutchIntroTitle, clutchIntroText, clutchIntroTextParagraph2Title, clutchIntroTextParagraph2, clutchIntroWaringText, clutchIntroTextParagraph3Title, clutchIntroTextParagraph3, clutchIntroTextParagraph4, clutchIntroTextParagraph5].forEach { view in
            contentView.addSubview(view)
        }

//        clutchGraphic.addSubview(gifImage)
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        let backButton = UIBarButtonItem(
            image:UIImage(named: "btn_arrow_big"),
            style: .plain, target: self,
            action: #selector(backButtonTapped))
        backButton.tintColor = .Clutch.textDarkGrey
        navigationItem.leftBarButtonItem = backButton
        navigationBar.setItems([navigationItem], animated: false)
//        navigationBar.backgroundColor = .Clutch.mainWhite
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
            make.bottom.equalTo(clutchIntroTextParagraph5.snp.bottom).offset(80)
            
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
        
        //clutchIntroTitl의 오토레이아웃
        clutchIntroTitle.snp.makeConstraints { make in
            make.bottom.equalTo(mainCopyTextView.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(30)
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
        
        clutchIntroTextParagraph2Title.snp.makeConstraints { make in
            make.top.equalTo(clutchIntroText.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        clutchIntroTextParagraph2.snp.makeConstraints { make in
            make.top.equalTo(clutchIntroTextParagraph2Title.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        clutchIntroWaringText.snp.makeConstraints { make in
            make.top.equalTo(clutchIntroTextParagraph2.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        clutchIntroTextParagraph3Title.snp.makeConstraints { make in
            make.top.equalTo(clutchIntroWaringText.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        clutchIntroTextParagraph3.snp.makeConstraints { make in
            make.top.equalTo(clutchIntroTextParagraph3Title.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        clutchIntroTextParagraph4.snp.makeConstraints { make in
            make.top.equalTo(clutchIntroTextParagraph3.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        clutchIntroTextParagraph5.snp.makeConstraints { make in
            make.top.equalTo(clutchIntroTextParagraph4.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // 버튼 클릭 시 스크롤되도록 하는 메서드
    @objc func ButtonTapped(_ sender: UIButton) {
        
        let topOffset = CGPoint(x: 0, y: 0)
        scrollview.setContentOffset(topOffset, animated: true)
    }
    
}

