import CoreLocation

protocol LocationManaging {
    func requestPermission()
}

final class CombineLocationManager: LocationManaging {
    private let manager = CLLocationManager()
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
}
