import Foundation
import Capacitor
import CoreLocation
import Photos

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(Permissions)
public class Permissions: CAPPlugin
{
	private let locationManager = CLLocationManager()


	func displayPermissionDeniedPopup(message: String, block: @escaping (Bool) -> Void)
	{
		DispatchQueue.main.async
		{
			let alert = UIAlertController(title: "Permission denied", message: message, preferredStyle: .alert)
			alert.addAction( UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:
			{ _ in
				block(false)
			}))
			alert.addAction(UIAlertAction(title: "Grant", style: .default, handler:
			{ _ in
				block(true)
				if #available(iOS 10.0, *)
				{
					UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
				}
				else
				{
					UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
				}
			}))
			self.bridge.viewController.present(alert, animated: true, completion: nil)
		}

	}

	@objc func requestPhotoAndCameraPermission(_ call: CAPPluginCall)
	{
		// Only intilialize picker if photo permission is Allowed by user.
		let photoStatus = PHPhotoLibrary.authorizationStatus()
		let videoStatus = AVCaptureDevice.authorizationStatus(for: .video)

		if (videoStatus == .authorized && photoStatus == .authorized)
		{
			call.resolve(["status": "AUTHORIZED"])
		}
		else
		{
			if (videoStatus == .denied || photoStatus == .denied || videoStatus == .restricted || photoStatus == .restricted)
			{
				var msg = "Please allow access to Photos and Camera."
				if ((videoStatus == .denied || videoStatus == .restricted) && (photoStatus == .authorized))
				{
					msg = "Please allow access to the Camera."
				}
				else if ((photoStatus == .denied || photoStatus == .restricted) && (videoStatus == .authorized))
				{
					msg = "Please allow access to Photos."
				}
				
				displayPermissionDeniedPopup(message: msg, block:
				{ granted in
					if (!granted)
					{
						call.resolve(["status": "DENIED"])
					}
				})
			}
			else if (videoStatus == .notDetermined)
			{
				AVCaptureDevice.requestAccess(for: .video)
				{ granted in
					if granted
					{
						if (photoStatus == .notDetermined)
						{
							PHPhotoLibrary.requestAuthorization
							{ auth in
								DispatchQueue.main.async
								{
									switch (auth)
									{
										case .authorized:
											call.resolve(["status": "AUTHORIZED"])
											break
										case.denied, .restricted:
											call.resolve(["status": "DENIED"])
											break
										case.notDetermined:
											call.resolve(["status": "NOT_DETERMINED"])
											break
										case .limited:
											call.resolve(["status": "LIMITED"])
											break
										@unknown default:
											call.resolve(["status": "DENIED"])
											break
									}
								}
							}
						}
						else
						{
							call.resolve(["status": "AUTHORIZED"])
						}
					}
					else
					{
						call.resolve(["status": "DENIED"])
					}
				}
			}
			else if (photoStatus == .notDetermined)
			{
				AVCaptureDevice.requestAccess(for: .audio)
				{ granted in
					if granted
					{
						call.resolve(["status": "AUTHORIZED"])
					}
					else
					{
						call.resolve(["status": "DENIED"])
					}
				}
			}
		}
	}

	@objc func requestPermission(_ call: CAPPluginCall)
	{
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
							break
					case.denied, .restricted:
							status = "PHOTO_LIBRARY/DENIED";
							break
						case.notDetermined:
							status = "PHOTO_LIBRARY/NOT_DETERMINED";
							break
					case .limited:
						status = "PHOTO_LIBRARY/LIMITED";
						break
					@unknown default:
						break
					}
					call.resolve([
						"status": status
					])
				}
			break;
			case "CAMERA":
				AVCaptureDevice.requestAccess(for: .video) { (granted) in
					if granted {
						status = "CAMERA/AUTHORIZED";
					}
					else {
						status = "CAMERA/DENIED";
					}
					call.success([
						"status": status
					])
				}
			break;
			case "NOTIFICATION":
				UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
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
					case.denied, .restricted:
						status = "LOCATION/DENIED";
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
					case.denied, .restricted:
						status = "PHOTO_LIBRARY/DENIED";
						break;
					case.notDetermined:
						status = "PHOTO_LIBRARY/NOT_DETERMINED";
						break;
					case .limited:
						status = "PHOTO_LIBRARY/LIMITED";
						break
					@unknown default:
						break
				}
				call.resolve([
					"status": status
				])
			break;
			case "CAMERA":
				switch (AVCaptureDevice.authorizationStatus(for: .video)) {
					case .authorized:
						status = "CAMERA/AUTHORIZED";
						break
					case.denied, .restricted:
						status = "CAMERA/DENIED";
						break
					case.notDetermined:
						status = "CAMERA/NOT_DETERMINED";
						break
					@unknown default:
						status = "CAMERA/DENIED";
						break
				}
				call.resolve([
					"status": status
				])
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
						case .ephemeral:
							break
						@unknown default:
							break
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
