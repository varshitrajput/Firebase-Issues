//
//  IntroViewController.swift
//  GameChangeAssignment
//
//  Created by Varshit Rajput on 10/02/20.
//  Copyright © 2020 Varshit. All rights reserved.
//

import UIKit

var IssuesTitle = [String]()
var IssuesBody = [String]()
var IssuesComment = [String]()
var NoOfComment = [Int]()

struct Issues: Decodable {
    let title: String
    let body: String
    let comments_url: String
    let comments: Int
}


class ViewController: UIViewController {
    
    
    
    @IBAction func pressed(_ sender: Any) {
        performSegue(withIdentifier: "toIssues", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true,forKey: "OfflineData")
        if UserDefaults.standard.bool(forKey: "OfflineData") == false  {
            //Data is already saved
            let data = UserDefaults.standard.data(forKey: "OfflineData")
            do{
                var Issue = try JSONDecoder().decode([Issues].self, from: data!)
                print(Issue)
                for issues in Issue{
                    IssuesTitle.append(issues.title)
                    IssuesBody.append(issues.body)
                    IssuesComment.append(issues.comments_url)
                    NoOfComment.append(issues.comments)
                }
                
            }
            catch{
                print("Error Mate")
            }
        }
        else{
            let url = "https://api.github.com/repos/firebase/firebase-ios-sdk/issues"
            let urlObj = URL(string: url)
            URLSession.shared.dataTask(with: urlObj!){(data , response ,error) in
                UserDefaults.standard.set(data, forKey: "RetrievedData")
                UserDefaults.standard.set(false,forKey: "OfflineData")
                print(data)
                do{
                    var Issue = try JSONDecoder().decode([Issues].self, from: data!)
                    print(Issue)
                    for issues in Issue{
                        IssuesTitle.append(issues.title)
                        IssuesBody.append(issues.body)
                        IssuesComment.append(issues.comments_url)
                        NoOfComment.append(issues.comments)
                    }
                    
                }
                catch{
                    print("Error Mate")
                    
                }
                
            }.resume()
        }
        
        
    }
    
    @IBAction func issuesButton(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "OfflineData")
        
        performSegue(withIdentifier: "toIssues", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! IssuesTableViewController
        destinationVC.IssuesTitle = IssuesTitle
        destinationVC.IssuesBody = IssuesBody
        destinationVC.IssuesComment = IssuesComment
        destinationVC.NoOfComment = NoOfComment
    }
    
}

