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
    var cart = Cart()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.totalPrice.text = String(format: "%.1f",cart.totalPrice as! CVarArg) + " $"
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.addedProducts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentCell
        cell.label.text = cart.addedProducts![indexPath.row].productName
        cell.price.text = String(format: "%.1f",Double(cart.addedProducts![indexPath.row].price!) * Double(cart.addedProducts![indexPath.row].quantity!)) + " $"
        cell.quantity.text = String(Int(cart.addedProducts![indexPath.row].quantity!))
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
