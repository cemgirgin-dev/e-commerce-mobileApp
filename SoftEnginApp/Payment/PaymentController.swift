//
//  PaymentController.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import UIKit

class PaymentController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        price.text = String(format: "%.1f",CoreData.shared.calculateTotalPrice()) + " $"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func payWithCreditCardAction(_ sender: Any)
    {
        spinner.isHidden = false
        CoreData.shared.getAuthObject { auth in
            var paymentProducts = [PaymentProduct]()
            for item in CoreData.shared.returnBasket()
            {
                paymentProducts.append(PaymentProduct(productId: item.productId!, quantity: item.amount!))
            }
            var payments = Payment(customerId: Int(auth!.id) , paymentProducts: paymentProducts)
            PostPayment.shared.postPayment(payment: payments) { bool,message  in
                DispatchQueue.main.sync {self.spinner.isHidden = true}
                if bool
                {
                    DispatchQueue.main.sync {self.performSegue(withIdentifier: "postpayment", sender: self)}
                }
                else
                {
                    Alert.makeAlert(titleInput: "Sipariş Tamamlanamadı", messageInput: message!, viewController: self)
                }
            }
            
        }
        
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
    
    

}




class PaymentCell: UITableViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
