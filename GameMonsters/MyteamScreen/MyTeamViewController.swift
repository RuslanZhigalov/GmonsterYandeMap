//
//  MyTeamViewController.swift
//  GameMonsters
//
//  Created by Руслан Жигалов on 23.06.2023.
//

import UIKit

class MyTeamViewController: UIViewController {
    var moneyArr = MonsterProfileCache.get()
    let identificatorCellLabelAndImage = "CellMonsterTeam"
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        title = "Моя команда"
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        moneyArr = MonsterProfileCache.get()
        tableView.register(CellMyTeam.self, forCellReuseIdentifier: identificatorCellLabelAndImage)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        setupConstr()
    }
    func setupConstr(){
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    


}
extension MyTeamViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moneyArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identificatorCellLabelAndImage) as? CellMyTeam
        guard let viewModel = moneyArr?[indexPath.row]  else{return UITableViewCell()}
        cell?.configure(viewModel)
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
