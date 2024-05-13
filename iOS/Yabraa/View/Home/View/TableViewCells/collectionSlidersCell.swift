//
//  collectionSlidersCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 13/05/2023.
//

import UIKit
import RxSwift
import AppCenterCrashes
import RxCocoa
protocol HandlecollectionSlidersCell{
    func didSelectCell(at index: Int)
}
class collectionSlidersCell: UITableViewCell {
    @IBOutlet weak var sliderPageController: UIPageControl!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    var viewModel = CollectionSliderViewModel()
    let disposeBag = DisposeBag()
    var currentPageIndex = 0
    var timer: Timer?
    var delegate: HandlecollectionSlidersCell?
    let sliders = BehaviorRelay<[String]>(value: [])
    let interval = Observable<Int>.interval(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance)

    override func awakeFromNib() {
        super.awakeFromNib()
        configureSliderCollectionView()
//        configureSliderTime()
        bind()
        configureSliderTime()
        configurePageController()
        // Initialization code SliderImagesCell
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//       
//    }
    private func configurePageController() {
        sliders.map {$0.count}.bind(to: sliderPageController.rx.numberOfPages).disposed(by: disposeBag)
//        if UserDefualtUtils.isArabic(){
//            sliderPageController.transform = CGAffineTransform(scaleX: -1, y: 1)
//        }else{
//            sliderPageController.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }
    }
    private func configureSliderTime() {
//        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        
        Observable.combineLatest(interval, sliders)
            .map { (index, items) in
                return (index % items.count, items)
            }
            .bind { [weak self] (index, items) in
                // Select the next item in the collection view
                let indexPath = IndexPath(item: index, section: 0)
                self?.sliderCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
            .disposed(by: disposeBag)

    }
    private func bind() {
        sliders.bind(to: sliderCollectionView.rx.items(cellIdentifier: "SliderCell",cellType: SliderCell.self)) {index, model, cell in
            cell.configureCell(image: model)
        }.disposed(by: disposeBag)
        sliderCollectionView.rx.itemSelected.map{$0.row}.subscribe(onNext: {[weak self] row in
            self?.delegate?.didSelectCell(at: row)
        }).disposed(by: disposeBag)
//        sliderCollectionView.rx.modelSelected(String.self).asObservable().subscribe(onNext: { model in
////            Crashes.generateTestCrash()
//            self.delegate?.didSelectCell(model: model.)
//        })
//        .disposed(by: disposeBag)
    }
    private func configureSliderCollectionView() {
        sliderCollectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        sliderCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
//    @objc func moveToNextPage() {
//        let nextPageIndex = (currentPageIndex + 1) % (self.sliderPageController.numberOfPages)
//        DispatchQueue.main.async {
//            self.currentPageIndex = nextPageIndex
//            self.sliderPageController.currentPage = self.currentPageIndex
//            self.scrollToIndex(index: nextPageIndex)
//        }
//    }
//    func scrollToIndex(index:Int) {
//        let rect = self.sliderCollectionView.layoutAttributesForItem(at: IndexPath(row: index, section: 0))?.frame
//        self.sliderCollectionView.scrollRectToVisible(rect!, animated: false)
//    }
    
}
extension collectionSlidersCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 40 , height: 150)
    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageIndex = Int(scrollView.contentOffset.x / sliderCollectionView.bounds.width)
//        currentPageIndex = pageIndex
//    }
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        var transtionX = collectionView.bounds.width
//        if UserDefualtUtils.getCurrentLanguage() == "ar" {
//            transtionX = -collectionView.bounds.width
//        }
//        cell.transform = CGAffineTransform(translationX: transtionX, y: 0)
//        cell.alpha = 0.0
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
//            cell.transform = CGAffineTransform.identity
//            cell.alpha = 1.0
//        })
//    }
    
    
}
