//
//  cashOutViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 4/13/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit

class cashOutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var arr:[String]=["NotMe","Telidhu","Chepanu"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arr.count != nil{
            return arr.count}
        else {
            return 0
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CashoutTableViewCell
        cell.from.text=arr[indexPath.row]
        //cell.repay.text=arr[indexPath.row+1]
        //cell.borrowed.text=arr[indexPath.row+2]
       return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
