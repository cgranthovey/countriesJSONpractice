//
//  ViewController.swift
//  countriesJsonPractice
//
//  Created by Chris Hovey on 6/16/16.
//  Copyright © 2016 Chris Hovey. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var country: Country!
    
    var countries = [Country]()
    var filteredCountries = [Country]()
    
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.whiteColor()
        textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Search Countries", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        
        let textField = searchBar.valueForKey("searchField") as! UITextField
        
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        glassIconView.tintColor = UIColor.whiteColor()
        
        let clearButton = textField.valueForKey("clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: .Normal)
        clearButton.tintColor = UIColor.whiteColor()
        clearButton.alpha = 0.5
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = .Done
        
        self.downloadCountryInfo { () -> () in
            self.tableView.reloadData()     //need to call self instead of viewController here
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredCountries.count
        }else {
            return countries.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("countryCell") as? countryCell{
            if inSearchMode{
                cell.configureCell(filteredCountries[indexPath.row])
            } else {
                cell.configureCell(countries[indexPath.row])
            }
            return cell
        }
        return countryCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if inSearchMode{
            performSegueWithIdentifier("CountryDetailVC", sender: filteredCountries[indexPath.row])
        } else {
            performSegueWithIdentifier("CountryDetailVC", sender: countries[indexPath.row])
        }
    }
    
    func downloadCountryInfo(completed: DownloadComplete){

        print("i'm called")
        let url = NSURL(string: URL_BASE)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            print("in alamofiFire")
            if let JsonCountries = response.result.value as? Array<Dictionary<String, AnyObject>>{
                for JsonCountry in JsonCountries{
                    let country1 = Country.init(aCountry: JsonCountry)
                    self.countries.append(country1)
                }
            }
            completed()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            tableView.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredCountries = countries.filter({$0.name.lowercaseString.rangeOfString(lower) != nil})
            tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        inSearchMode = false
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CountryDetailVC"{
            if let detailVC = segue.destinationViewController as? CountryDetailVC{
                if let countryTapped = sender as? Country{
                    detailVC.countryPicked = countryTapped
                }
            }
        }
    }
    
    
    
}





