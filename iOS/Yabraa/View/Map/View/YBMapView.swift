//
//  YBMapView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit
import GoogleMaps
import RxCocoa
import RxSwift
import GooglePlaces
protocol LocationEditing: AnyObject {
    func didEditLocation(lat: Double,lng: Double)
}
class YBMapView: BaseViewController {
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var currentLocation: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var backBtn: UIButton!
    let locationManager = CLLocationManager()
    var coordinator: MapCoodintaorDelegate?
    var viewModel: MapViewModel?
    let disposeBag = DisposeBag()
    var markerView = UIImageView()
    weak var delegate: LocationEditing?
    var lat: Double?
    var lng: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView()
        setUpUi()
        bindData()
    }
    private func setUpUi() {
        backBtn.imageView?.FlipImage()
    }
    private func bindData() {
        backBtn.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.coordinator?.back()
        }).disposed(by: disposeBag)
        currentLocation.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.locationManager.startUpdatingLocation()
        }).disposed(by: disposeBag)
        searchText.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] _ in
                self?.searchForAddress()
            })
            .disposed(by: disposeBag)
    }
    private func searchForAddress() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.modalPresentationStyle = .fullScreen
        UINavigationBar.appearance().barTintColor = UIColor.red
        UINavigationBar.appearance().tintColor = UIColor.mainColor
        present(autocompleteController, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    private func setUpMapView(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.delegate = self
        addMapPin()
        self.locationManager.startUpdatingLocation()
    }
    func addMapPin(){
    markerView: do {
        view.addSubview(markerView)
        markerView.translatesAutoresizingMaskIntoConstraints = false
        markerView.image = UIImage(named: "pin-svgrepo-com")
        markerView.contentMode = .scaleAspectFit
//        markerView.tintColor = UIColor.black
        NSLayoutConstraint.activate([
            markerView.heightAnchor.constraint(equalToConstant:25),
            markerView.widthAnchor.constraint(equalToConstant:25),
            markerView.centerYAnchor.constraint(equalTo:mapView.centerYAnchor,constant: 0),
            markerView.centerXAnchor.constraint(equalTo:mapView.centerXAnchor,constant: 0)
        ])
    }
    }
    private func showLatAndLngOnMap(coordinate: CLLocationCoordinate2D) {
        CATransaction.begin()
        CATransaction.setValue(0.7, forKey: kCATransactionAnimationDuration)
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let camera = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 15)
        mapView.camera = camera
        self.lat = latitude
        self.lng = longitude
        CATransaction.commit()
    }
    @IBAction func confirmTapped(_ sender: Any) {
        guard let lat = self.lat ,let lng = lng else {
            displayMessage(title: "", message: "confirm your locations", status: .info)
            return}
        if viewModel?.isFromEditingAppointMent.value ?? false {
            delegate?.didEditLocation(lat: lat, lng: lng)
            self.coordinator?.back()
        }else {
            viewModel?.setLatAndLng(lat: String(lat), lng: String(lng))
            self.coordinator?.goToConfirmation()
        }
    }
}
extension YBMapView: GMSMapViewDelegate,CLLocationManagerDelegate{
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.lat = position.target.latitude
        self.lng = position.target.longitude
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        showLatAndLngOnMap(coordinate: position.target)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last,location.horizontalAccuracy > 0 {
            self.locationManager.stopUpdatingLocation()
            showLatAndLngOnMap(coordinate: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
}
extension YBMapView: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        showLatAndLngOnMap(coordinate: place.coordinate)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
extension YBMapView:PackagesLocation {
    func chnagePackagesLocation(packages: Packages) {
        let selectedPackage = SelectedPackage.shared
        let lat = Double(selectedPackage.lat) ?? 0.0
        let lng = Double(selectedPackage.lng) ?? 0.0
        self.lat = lat
        self.lng = lng
        self.showLatAndLngOnMap(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
    }
}
