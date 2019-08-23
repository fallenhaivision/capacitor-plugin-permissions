import Foundation
import Capacitor
import CoreLocation

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(Permissions)
public class Permissions: CAPPlugin {
    
    @objc func request(_ call: CAPPluginCall) {
        let permission = call.getString("name") ?? ""
        switch (permission) {
            case "LOCATION_WHEN_IN_USE":
                let locationManager = CLLocationManager();
                locationManager.requestWhenInUseAuthorization()
            break;
            case "LOCATION_ALWAYS":
            break;
            case "PHOTO_LIBRARY":
            break;
            case "CAMERA":
            break;
        }
        call.success([
            "value": value
        ])
    }
}
