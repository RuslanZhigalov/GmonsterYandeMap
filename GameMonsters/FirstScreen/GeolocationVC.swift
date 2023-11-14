//
//  FirstVC.swift
//  GameMonsters
//
//  Created by Руслан Жигалов on 04.06.2023.
//
import UIKit
import CoreLocation
class GeolocationVC: UIViewController {
    let vcAllow = AllowGeolocationVC()
    let vcMap = MapMonsterVC()
    var locationManager: CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    func alerts(){
        let uiAlrt = UIAlertController(title: nil, message: "Для того чтобы показать вас и ближайших монстров, разрешите приложению доступ к вашей геопозиции", preferredStyle: .alert)
        uiAlrt.addAction(UIAlertAction(title: "Разрешить", style: .cancel,handler: { action in
            self.navigationController?.pushViewController(self.vcAllow, animated: true)
        }))
        present(uiAlrt, animated: true)
    }
}
extension GeolocationVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            navigationController?.pushViewController(self.vcMap, animated: true)
        }
        if status == .denied{
            alerts()
        }
        if status == .notDetermined{
                alerts()
        }
    }
}
