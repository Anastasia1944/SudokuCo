//
//  MyGameTableViewCell.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class MyGameTableViewCell: UITableViewCell {
    
    var gameImageView: UIImageView = {
        let gameImageView = UIImageView()
        gameImageView.image = UIImage(named: "GamePlug")
        return gameImageView
    }()
    
    var gameLabel: UILabel = {
        let gameLabel = UILabel()
        gameLabel.text = "Game Name"
        gameLabel.font = UIFont.systemFont(ofSize: 20)
        gameLabel.textAlignment = .center
        gameLabel.tintColor = .blueSys
        return gameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(gameImageView)
        
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        
        gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        gameImageView.widthAnchor.constraint(equalTo: gameImageView.heightAnchor, multiplier: 1.0/1.0).isActive = true
        
        
        contentView.addSubview(gameLabel)
        
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        gameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        gameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        gameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        gameLabel.trailingAnchor.constraint(equalTo: gameImageView.leadingAnchor, constant: -20).isActive = true
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
