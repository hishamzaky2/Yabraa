//
//  FullScreenImageViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 24/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
class FullScreenImageViewController: UIViewController {
    
    @IBOutlet weak var sliderImage: UIImageView!
    
    @IBOutlet weak var backBtn: UIButton!
    var router: FullScreenImageRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: FullScreenImageViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindImages()
        setUpUi()
        bindButtonsAction()
        
    }
    private func setUpUi(){
        backBtn.imageView?.FlipImage()
    }
    private func bindImages() {
        viewModel?.shownImage.subscribe(onNext: { [weak self] image in
            self?.sliderImage.setImage(from: image)
        }).disposed(by: disposeBag)
    }
    private func bindButtonsAction() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
    }
}
