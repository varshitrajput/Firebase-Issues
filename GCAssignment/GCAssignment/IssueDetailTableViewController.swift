
//  Created by Varshit Rajput on 10/02/20.


import UIKit


struct Comments: Decodable {
    let user: User
    let body: String
    
}
struct User: Decodable{
    let login : String
}

class IssueDetailTableViewController: UITableViewController {

    var IssuesTitle = [String]()
    var IssuesBody = [String]()
    var noOfComment = 0
    var url = ""
       
       
       override func viewDidLoad() {
           super.viewDidLoad()
               print("View Did Load")
        
        if noOfComment == 0{
            let alert = UIAlertController(title: "Comments", message: "There are no comments on this thread", preferredStyle: UIAlertController.Style.alert)

                   // add an action (button)
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                   // show the alert
                   self.present(alert, animated: true, completion: nil)
        }
        else{
               let urlObj = URL(string: url)
               URLSession.shared.dataTask(with: urlObj!){(data , response ,error) in
                   print(data)
                   do{
                       var Issue = try JSONDecoder().decode([Comments].self, from: data!)
                       
                       for issues in Issue{
                        self.IssuesTitle.append(issues.user.login)
                        self.IssuesBody.append(issues.body)
                        self.tableView.reloadData()
                       }
                       
                   }
                   catch{
                       print("Error Mate")
                       
                   }
                   
               }.resume()
               
        }
           
           
           // Make the row height dynamic
           tableView.estimatedRowHeight = tableView.rowHeight
           tableView.rowHeight = UITableView.automaticDimension
       }
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           tableView.reloadData()
       }
    
       // MARK: - UITableViewDataSource

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return IssuesBody.count  // the number of products in the section
       }

       // indexPath: which section and which row
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as! ProductTableViewCell
           cell.productTitleLabel.text = IssuesTitle[indexPath.row]
           cell.productDescriptionLabel.text = IssuesBody[indexPath.row]
           return cell
       }

}
