//
//  ViewController.swift
//  eam356_p5
//
//  Created by Beth Mieczkowski on 4/10/19.
//  Copyright © 2019 Beth Mieczkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var collectionView1: UICollectionView!
    var collectionView2: UICollectionView!
    var refreshControl: UIRefreshControl!
    var restaurantsArray: [RestaurantView]!
    var filterArray: [Filter]!
    var selectedRestaurants: [RestaurantView]!
    var selectedFilters: [Filter]! = []
    
    let restaurantCellReuseIdentifier = "restaurantCellReuseIdentifier"
    let filterReuseIdentifier = "filterReuseIdentifier"
    let padding: CGFloat = 8
    let filterHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Restaurants"
        title = "My Restaurants"
        view.backgroundColor = .lightGray
        
        let chipotle = RestaurantView(imageName: "chipotle", name: " Chipotle", price: "    $", categories: ["Mexican"], displayed: true, photoDescription: "burrito bowl")
        let snails = RestaurantView(imageName: "snails", name: " Parisian Bistro", price: "  $$$", categories: ["French"], displayed: true, photoDescription: "escargot")
        let pasta = RestaurantView(imageName: "italian", name: " Olive Garden", price: "    $", categories: ["Italian"], displayed: true, photoDescription: "spaghetti and meatballs")
        let padthai = RestaurantView(imageName: "padthai", name: " Taste of Thai", price: "   $$", categories: ["Thai", "Asian"], displayed: true, photoDescription: "pad thai")
        let frenchtoast = RestaurantView(imageName: "frenchtoast", name: " Leo's Diner", price: "    $", categories: ["Breakfast", "Diner"], displayed: true, photoDescription: "french toast")
        let generaltsaos = RestaurantView(imageName: "generaltsaos", name: " PF Changs", price: "    $$", categories: ["Asian"], displayed: true, photoDescription: "chicken")
        let crepe = RestaurantView(imageName: "crepe", name: " Crepetastic", price: "    $", categories: ["French", "Dessert", "Breakfast"], displayed: true, photoDescription: "nutella crepe")
        let mcdonalds = RestaurantView(imageName: "mcdonalds", name: " Mcdonald's", price: "   $$", categories: ["American", "Fast Food"], displayed: true, photoDescription: "burger and fries")
        let breakfastdiner = RestaurantView(imageName: "breakfastdiner", name: " Denny's", price: "    $", categories: ["Diner", "Breakfast", "American"], displayed: true, photoDescription: "bacon and eggs")
        let cupcake = RestaurantView(imageName: "cupcake", name: " Catering Cupcakes", price: "  $$$", categories: ["Dessert"], displayed: true, photoDescription: "chocolate chip cupcakes")
        restaurantsArray = [chipotle, snails, pasta, padthai, frenchtoast, generaltsaos, crepe, mcdonalds, breakfastdiner, cupcake]
        selectedRestaurants = restaurantsArray
        
        let mexican = Filter(name: "Mexican", color: .white, isSelected: false)
        let dessert = Filter(name: "Dessert", color: .white, isSelected: false)
        let asian = Filter(name: "Asian", color: .white, isSelected: false)
        let french = Filter(name: "French", color: .white, isSelected: false)
        let american = Filter(name: "American", color: .white, isSelected: false)
        let breakfast = Filter(name: "Breakfast", color: .white, isSelected: false)
        let thai = Filter(name: "Thai", color: .white, isSelected: false)
        let italian = Filter(name: "Italian", color: .white, isSelected: false)
        let fastfood = Filter(name: "Fast Food", color: .white, isSelected: false)
        let diner = Filter(name: "Diner", color: .white, isSelected: false)
        filterArray = [mexican, dessert, asian, french, american, breakfast, thai, italian, fastfood, diner]
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView1.translatesAutoresizingMaskIntoConstraints = false
        collectionView1.backgroundColor = .lightGray
        collectionView1.dataSource = self
        collectionView1.delegate = self
        collectionView1.refreshControl = refreshControl
        collectionView1.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: restaurantCellReuseIdentifier)
        view.addSubview(collectionView1)
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        layout2.minimumInteritemSpacing = padding
        layout2.minimumLineSpacing = padding
        collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: layout2)
        collectionView2.translatesAutoresizingMaskIntoConstraints = false
        collectionView2.backgroundColor = .lightGray
        collectionView2.layer.cornerRadius = 10
        collectionView2.dataSource = self
        collectionView2.delegate = self
        collectionView2.refreshControl = refreshControl
        collectionView2.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseIdentifier)
        view.addSubview(collectionView2)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView1.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]);
        NSLayoutConstraint.activate([
            collectionView2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView2.heightAnchor.constraint(equalToConstant: 50),
            collectionView2.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    @objc func pulledToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.refreshControl.endRefreshing()
        }
    }
}


extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantCellReuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
            let restaurant = selectedRestaurants[indexPath.item]
            cell.configure(for: restaurant)
            return cell
        }
        else {
            let cell = collectionView2.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            let filter = filterArray[indexPath.item]
            cell.configure(for: filter)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView1 {
            return selectedRestaurants.count
        }
        else {
            return filterArray.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.collectionView1 {
            let photoView = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantCellReuseIdentifier, for: indexPath)
            return photoView
        }
        else {
            let filterView = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath)
            return filterView
        }
    }
}


extension ViewController: UICollectionViewDelegate {

    func beginFilter(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRestaurants = []
        let filter = filterArray[indexPath.item]
        selectedFilters.append(filter)
        for rest in restaurantsArray {
            for fil in selectedFilters {
                if rest.categories.contains(fil.name) {
                    if !selectedRestaurants.contains(where: {$0.restaurantName == rest.restaurantName}) {
                        selectedRestaurants.append(rest)
                        rest.displayed = true
                    }
                else {
                    rest.displayed = false
                }
            }
        }
        self.collectionView1.reloadData()
        }
    }
    
    func endFilter(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = filterArray[indexPath.item]
        selectedFilters.remove(at: selectedFilters.count-1)
        for rest in restaurantsArray {
            if selectedFilters.count == 0 {
                selectedRestaurants = restaurantsArray
            }
            else {
                if rest.categories.contains(filter.name) && rest.displayed == true {
                    rest.displayed = false
                    selectedRestaurants = selectedRestaurants.filter( {$0.restaurantName != rest.restaurantName})
                }
            }
        self.collectionView1.reloadData()
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView1 {
            collectionView.reloadData()
            collectionView.collectionViewLayout.invalidateLayout()
        }
        else if collectionView == self.collectionView2 {
            let filter = filterArray[indexPath.item]
            if filter.isSelected == false {
                filter.isSelected = true
                beginFilter(collectionView, didSelectItemAt: indexPath)
                collectionView.reloadData()
            }
            else {
                filter.isSelected = false
                endFilter(collectionView, didSelectItemAt: indexPath)
            }
            collectionView.reloadItems(at: [indexPath])
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }

}



// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView1 {
            let length = ((collectionView.frame.width - padding * 4) / 2.0) + 10.0
            return CGSize(width: length, height: length)
        }
        else {
            return CGSize(width: 75.0, height: 50.0)
        }
    }

}


