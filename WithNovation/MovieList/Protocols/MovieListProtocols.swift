//
//  MovieProtocols.swift
//  WithNovation
//
//  Created by 김주연 on 22/04/2019.
//  Copyright © 2019 김주연. All rights reserved.
//

import UIKit


protocol MovieListViewProtocol: class {
    
    var presenter: MovieListPresenterProtocol? {get set}
    func showMovieList(_ movies: [Movie],_ index:Int)
    func downloadHTMLFail(_ error:NSError)
    
}

protocol MovieListPresenterProtocol: class {
    
    var view: MovieListViewProtocol? {get set}
    var interactor: MovieListInputInteractorProtocol? {get set}
    var router: MovieListRouterProtocol? {get set}
    
    func viewDidLoad()
    func downloadHTML()
    func collectionView(cellForItemAt indexPath: IndexPath)
    func collectionView(didSelect cell: MovieListCell,_ imageURL:String,_ view:UIViewController)

}

protocol MovieListInputInteractorProtocol: class {
    
    var presenter: MovieListOutputInteractorProtocol? {get set}
    func downloadHTML()
    func loadMore(index: Int)
}

protocol MovieListOutputInteractorProtocol: class {
    
    func getMovieListSuccess(_ movies: [Movie],_ index:Int)
    func downloadHTMLFail(_ error:NSError)
    
}

protocol MovieListRouterProtocol: class {
    
    static func createMovieListModule(_ view: MovieListView)
    func presentMovieDetail(_ cell:MovieListCell,_ imageURL:String,_ view:UIViewController)
    
}
