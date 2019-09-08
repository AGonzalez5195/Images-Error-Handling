//
//  ViewController.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/6/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class xkcdViewController: UIViewController {
    
    //MARK: -- Outlets
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicStepper: UIStepper!
    @IBOutlet weak var comicTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    
    //MARK: -- Properties
    var currentxkcdComic: xkcdComic! {
        didSet {
            setStepperValues(numberValue: currentxkcdComic!.num)
            loadCurrentComicImage()
            updateTextFieldPlaceHolderAndLabel()
        }
    }
    
    var mostRecentXKCDComicNumberValue = Int()
    
    //MARK: -- IBActions
    @IBAction func comicStepperPressed(_ sender: UIStepper) {
        let newComicURLFromStepper = xkcdComic().getASpecificComicFromStepper(number: sender.value)
        updateCurrentComicData(newComicURL: newComicURLFromStepper)
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        getRandomComic()
    }
    
    //MARK: -- Functions
    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
        loadMostRecentComic()
    }
    
    private func loadMostRecentComic(){
        xkcdComic.getxkcdComic(ComicURL: xkcdComic().mostRecentComic) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let xkcdComicData):
                    self.currentxkcdComic = xkcdComicData
                    self.mostRecentXKCDComicNumberValue = xkcdComicData.num
                    self.setStepperValues(numberValue: self.mostRecentXKCDComicNumberValue)
                }
            }
        }
    }
    
    private func getRandomComic() {
        let newComicURL = xkcdComic().getASpecificComic(number: Int.random(in: 1...mostRecentXKCDComicNumberValue))
        updateCurrentComicData(newComicURL: newComicURL)
    }
    
    private func updateCurrentComicData(newComicURL: String){
        xkcdComic.getxkcdComic(ComicURL: newComicURL ) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let xkcdComicData):
                    self.currentxkcdComic = xkcdComicData
                    self.loadCurrentComicImage()
                }
            }
        }
    }
    
    private func loadCurrentComicImage() {
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
    
    private func setStepperValues(numberValue: Int){
        let newStepperValue = Double(numberValue)
        self.comicStepper.maximumValue = Double(mostRecentXKCDComicNumberValue)
        self.comicStepper.value = newStepperValue
        self.comicStepper.stepValue = 1
    }
   
    private func updateTextFieldPlaceHolderAndLabel(){
        comicTextField.placeholder = "\(currentxkcdComic.num): \(currentxkcdComic.safe_title)"
        comicTextField.text = ""
        numberLabel.text = currentxkcdComic.num.description
    }
    
    private func setTextFieldDelegate() {
        comicTextField.delegate = self
    }
    
    private func prettifyUI() {
        comicStepper.tintColor = .black
        
        randomButton.layer.cornerRadius = 5
        randomButton.layer.borderColor = UIColor.black.cgColor
        randomButton.layer.borderWidth = 1.0
        
        recentButton.layer.cornerRadius = 5
        recentButton.layer.borderColor = UIColor.black.cgColor
        recentButton.layer.borderWidth = 1.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMostRecentComic()
        setTextFieldDelegate()
        prettifyUI()
    }
}

//MARK: TextfieldDelegate Methods
extension xkcdViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        if string == numberFiltered {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 4
        } else { return false }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let userEnteredXKCDNum = textField.text?.toInt() {
            if userEnteredXKCDNum > mostRecentXKCDComicNumberValue || userEnteredXKCDNum == 0  {
                let alertVC = UIAlertController(title: "Error",
                                                message: "The comic number you have entered does not exist.", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Sorry, I'm dumb",
                                                style: .default,
                                                handler: nil))
                self.present(alertVC, animated: true, completion: nil)
                textField.text = ""
            } else {
                let newComicURLFromTextField = xkcdComic().getASpecificComic(number: userEnteredXKCDNum)
                updateCurrentComicData(newComicURL: newComicURLFromTextField)
            }
        }
        return true
    }
}











//USE THESE BELOW METHODS WHEN YOU WANT THE CURRENT VC TO NOT HAVE A NAVIGATION BAR VIEW BUT THE OTHER VCS TO.

//override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//    navigationController?.setNavigationBarHidden(true, animated: animated)
//}
//
//override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//    navigationController?.setNavigationBarHidden(false, animated: animated)
//}
