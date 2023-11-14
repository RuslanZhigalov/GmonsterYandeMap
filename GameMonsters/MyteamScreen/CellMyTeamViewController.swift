

import UIKit
class CellMyTeam: UITableViewCell {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 24, width: 304, height: 16)
        return label
    }()
    private lazy var label2: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 100, y: 24, width: 304, height: 16)
        return label
    }()
    private lazy var imageMonster: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 200, y: 24, width: 50, height: 50)
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(label2)
        contentView.addSubview(imageMonster)
    }
    func configure(_ cell: monsterModel){
        label.text = cell.name
        label2.text = String(cell.arr)
        imageMonster.image = UIImage(named: cell.name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
