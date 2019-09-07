//
//  ViewController.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/6/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class xkcdViewController: UIViewController {
    
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicStepper: UIStepper!
    @IBOutlet weak var comicTextField: UITextField!
    
    var currentxkcdComic = xkcdComic() {
        didSet {
            setComicImage()
        }
    }
    
    
    @IBAction func comicStepperPressed(_ sender: UIStepper) {
    }
    @IBAction func randomButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
    }
    
    private func loadData(){
        xkcdComic.getXKCDData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let xkcdData):
                    self.currentxkcdComic = xkcdData
                    
                }
            }
        }
    }
    
    private func setComicImage() {
        ImageHelper.shared.fetchImage(urlString: currentxkcdComic.img) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    self.comicImage.image = imageFromOnline
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setComicImage()
    }
}

