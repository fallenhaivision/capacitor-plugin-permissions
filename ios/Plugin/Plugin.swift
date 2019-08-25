import Foundation
import Capacitor
import CoreLocation
import Photos

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(Permissions)
public class Permissions: CAPPlugin {
    private let locationManager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization authorizationStatus: CLAuthorizationStatus, call: CAPPluginCall) {
        var status = "";
        switch (authorizationStatus) {
            case.authorizedAlways:
                status = "PHOTO_LIBRARY/AUTHORIZED_ALWAYS";
                break;
            case.authorizedWhenInUse:
                status = "PHOTO_LIBRARY/AUTHORIZED_WHEN_IN_USE";
                break;
            case.denied:
                status = "PHOTO_LIBRARY/DENIED";
                break;
            case.restricted:
                status = "PHOTO_LIBRARY/RESTRICTED";
                break;
            case .notDetermined:
                status = "PHOTO_LIBRARY/NOT_DETERMINED";
                break;
        }
        call.resolve([
            "status": status
        ])
        
   }
    
    @objc func requestPermission(_ call: CAPPluginCall) {
        let permission = call.getString("permission") ?? ""
        var status = ""
        switch (permission) {
            case "LOCATION_WHEN_IN_USE":
                locationManager.requestWhenInUseAuthorization();
            break;
            case "LOCATION_ALWAYS":
                locationManager.requestAlwaysAuthorization();
            break;
            case "PHOTO_LIBRARY":
                PHPhotoLibrary.requestAuthorization { (PHAuthorizationStatus) in
                    switch (PHAuthorizationStatus) {
                        case .authorized:
                            status = "PHOTO_LIBRARY/AUTHORIZED";
                            break;
                        case.denied:
                            status = "PHOTO_LIBRARY/DENIED";
                            break;
                        case.notDetermined:
                            status = "PHOTO_LIBRARY/NOT_DETERMINED";
                            break;
                        case .restricted:
                            status = "PHOTO_LIBRARY/RESTRICTED";
                            break;
                    }
                    call.resolve([
                        "status": status
                    ])
                }
            break;
            case "CAMERA":
                
            break;
            case "NOTIFICATION":
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    guard error == nil else {
                        status = "NOTIFICATION/ERROR";
                        return
                    }
                    if granted {
                        status = "NOTIFICATION/AUTHORIZED";
                    }
                    else {
                        status = "NOTIFICATION/DENIED";
                    }
                    call.success([
                        "status": status
                    ])
                }
            break;
        default:
            status = "success"
        }
        
    }
    
    @objc func checkStatus(_ call: CAPPluginCall) {
        let permission = call.getString("permission") ?? ""
        var status = "";
        switch (permission) {
            case "LOCATION_WHEN_IN_USE", "LOCATION_ALWAYS":
                switch (CLLocationManager.authorizationStatus()) {
                    case.authorizedAlways:
                        status = "LOCATION/AUTHORIZED_ALWAYS";
                        break;
                    case.authorizedWhenInUse:
                        status = "LOCATION/AUTHORIZED_WHEN_IN_USE";
                        break;
                    case.denied:
                        status = "LOCATION/DENIED";
                        break;
                    case.restricted:
                        status = "LOCATION/RESTRICTED";
                        break;
                    case .notDetermined:
                        status = "LOCATION/NOT_DETERMINED";
                        break;
                }
                call.resolve([
                    "status": status
                ])
            break;
            case "PHOTO_LIBRARY":
                switch (PHPhotoLibrary.authorizationStatus()) {
                    case .authorized:
                        status = "PHOTO_LIBRARY/AUTHORIZED";
                        break;
                    case.denied:
                        status = "PHOTO_LIBRARY/DENIED";
                        break;
                    case.notDetermined:
                        status = "PHOTO_LIBRARY/NOT_DETERMINED";
                        break;
                    case .restricted:
                        status = "PHOTO_LIBRARY/RESTRICTED";
                        break;
                }
                call.resolve([
                    "status": status
                ])
            break;
            case "CAMERA":
                
            break;
            case "NOTIFICATION":
                UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { settings in
                    switch settings.authorizationStatus {
                        case .authorized, .provisional:
                            status = "NOTIFICATION/AUTHORIZED";
                        case .denied:
                            status = "NOTIFICATION/DENIED";
                        case .notDetermined:
                            status = "NOTIFICATION/NOT_DETERMINED";
                        }
                        call.resolve([
                            "status": status
                        ])
                    }
                )
            break;
        default:
            status = "ERROR";
        }
        
    }
}

