//
//  MyGameTableViewCell.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class MyGameTableViewCell: UITableViewCell {
    
    var gameButton: UIButton = {
        let gameButton = UIButton()
        gameButton.backgroundColor = .gray
        gameButton.layer.cornerRadius = 20
        gameButton.setTitle("Game", for: .normal)
        gameButton.setTitleColor(.white, for: .normal)
        return gameButton
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(gameButton)
        
        gameButton.translatesAutoresizingMaskIntoConstraints = false
        gameButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        gameButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        gameButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        gameButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        gameButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
