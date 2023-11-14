//
//  MapMonsterVC.swift
//  GameMonsters
//
//  Created by Руслан Жигалов on 07.06.2023.
//

import UIKit
import CoreLocation
import YandexMapsMobile


class MapMonsterVC: UIViewController {
    var locationManager: CLLocationManager?
    var arrMonsters:[YMKMapObject] = []
    
    var minus = 16
    let map: YMKMapView = {
        let map = YMKMapView()
        return map
    }()
    private var distanceMinusButton: UIButton = {
        let btn = UIButton()
        
        if #available(iOS 13.0, *) {
            btn.setImage(.remove, for: .normal)
        } else {
        }
        if #available(iOS 15.0, *) {
            btn.subtitleLabel?.numberOfLines = .max
        } else {
        }
        btn.titleLabel?.numberOfLines = .max
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private var myTeam: UIButton = {
        let btn = UIButton()
        if #available(iOS 15.0, *) {
            btn.subtitleLabel?.numberOfLines = .max
        } else {
        }
        btn.backgroundColor = .lightGray
        
        btn.layer.opacity = 0.6
        btn.layer.cornerRadius = 16
        btn.setTitle("Моя команда", for: .normal)
        
        btn.titleLabel?.numberOfLines = .max
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private var distancePlusButton: UIButton = {
        let btn = UIButton()
        if #available(iOS 13.0, *) {
            btn.setImage(.add, for: .normal)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 15.0, *) {
            btn.subtitleLabel?.numberOfLines = .max
        } else {
        }
        btn.titleLabel?.numberOfLines = .max
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private var locationButton: UIButton = {
        let btn = UIButton()
        if #available(iOS 13.0, *) {
            btn.setImage(.checkmark, for: .normal)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 15.0, *) {
            btn.subtitleLabel?.numberOfLines = .max
        } else {
        }
        btn.titleLabel?.numberOfLines = .max
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        setupConstr()
        Timer.scheduledTimer(timeInterval: 10,
                             target: self,
                             selector: #selector(deleteMonsterArr),
                             userInfo: nil,
                             repeats: true)
    }
    @objc func pushTableMyteam(){
        navigationController?.pushViewController(MyTeamViewController(), animated: true)
    }
    func setupConstr(){
        view.addSubview(map)
        view.addSubview(distancePlusButton)
        view.addSubview(distanceMinusButton)
        view.addSubview(locationButton)
        view.addSubview(myTeam)
        myTeam.heightAnchor.constraint(equalToConstant: 50).isActive = true
        myTeam.widthAnchor.constraint(equalToConstant: 150).isActive = true
        myTeam.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        myTeam.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        myTeam.addTarget(self, action: #selector(pushTableMyteam), for: .touchUpInside)
        
        locationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        locationButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        locationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        locationButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        
        distancePlusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        distancePlusButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        distancePlusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height / 2) - 50).isActive = true
        distancePlusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        
        distanceMinusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        distanceMinusButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        distanceMinusButton.topAnchor.constraint(equalTo: distancePlusButton.bottomAnchor, constant: 0).isActive = true
        distanceMinusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        
        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        map.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        map.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        
        
        distanceMinusButton.addTarget(self, action: #selector(distanceMinusMap), for: .touchUpInside)
        distancePlusButton.addTarget(self, action: #selector(distancePlusMap), for: .touchUpInside)
        
        
        locationButton.addTarget(self, action: #selector(locationMap), for: .touchUpInside)
        
        createAnimatedPlacemark()
    }
    
    
    func createAnimatedPlacemark() {
        guard let mkplatitude = locationManager?.location?.coordinate.latitude else{return}
        guard let mkplongitude = locationManager?.location?.coordinate.longitude else {return}
        
            for i in 0...29{
                let rndInt = Int.random(in: 1...5)
                guard let image = UIImage(named: "Crizl\(rndInt)") else {return}
                let rand = Double.random(in: -0.005...0.005)
                let rand2 = Double.random(in: -0.005...0.005)
                let mapObjects = map.mapWindow.map.mapObjects
                let MONSTER_CENTER = YMKPoint(latitude: mkplatitude + rand , longitude: mkplongitude + rand2)
                let monstr = mapObjects.addPlacemark(with: MONSTER_CENTER, image: image)
                monstr.userData = monsterModel(name: "Crizl\(rndInt)", arr: i)
                monstr.addTapListener(with: self)
                arrMonsters.append(monstr)
            }
        map.mapWindow.map.move(
            with: YMKCameraPosition.init(target: YMKPoint(latitude: mkplatitude, longitude: mkplongitude), zoom: Float(minus), azimuth: 0, tilt: 0))
    }
    
    @objc func deleteMonsterArr(){
        var k = arrMonsters
        let mapObjects = map.mapWindow.map.mapObjects
        guard let mkplatitude = locationManager?.location?.coordinate.latitude else{return}
        guard let mkplongitude = locationManager?.location?.coordinate.longitude else {return}
        if arrMonsters.count == 0{
            return
        }
        for i in (0...arrMonsters.count - 1).reversed(){
            let randomInterest = Int.random(in: 0...100)
            if randomInterest < 20{
                mapObjects.remove(with: arrMonsters[i])
                k.remove(at: i)
            }
        }
        let numbersMonstr = k.count
        for i in numbersMonstr...numbersMonstr + 5{
            let rndInt = Int.random(in: 1...5)
                guard let image = UIImage(named: "Crizl\(rndInt)") else {return}
                let rand = Double.random(in: -0.007...0.007)
                let rand2 = Double.random(in: -0.007...0.007)
                let mapObjects = map.mapWindow.map.mapObjects
                let MONSTER_CENTER = YMKPoint(latitude: mkplatitude + rand , longitude: mkplongitude + rand2)
                let monstr = mapObjects.addPlacemark(with: MONSTER_CENTER, image: image)
                monstr.userData = monsterModel(name: "Crizl\(rndInt)", arr: i)
                monstr.addTapListener(with: self)
                k.append(monstr)
        }
        arrMonsters = k
    }
    
    

    @objc func distanceMinusMap(){
        let targert = map.mapWindow.map.cameraPosition.target
        if minus < 1{
            minus = 1
        }
        minus -= 1
        map.mapWindow.map.move(
            with: YMKCameraPosition.init(target: targert, zoom: Float(minus), azimuth: 0, tilt: 0))
    }
    @objc func locationMap(){
        guard let mkplatitude = locationManager?.location?.coordinate.latitude else{return}
        guard let mkplongitude = locationManager?.location?.coordinate.longitude else {return}
        map.mapWindow.map.move(
            with: YMKCameraPosition.init(target: YMKPoint(latitude: mkplatitude  , longitude: mkplongitude), zoom: Float(minus), azimuth: 0, tilt: 0))
    }
    private func alerts(textDesck: String,textDesc2: String){
        
        let uiAlrt = UIAlertController(title: nil, message: textDesck, preferredStyle: .alert)
        uiAlrt.addAction(UIAlertAction(title: textDesc2, style: .cancel))
        present(uiAlrt, animated: true)
    }
    @objc func distancePlusMap(){
        let targert = map.mapWindow.map.cameraPosition.target
        if minus > 18{
            minus = 18
        }
        minus += 1
        map.mapWindow.map.move(
            with: YMKCameraPosition.init(target: targert, zoom: Float(minus), azimuth: 0, tilt: 0))
    }
}
extension MapMonsterVC: CLLocationManagerDelegate, YMKMapObjectTapListener{
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        let mapObjects = map.mapWindow.map.mapObjects
        guard let mkplatitude = locationManager?.location?.coordinate.latitude else{return false}
        guard let mkplongitude = locationManager?.location?.coordinate.longitude else {return false}
        let coord = YMKPoint(latitude: mkplatitude, longitude: mkplongitude)
        
        let distan = YMKDistance(coord, point)
        if distan < 100{
            mapObjects.remove(with: mapObject)
            mapObject.userData.map { data in
                let image = data as? monsterModel
                guard image?.arr != nil else{return}
                arrMonsters.remove(at: image!.arr)
                var name = ""
                for i in 0...arrMonsters.count - 1{
                    arrMonsters[i].userData.map { data in
                        guard let names = data as? monsterModel else{return}
                        name = names.name
                        
                    }
                    arrMonsters[i].userData = monsterModel(name: name, arr: i)
                    continue
                }
            }
            navigationController?.pushViewController(MonsterViewController(obj: mapObject), animated: true)
        }else{
            alerts(textDesck: "Вы находитесь слишком далеко от монстра – \(distan) метров", textDesc2: "Ok")
        }
        
        
        
        return true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Update location")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
