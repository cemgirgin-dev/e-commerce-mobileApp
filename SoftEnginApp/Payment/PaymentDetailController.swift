//
//  PaymentDetailController.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import UIKit

class PaymentDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        totalPrice.text = "Toplam Tutar: " + String(format: "%.1f",CoreData.shared.calculateTotalPrice()) + " $"
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreData.shared.returnBasket().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentCell
        cell.label.text = CoreData.shared.returnBasket()[indexPath.row].productName
        cell.quantity.text = String(format: "%.1f",Double(CoreData.shared.returnBasket()[indexPath.row].amount!) * CoreData.shared.returnBasket()[indexPath.row].price!) + " $"
        cell.price.text = String(Int(CoreData.shared.returnBasket()[indexPath.row].amount!))
        return cell
    }

    @IBAction func backToHome(_ sender: Any) {
        CoreData.shared.deleteAllBasket()
        self.performSegue(withIdentifier: "finishTransaction", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
