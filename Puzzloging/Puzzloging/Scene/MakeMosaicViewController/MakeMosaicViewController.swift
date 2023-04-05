//
//  MakeMosaicViewController.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/13.
//

import UIKit
import RxSwift
import RxCocoa

class MakeMosaicViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var viewModel: MainViewModel
    
    let whiteView = UIView()
    let ingredientsHeader = MakeMosaicTableHeaderView()
    let ingredientsFooter = MakeMosaicTableFooterView()
    let ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MakeMosaicTableViewCell.self, forCellReuseIdentifier: "MakeMosaicTableViewCell")
        
        return tableView
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        bind()
    }
    
    private func layout() {
        view.addSubviews([ingredientsTableView,whiteView])
        ingredientsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        whiteView.frame.origin.x = view.safeAreaInsets.left
        whiteView.frame.origin.y = view.safeAreaInsets.top
        whiteView.frame.size.width = view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right
        whiteView.frame.size.height = UIApplication.shared.windows.first!.safeAreaInsets.top
        whiteView.backgroundColor = .white
        
        let gh = UITapGestureRecognizer(target: self, action: #selector(tapNewMosaicImage(_:)))
        ingredientsHeader.addGestureRecognizer(gh)
        
        let gf = UITapGestureRecognizer(target: self, action: #selector(tapConfirmButton(_:)))
        ingredientsFooter.addGestureRecognizer(gf)
    }
    
    private func bind() {
        ingredientsTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.output.colorIngredients
            .map { colors in
                return colors.uniqued()
            }
            .bind(to: ingredientsTableView.rx
                .items(cellIdentifier: "MakeMosaicTableViewCell",
                       cellType: MakeMosaicTableViewCell.self)) { index, gridColor, cell in
                cell.selectionStyle = .none
                cell.gridColor = gridColor
                cell.viewModel = self.viewModel
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.output.colletedColors.asObservable(), viewModel.output.colorIngredients.asObservable())
            .map { colleted, ingredients -> Bool in
                var okCount = 0
                colleted.forEach { colletedColor in
                    ingredients.forEach { ingredientsColor in
                        if colletedColor == ingredientsColor { okCount += 1 }
                    }
                }
                return okCount == ingredients.count && ingredients.count != 0
            }
            .observe(on: MainScheduler.instance)
            .subscribe { canConfirm in
                if canConfirm {
                    self.ingredientsFooter.isUserInteractionEnabled = true
                    self.ingredientsFooter.confirmButton.backgroundColor = .mainColor
                }
                else {
                    self.ingredientsFooter.isUserInteractionEnabled = false
                    self.ingredientsFooter.confirmButton.backgroundColor = .gamLightGray0
                }
            }
            .disposed(by: disposeBag)
    }
}

extension MakeMosaicViewController: UITableViewDelegate,
                                    UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 150
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MakeMosaicTableViewCell else { return }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.progressStart(onView: view)
            viewModel.input.loadingEndAction = { [weak self] in
                self?.progressStop()
            }
            viewModel.input.willMosaicImage.onNext(image)
            ingredientsHeader.mosaicImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ingredientsHeader
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return ingredientsFooter
    }
    
    
    @objc func tapNewMosaicImage(_ sender: Any) {
        actionSheetAlert(self)
    }
    
    @objc func tapConfirmButton(_ sender: Any){
        progressStart(onView: self.view)
        self.viewModel.input.makeMosaicImage.onNext(true)
        self.viewModel.input.willMosaicImage.onNext(ingredientsHeader.mosaicImage.image!)
    }
}
