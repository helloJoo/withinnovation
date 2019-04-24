//
//  ViewController.swift
//  WithNovation
//
//  Created by 김주연 on 22/04/2019.
//  Copyright © 2019 김주연. All rights reserved.
//

import UIKit

class MovieListView: UICollectionViewController, MovieListViewProtocol, UtilProtocol {
    
    var presenter: MovieListPresenterProtocol?
    var list: [Movie] = []
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
        MovieListRouter.createMovieListModule(self)
        presenter?.viewDidLoad()
        
    }
    
    //MARK: - Data

    func showMovieList(_ movies: [Movie],_ index:Int) {
                
        for movie in movies{
            self.list.append(movie)
        }
        
        self.collectionView.reloadData()
        
    }
    
    func downloadHTMLFail(_ error: NSError) {
        
        alert(message: error.description, done: "재시도", view: self, completion: { ok in
            if ok {
                self.presenter?.downloadHTML()
            }
        })
        
    }

}

//MARK: - UICollectionViewDataSource

extension MovieListView {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.list.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieListCell
        cell.movie = self.list[indexPath.row]
        
        presenter?.collectionView(cellForItemAt: indexPath)

        return cell
    }
    
}

//MARK: - UICollectionViewDelegate
extension MovieListView  {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! MovieListCell
        presenter?.collectionView(didSelect: cell, self.list[indexPath.item].image, self)

    }
    
}
