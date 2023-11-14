//
//  AllowGeolocationVC.swift
//  GameMonsters
//
//  Created by Руслан Жигалов on 04.06.2023.
//

import UIKit
import CoreLocation

class AllowGeolocationVC: UIViewController {
    var locationManager: CLLocationManager?
    let vcMap = MapMonsterVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
    }
    func alerts(){
        
        let uiAlrt = UIAlertController(title: nil, message: "Мы не знаем где вы находитесь на карте, разрешите нам определить ваше местоположение, это делается в настройках телефона", preferredStyle: .alert)
        uiAlrt.addAction(UIAlertAction(title: "Перейти к настройкам", style: .cancel,handler: { action in
            if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }))
        present(uiAlrt, animated: true)
    }
}
extension AllowGeolocationVC:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            navigationController?.pushViewController(self.vcMap, animated: true)
        }
        if status == .denied{
            alerts()
        }
        
    }
}
