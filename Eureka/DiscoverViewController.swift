//
//  DiscoverViewController.swift
//  Eureka
//
//  Created by Luke Mueller on 14.10.17.
//  Copyright © 2017 Jugend hackt. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Live", "Planned"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
        return sc
    }()
    
    var events: [String: [Event]] = [
//        "Popular": [Event(id: "50", creationDate: Date(), creatorId: "herhtr", place: "Tokyo", activityId: "gergr", time: Date(), lang: "gerger"),
//        Event(id: "50", creationDate: Date(), creatorId: "herhtr", place: "San Francisco", activityId: "gergr", time: Date(), lang: "errgr"),
//        Event(id: "50", creationDate: Date(), creatorId: "herhtr", place: "Seattle", activityId: "gergr", time: Date(), lang: "errgr")
//        ],
//        "Recent": [Event(id: "50", creationDate: Date(), creatorId: "herhtr", place: "Tokyo", activityId: "gergr", time: Date(), lang: "gerger"),Event(id: "50", creationDate: Date(), creatorId: "herhtr", place: "Tokyo", activityId: "gergr", time: Date(), lang: "gerger")]
        :] {
        didSet {
            print("Change")
        }
    }

    lazy var mainCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(EventComponent.self, forCellWithReuseIdentifier: "main")
        cv.backgroundColor = .clear
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView = segmentedControl
        
        addViewsTo(view: view, views: mainCollection)
        NSLayoutConstraint.activate([
            mainCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainCollection.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        
        DispatchQueue.main.async {
            self.test()
        }
        
    }
    
    func segmentControlChanged(control: UISegmentedControl) {
        print(control.selectedSegmentIndex)
    }
    
    func addViewsTo(view: UIView, views: UIView...) { views.forEach { view.addSubview($0) } }
    
    func test() {
        let url = URL(string: "http://127.0.0.1:8080/graphql")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "{" +
            "events(offset: 0){" +
                "recent {" +
                    "id," +
                    "creationDate," +
                    "creatorId," +
                    "place" +
                "}" +
            "}" +
        "}"
        
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            
            print("Hey")
            guard let data = data, err == nil else {
                print("Hey")
                print(err!.localizedDescription)
                return
            }
            
            if let httpStatus = res as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Bad status")
            }
            
//            let resStr = String(data: data, encoding: .utf8)
//            print(resStr!)
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else { return }
                
                let data = json["data"] as! [String:AnyObject]
                var events = data["events"] as! [String:[AnyObject]]

                let recentEvents = events["recent"]!
                self.events["Recent"] = self.jsonSectionToEvent(recentEvents)
                
                self.mainCollection.reloadData()
                
            } catch let error {
                fatalError(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
    
    func jsonSectionToEvent(_ section: [AnyObject]) -> [Event] {
        let finalEvents = section.map { event -> Event in
            let place = event["place"] as! String
            let creationDateStr = event["creationDate"]!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: creationDateStr as! String)
            
            print(date!)
            
            let creatorId = event["creatorId"] as! String
            let id = event["id"] as! String
            
            print(place, creationDateStr, creatorId, id)
            
            let finalEvent = Event(id: id, creationDate: date!, creatorId: creatorId, place: place, activityId: "gerg", time: Date(), lang: "DE")
            
            return finalEvent
        }
        
        return finalEvents
        
    }
    
//    func getData() {
////        let apiUserUrl = URL(string: "http://127.0.0.1:8080/graphql")
////        
////        URLSession.shared.dataTask(with: apiUserUrl!) { data, res, err in
////            do {
////                guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:[String:Any]] else { return }
////                print(json)
////                
////            } catch let error {
////                fatalError(error.localizedDescription)
////            }
////        }.resume()
//        
//        let apiUserUrl = URL(string: "http://127.0.0.1:8080/graphql")
//        var request = URLRequest(url: apiUserUrl!)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//
//        
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
//        request.httpBody = httpBody
//        
//        let session = URLSession.shared.dataTask(with: request) { data, res, err in
//            
//            }.resume()
//        
//    }
}


extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main", for: indexPath) as! EventComponent
        cell.backgroundColor = .clear
        print("KEYS")
        print(events.keys)
        
        
        
        let key = Array(events.keys)[indexPath.row]
        
        cell.titleLabel.text = key
        cell.events = events[key]!
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
}

