//
//  MonsterViewController.swift
//  GameMonsters
//
//  Created by Руслан Жигалов on 23.06.2023.
//

import UIKit
import YandexMapsMobile


class MonsterViewController: UIViewController {
    
    var objectMonster: YMKMapObject
    let lvlMonster = Int.random(in: 5...20)
    var arrMonstr: [monsterModel] = MonsterProfileCache.get()
    
    var nameMonster = ""
    private var viewMonster: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var lvlView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 18)
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var nameTextView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 18)
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var imageBack: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "backgr")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var catchMonster: UIButton = {
        let btn = UIButton()
        if #available(iOS 15.0, *) {
            btn.subtitleLabel?.numberOfLines = .max
        } else {
        }
        btn.setTitle("Поймать монстра", for: .normal)
        btn.titleLabel?.numberOfLines = .max
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    init(obj: YMKMapObject) {
        objectMonster = obj
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageBack)
        view.addSubview(viewMonster)
        view.addSubview(catchMonster)
        view.addSubview(lvlView)
        view.addSubview(nameTextView)

        constrSetup()
    }
    func alerts(textDesck: String,textDesc2: String){
        
        let uiAlrt = UIAlertController(title: nil, message: textDesck, preferredStyle: .alert)
        uiAlrt.addAction(UIAlertAction(title: textDesc2, style: .cancel,handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        present(uiAlrt, animated: true)
    }
    func alerts2(textDesck: String,textDesc2: String){
        
        let uiAlrt = UIAlertController(title: nil, message: textDesck, preferredStyle: .alert)
        uiAlrt.addAction(UIAlertAction(title: textDesc2, style: .cancel))
        present(uiAlrt, animated: true)
    }
    @objc func catchMonsterInterest(){
            let randomInterest = Int.random(in: 0...100)
            if randomInterest < 20{
                MonsterProfileCache.save(arrMonstr)
                alerts(textDesck: "Ура! Вы поймали монстра \(nameMonster) в свою команду»", textDesc2: "Вернуться на карту")
                
                
            }
        if randomInterest > 20 && randomInterest < 50{
            alerts(textDesck: "Монстр убежал!", textDesc2: "Вернуться на карту")
        }
        if randomInterest > 50{
            alerts2(textDesck: "Не вышло:( Попробуйте поймать еще раз!", textDesc2: "OK")
        }
    }
    func constrSetup(){
        lvlView.text = "Уровень монстра \(lvlMonster)"
        
        
        viewMonster.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        viewMonster.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        viewMonster.heightAnchor.constraint(equalToConstant: 200).isActive = true
        viewMonster.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lvlView.bottomAnchor.constraint(equalTo: viewMonster.topAnchor, constant: 0).isActive = true
        lvlView.centerXAnchor.constraint(equalTo: viewMonster.centerXAnchor, constant: 0).isActive = true
        lvlView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lvlView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameTextView.bottomAnchor.constraint(equalTo: lvlView.topAnchor, constant: 0).isActive = true
        nameTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        nameTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        catchMonster.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        catchMonster.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        imageBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        imageBack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        imageBack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        imageBack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        catchMonster.addTarget(self, action: #selector(catchMonsterInterest), for: .touchUpInside)
        objectMonster.userData.map { aa in
            var image = aa as? monsterModel
            image?.arr = lvlMonster
            guard image != nil else{return}
            viewMonster.image = UIImage(named:image?.name ?? "")
            nameMonster = image?.name ?? ""
            arrMonstr.append(image ?? monsterModel(name: "", arr: 0))
            nameTextView.text = "Имя монстра \(nameMonster)"
        }
        
    }

}
