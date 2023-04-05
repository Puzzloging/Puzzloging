//
//  ViewController.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/09.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MultiProgressView

class LoginViewController: UIViewController {
    
//    let disposeBag = DisposeBag()
//
//    let puzzlogingLogo: UIImageView = {
//        let imageView = UIImageView()
//
//        imageView.image = UIImage(named: "puzzlogingLogo") ?? UIImage()
//
//        return imageView
//    }()
//
//    let idTextField: UITextField = {
//        let textField = UITextField()
//
//        textField.borderStyle = .roundedRect
//        textField.placeholder = "아이디를 입력해주세요."
//
//        return textField
//    }()
//
//    let idTextFieldUnderLineView: UIView = {
//        let view = UIView()
//
//        view.backgroundColor = .subColor
//
//        return view
//    }()
//
//    let confirmButton: UIButton = {
//        let button = UIButton()
//
//        button.layer.masksToBounds = false
//        button.layer.cornerRadius = 15
//        button.backgroundColor = .mainColor
//        button.setTitle("Login", for: .normal)
//
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        layout()
//        bind()
//    }
//
//    private func bind() {
//        keyboardHeight()
//            .observe(on: MainScheduler.instance)
//            .subscribe { [weak self] keyboardHeight in
//
//                self?.iskeyboardShow(keyboardHeight: keyboardHeight)
//                self?.confirmButton.isKeyBoard(at: keyboardHeight)
//                self?.idTextField.isKeyBoard(at: keyboardHeight * 0.3)
//                self?.idTextFieldUnderLineView.isKeyBoard(at: keyboardHeight * 0.3)
//            }
//            .disposed(by: disposeBag)
//
//        confirmButton.rx.tap
//            .subscribe { [weak self] _ in
//                let mainVC = TabViewController()
//                mainVC.modalPresentationStyle = .fullScreen
//
//                self?.present(mainVC, animated: false)
//            }
//            .disposed(by: disposeBag)
//    }
//
//    private func layout() {
//        view.addSubviews([puzzlogingLogo, idTextField, idTextFieldUnderLineView, confirmButton])
//
//        puzzlogingLogo.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalToSuperview().inset(128)
//            $0.width.equalTo(self.view.frame.width * 0.6)
//            $0.height.equalTo(self.view.frame.width * 0.15)
//        }
//
//        idTextField.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
//            $0.width.equalTo(self.view.frame.width * 0.8)
//            $0.height.equalTo(60)
//
//        }
//        idTextFieldUnderLineView.snp.makeConstraints {
//            $0.top.equalTo(idTextField.snp.bottom).offset(3)
//            $0.width.equalTo(idTextField.snp.width)
//            $0.centerX.equalToSuperview()
//            $0.height.equalTo(2)
//        }
//
//        confirmButton.snp.makeConstraints {
//            $0.width.equalTo(self.view.frame.width * 0.8)
//            $0.bottom.equalToSuperview().inset(64)
//            $0.centerX.equalToSuperview()
//            $0.height.equalTo(60)
//        }
//    }
    
    let pgv = MultiProgressView()
    let pgv2 = MultiProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pgv)
        view.addSubview(pgv2)
        
        pgv.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(view.bounds.size.width * 0.7)
            $0.height.equalTo(80)
        }
        
        pgv2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.bounds.size.width * 0.7)
            $0.height.equalTo(80)
            $0.top.equalTo(pgv.snp.bottom).offset(30)
            
        }
        pgv.layer.borderWidth = 3
        pgv.layer.borderColor = UIColor.black.cgColor
        pgv2.layer.borderWidth = 3
        pgv2.layer.borderColor = UIColor.black.cgColor
        pgv.delegate = self
        pgv.dataSource = self
        pgv2.delegate = self
        pgv2.dataSource = self
        let temp: [Float] = [0.1, 0.2, 0.1, 0.3, 0.05,0.1,0.1]
        let temp2: [Float] = [0.1, 0.3, 0.05,0.1,0.1]
        
        for float in temp.enumerated() {
            pgv.setProgress(section: float.offset, to: float.element)
        }
        for float in temp2.enumerated() {
            pgv2.setProgress(section: float.offset, to: float.element)
        }
    }
}


extension LoginViewController: MultiProgressViewDelegate, MultiProgressViewDataSource {
    
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        if progressView == pgv {
            return 7
        }
        else {
            return 5
        }
    }
    
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        
        let cell = ProgressViewSection()
        if section % 2 == 0 {
            cell.backgroundColor = .red
        }
        else {
            cell.backgroundColor = .blue
        }
        return cell
    }
    
}
