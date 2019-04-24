//
//  MovieListRouter.swift
//  WithNovation
//
//  Created by 김주연 on 22/04/2019.
//  Copyright © 2019 김주연. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class MovieListRouter: MovieListRouterProtocol {
    
    static func createMovieListModule(_ view: MovieListView) {
        let presenter: MovieListPresenterProtocol & MovieListOutputInteractorProtocol = MovieListPresenter()
        view.presenter = presenter
        view.presenter?.router = MovieListRouter()
        view.presenter?.view = view
        view.presenter?.interactor = MovieListInteractor()
        view.presenter?.interactor?.presenter = presenter

    }
    
    func presentMovieDetail(_ cell:MovieListCell,_ imageURL:String,_ view:UIViewController){
        
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImageURL(imageURL)
        photo.shouldCachePhotoURLImage = false
        images.append(photo)
        
        let originImage = cell.imageView.image
        let browser = SKPhotoBrowser(originImage: originImage ?? UIImage(), photos: images, animatedFromView: cell)
        browser.initializePageIndex(0)
        view.present(browser, animated: true, completion: {})
        
    }
    
}
