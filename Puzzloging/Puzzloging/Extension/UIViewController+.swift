//
//  UIViewController+.swift
//  TeamMyung
//
//  Created by 이경민 on 2022/12/18.
//

import UIKit
import RxSwift
import RxCocoa

var vProgress : UIView?


extension UIViewController {
    
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    func iskeyboardShow(keyboardHeight: CGFloat) {
        let backGroundTapGestrue = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        if keyboardHeight > 0 {
            view.addGestureRecognizer(backGroundTapGestrue)
        }
        else {
            view.removeGestureRecognizer(backGroundTapGestrue)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func progressStart(onView : UIView) {
        let progressView = UIView.init(frame: onView.bounds)
        progressView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
       
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        activityIndicator.center = progressView.center
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true

        activityIndicator.startAnimating()
        
       
        DispatchQueue.main.async {
            progressView.addSubview(activityIndicator) // 부모에 Indicator 자식 추가
            onView.addSubview(progressView) // 뷰컨트롤러에 부모 추가
        }
        vProgress = progressView
    }
    
    func progressStop() {
        DispatchQueue.main.async {
            vProgress?.removeFromSuperview() // 뷰에서 제거 실시
            vProgress = nil
        }
    }
    
    func actionSheetAlert(_ viewcontroller: UIImagePickerControllerDelegate & UINavigationControllerDelegate){
            
            let alert = UIAlertController(title: "선택", message: "선택", preferredStyle: .actionSheet)
            
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let camera = UIAlertAction(title: "카메라", style: .default) { [weak self] (_) in
                self?.presentCamera(viewcontroller)
            }
            let album = UIAlertAction(title: "앨범", style: .default) { [weak self] (_) in
                self?.presentAlbum(viewcontroller)
            }
            
            alert.addAction(cancel)
            alert.addAction(camera)
            alert.addAction(album)
            
            present(alert, animated: true, completion: nil)
            
        }
    
    func presentCamera(_ viewcontroller: UIImagePickerControllerDelegate & UINavigationControllerDelegate){
            
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.delegate = viewcontroller
            vc.allowsEditing = false
            
            present(vc, animated: true, completion: nil)
        }
        
    func presentAlbum(_ viewcontroller: UIImagePickerControllerDelegate & UINavigationControllerDelegate){
            
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = viewcontroller
            vc.allowsEditing = false
            
            present(vc, animated: true, completion: nil)
    }
}
