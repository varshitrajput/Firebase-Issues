
//  Created by Varshit Rajput on 10/02/20.


import UIKit

class IssuesTableViewController: UITableViewController {
    var IssuesTitle = [String]()
    var IssuesBody = [String]()
    var IssuesComment = [String]()
    var NoOfComment = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Make the row height dynamic
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
 
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return IssuesBody.count  // the number of products in the section
    }

    // indexPath: which section and which row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as! ProductTableViewCell
        cell.productTitleLabel.text = IssuesTitle[indexPath.row]
        cell.productDescriptionLabel.text = String(IssuesBody[indexPath.row].prefix(140))
        return cell
    }
    
    // MARK: - Edit Tableview
    var issuedetail = ""
     var issuename = ""
    var issuecomment = ""
    var no = 0
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        issuename = IssuesTitle[indexPath.row]
        issuedetail = IssuesBody[indexPath.row]
        issuecomment = IssuesComment[indexPath.row]
        no = NoOfComment[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: self)
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destinationVC = segue.destination as! IssueDetailTableViewController
        destinationVC.IssuesTitle.removeAll()
        destinationVC.IssuesBody.removeAll()
        destinationVC.IssuesTitle.append(issuename)
        destinationVC.IssuesBody.append(issuedetail)
        destinationVC.IssuesTitle.append("COMMENTS")
        destinationVC.IssuesBody.append("Comments are retrieved from GIT")
        destinationVC.url = issuecomment
        destinationVC.noOfComment = no
        
    }
   


    
    // MARK: - Navigation
   
 
    
}
