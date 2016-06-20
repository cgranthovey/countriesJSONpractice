//
//  CountryDetailVC.swift
//  countriesJsonPractice
//
//  Created by Chris Hovey on 6/17/16.
//  Copyright © 2016 Chris Hovey. All rights reserved.
//

import UIKit
import Alamofire

class CountryDetailVC: UIViewController {

    var countryPicked: Country!
    
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var languages: UILabel!
    @IBOutlet weak var neighbors: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var imgShadowView: UIView!
    
    static var imageCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        flagImg.clipsToBounds = true
        
        imgShadowView.layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 1.0).CGColor
        imgShadowView.layer.shadowOpacity = 0.7
        imgShadowView.layer.shadowRadius = 2.0
        imgShadowView.layer.shadowOffset = CGSizeMake(0, 2.0)
        
    }
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer){
        if sender.direction == .Right{
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func updateUI(){
        print("me")
        self.countryName.text = countryPicked.name
        self.capital.text = countryPicked.capital
        self.region.text = countryPicked.subRegion
        self.population.text = countryPicked.population
        
        self.languages.text = countryPicked.languages
        self.neighbors.text = countryPicked.borderCountries
        
        var img: UIImage!
        let url = countryPicked.imgURL
        print("url\(url)")

        img = CountryDetailVC.imageCache.objectForKey(url) as? UIImage
        if countryPicked.imgURL != ""{
            print(".imgurl called")
            flagImg.hidden = false
            if img != nil{
                self.flagImg.image = img
            } else {
                Alamofire.request(.GET, countryPicked.imgURL).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in  //the image/* just means that we are optimizing for images
                    if err == nil{      //in completionHandler, if error is not nil then grab it
                        if let img = UIImage(data: data!){
                            self.flagImg.image = img
                            CountryDetailVC.imageCache.setObject(img, forKey: self.countryPicked.imgURL)
                        }
                    }

            })
            }
        } else{
            flagImg.hidden = true
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    

    
    

}
