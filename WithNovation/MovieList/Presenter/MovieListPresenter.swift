//
//  MovieListPresenter.swift
//  WithNovation
//
//  Created by 김주연 on 22/04/2019.
//  Copyright © 2019 김주연. All rights reserved.
//

import UIKit

class MovieListPresenter: MovieListPresenterProtocol {
    
    var view: MovieListViewProtocol?
    var interactor: MovieListInputInteractorProtocol?
    var router: MovieListRouterProtocol?
    
    func viewDidLoad() {

        downloadHTML()
    }
    
    func downloadHTML(){
        
        interactor?.downloadHTML()
        
    }
    
    func collectionView(cellForItemAt indexPath: IndexPath) {
        
        interactor?.loadMore(index: indexPath.row)
        
    }
    
    func collectionView(didSelect cell: MovieListCell, _ imageURL: String,_ view:UIViewController) {
        
        router?.presentMovieDetail(cell, imageURL, view)
        
    }
    
}

extension MovieListPresenter: MovieListOutputInteractorProtocol {
    
    func getMovieListSuccess(_ movies: [Movie],_ index:Int) {
        
        view?.showMovieList(movies,index)
        
    }
    
    func downloadHTMLFail(_ error:NSError) {
        
        view?.downloadHTMLFail(error)
        
    }
    
}
