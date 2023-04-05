//
//  MainViewController.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/10.
//

import UIKit

class MainViewController: UIViewController {
    
    //viewmodel
    var viewModel: MainViewModel
    
    //UIComponent
    var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 80, left: 40, bottom: 0, right: 40)
        
        return collectionView
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        collectionViewSetting()
    }
    
    private func layout() {
        
        view.addSubviews([collectionView])
        
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func collectionViewSetting() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainViewCollectionViewCell.self, forCellWithReuseIdentifier: "gridColorCell")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GridColor.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let colorType = GridColor.allCases[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridColorCell", for: indexPath) as? MainViewCollectionViewCell else { return UICollectionViewCell() }
        
        cell.gridColor = colorType
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 10, height: collectionView.frame.width / 3 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
           
            actionSheetAlert(self)
        }
        else {
            guard let cell = collectionView.cellForItem(at: indexPath) as? MainViewCollectionViewCell else { return }
            self.viewModel.input.tapGridColor.onNext(cell.gridColor ?? .white)
            navigationController?.pushViewController(ImageCollectionViewController(viewmodel: self.viewModel), animated: false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("---------------")
            print(image)
            viewModel.input.addImage.onNext(image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
