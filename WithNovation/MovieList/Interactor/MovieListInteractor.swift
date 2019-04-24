//
//  MovieListInteractor.swift
//  WithNovation
//
//  Created by 김주연 on 22/04/2019.
//  Copyright © 2019 김주연. All rights reserved.
//

import UIKit
import Kanna

class MovieListInteractor: MovieListInputInteractorProtocol {
    
    var presenter: MovieListOutputInteractorProtocol?
    var movies: [Movie]? = nil

    private var currentPage = -1
    private let pageSize = 20
    var moviesCount: Int {
        guard let count = movies?.count else { return 0 }
        return count
    }
    
    func loadMore(index: Int) {
        guard index >= 0 && index < moviesCount else { return }
        loadNextPageIfNeeded(index)
    }
    
    func document(by html: String) -> HTMLDocument? {
        var document: HTMLDocument? = nil
        
        do {
            document = try HTML(html: html, encoding: .utf8)
            
        } catch {
            print(error.localizedDescription)
        }
        
        return document
    }
    
    func downloadHTML(){
        if let url = NSURL(string: addr) {
            do {
                let html = try NSString(contentsOf: url as URL, usedEncoding: nil)
                
                let htmlString:String = html as String
                var movies:[Movie] = []
                
                let galleryWrapPhotosPath = "//div[@class='gallery-wrap photos']"
                let itemPath = "div[@class='item-wrap']"
                let titlePath = "div[@class='caption']/strong"
                
                guard let document = document(by: htmlString) else {
                    self.presenter?.downloadHTMLFail(NSError.createError(0, description: "Parsing error"))
                    return
                }
                
                guard let element = document.at_xpath(galleryWrapPhotosPath) else {
                    self.presenter?.downloadHTMLFail(NSError.createError(0, description: "Parsing error"))
                    return
                }
                
                for item in element.xpath(itemPath) {
                    
                    guard let title = item.at_xpath(titlePath)?.content else { continue }
                    let image = imageURL(item)
                    let movie = Movie(title:title,image:image)
                    
                    movies.append(movie)
                }
                
                movies = movies.sorted(by: {
                    Int($0.title.split(separator: ".")[0])! < Int($1.title.split(separator: ".")[0])!
                })
                
                self.movies = movies
                self.loadNextPageIfNeeded(0)
                
            } catch {
                
                self.presenter?.downloadHTMLFail(NSError.createError(0, description: "Parsing error"))
                
            }
        } else {
            
            self.presenter?.downloadHTMLFail(NSError.createError(0, description: "URL error"))
            
        }
    }
        
    func imageURL(_ item: XMLElement) -> String {
        var imageURL: String = ""
        let imagePath = "div[@class='image-wrap']/a[@class='imagelink']"
        let srcPath = imagePath + "/img[@class='image']"
        let dataSrcPath = imagePath + "/img[@class='image lazy']"
        
        if let path = item.at_xpath(srcPath), let src = path["src"] {
            imageURL = src
            
        } else if let path = item.at_xpath(dataSrcPath), let dataSrc = path["data-src"] {
            imageURL = dataSrc
        }
        
        return imageURL
    }
    
    func loadNextPageIfNeeded(_ index: Int) {
    
        let targetCount = currentPage < 0 ? 0 : (currentPage + 1) * pageSize - 1

        guard index == targetCount else {
            return
        }
        currentPage += 1
        
        let firstIndex = currentPage * pageSize
        let lastIndex = firstIndex + pageSize > moviesCount ? moviesCount : firstIndex + pageSize
        
        let new = Array((self.movies?[firstIndex..<lastIndex])!)
        self.presenter?.getMovieListSuccess(new,firstIndex)

    }
    
}
