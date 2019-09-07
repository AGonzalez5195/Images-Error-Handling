//
//  ViewController.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/6/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class xkcdViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicStepper: UIStepper!
    @IBOutlet weak var comicTextField: UITextField!
    
    var currentxkcdComic = xkcdComic() {
        didSet {
            setCurrentComicImage()
            updateTextFieldPlaceHolder()
        }
    }
    
    var mostRecentXKCDComicNumberValue = Int()
    
    @IBAction func comicStepperPressed(_ sender: UIStepper) {
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        let randomizedNumber = Int.random(in: 1...mostRecentXKCDComicNumberValue)
        let newComicURL = xkcdComic().getASpecificComic(number: randomizedNumber)
        changeCurrentComic(newComicURL: newComicURL)
    }
    
    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
        loadMostRecentComic()
    }
    
    private func loadMostRecentComic(){
        xkcdComic.getxkcdComic(ComicURL: xkcdComic().mostRecentComic) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let xkcdData):
                    self.currentxkcdComic = xkcdData
                    self.mostRecentXKCDComicNumberValue = xkcdData.num
                }
            }
        }
    }
    
    private func changeCurrentComic(newComicURL: String){
        xkcdComic.getxkcdComic(ComicURL: newComicURL ) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let xkcdComicData):
                    self.currentxkcdComic = xkcdComicData
                    self.setCurrentComicImage()
                }
            }
        }
    }
    
    
    private func setCurrentComicImage() {
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
    
    private func updateTextFieldPlaceHolder(){
        self.comicTextField.placeholder = "\(self.currentxkcdComic.num): \(self.currentxkcdComic.safe_title)"
    }
    
    private func setTextFieldDelegate() {
        comicTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMostRecentComic()
        setCurrentComicImage()
        setTextFieldDelegate()
    }


   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        if string == numberFiltered {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 10
        } else { return false }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let userEnteredXKCDNum = textField.text?.toInt() {
            let newComicURLFromTextField = xkcdComic().getASpecificComic(number: userEnteredXKCDNum)
            changeCurrentComic(newComicURL: newComicURLFromTextField)
        }
        return true
    }
}


