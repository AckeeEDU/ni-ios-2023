import CoreLocation
import Combine

protocol LocationManaging {
    func currentLocation() -> any Publisher<CLLocation, Never>
    
    func requestPermission()
}

final class CombineLocationManager: NSObject, LocationManaging, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private let locationsSubject = PassthroughSubject<CLLocation, Never>()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func currentLocation() -> any Publisher<CLLocation, Never> {
        locationsSubject
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        locations.forEach { location in
            locationsSubject.send(location)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        manager.startUpdatingLocation()
    }
}
