//
//  EventComponent.swift
//  Eureka
//
//  Created by Luke Mueller on 14.10.17.
//  Copyright © 2017 Jugend hackt. All rights reserved.
//

import UIKit

class EventComponent: UICollectionViewCell {
    
    var events = [Event]()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 100)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(EventCell.self, forCellWithReuseIdentifier: "event")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(titleLabel, collection)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            collection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            collection.heightAnchor.constraint(equalToConstant: 150),
        ])
        
    }
    
    func addSubviews(_ views: UIView...) { views.forEach { addSubview($0) } }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class EventCell: UICollectionViewCell {
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(timeLabel, placeLabel, viewersLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            placeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            placeLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: 10),
            
            viewersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            viewersLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}


extension EventComponent: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "event", for: indexPath) as! EventCell
        cell.viewersLabel.text = "20/30"
        cell.placeLabel.text = events[indexPath.row].place
        cell.timeLabel.text = "5pm, October 15th"
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
}
