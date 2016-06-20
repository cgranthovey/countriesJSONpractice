//
//  Country.swift
//  countriesJsonPractice
//
//  Created by Chris Hovey on 6/16/16.
//  Copyright © 2016 Chris Hovey. All rights reserved.
//

import Foundation
import Alamofire

class Country{
    
    
    private var _name: String!
    private var _capital: String!
    private var _subRegion: String!
    private var _population: Int!
    private var _borderCountries: [String]!
    private var _langauges: [String]!
    private var _imgUrl: String!
    
    var name: String{
        return _name
    }
    
    var capital: String{
        if _capital == nil{
            _capital = "-"
        }
        return _capital
    }
    
    var subRegion: String{
        if _subRegion == nil{
            _subRegion = "-"
        }
        return _subRegion
    }
    
    var population: String{
        if _population == nil{
        return "-"
        }
        
        let tempNumber = _population
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let x = numberFormatter.stringFromNumber(tempNumber)!
        return x
    }
    
    var borderCountries: String{
        if _borderCountries == nil{
            _borderCountries = [""]
        }
        let tempCountries = _borderCountries
        return codeConverter().convertToFullName(tempCountries)
    }
    
    var languages: String{
        if _langauges == nil{
            _langauges = [""]
        }
        let tempLanguages = _langauges
        return codeConverter().convertToFullLanguage(tempLanguages)
    }
    
    var imgURL: String{
        if _imgUrl == nil{
            _imgUrl = ""
        }
        return _imgUrl
    }
    
    init(aCountry: Dictionary<String, AnyObject>){
        if let name = aCountry["name"] as? String{
            self._name = name
        }
        
        if let capital = aCountry["capital"] as? String{
            self._capital = capital
        }
        
        if let subRegion = aCountry["subregion"] as? String{
            self._subRegion = subRegion
        }
        
        if let population = aCountry["population"] as? Int{
            self._population = population
        }
        
        if let borderCountries = aCountry["borders"] as? [String]{
            self._borderCountries = borderCountries
        }
        
        if let languages = aCountry["languages"] as? [String]{
            self._langauges = languages
        }
        
        if let code = aCountry["alpha2Code"] as? String{
            self._imgUrl = "http://www.geonames.org/flas/x/\(code.lowercaseString).gif"
        }
    }
    

    
    
//    func downloadCountryInfo(completed: DownloadComplete){
//        let url = NSURL(string: URL_BASE)!
//        
//        Alamofire.request(.GET, url).responseJSON { response in
//            if let JsonCountries = response.result.value as? Array<Dictionary<String, AnyObject>>{
//                
//                if let JsonCountry = JsonCountries[x]
//                
//                if let name = JsonCountries["name"] as{
//                    self._name = name
//                }
//                if let capital = JsonCountries["capital"]{
//                    self._capital = capital
//                }
//                
//            }
//        }
//    }
}



























