import Combine
import MapKit
import UIKit

final class ViewController: UIViewController {
    private weak var mapView: MKMapView!
    
    private let locationManager: LocationManaging
    
    init(locationManager: LocationManaging) {
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        self.mapView = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestPermission()
        
        setupBindings()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private func setupBindings() {
        locationManager.currentLocation()
            .sink { [weak self] location in
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                self?.mapView.addAnnotation(annotation)
                self?.mapView.setCenter(location.coordinate, animated: true)
            }
            .store(in: &cancellables)
    }
}

