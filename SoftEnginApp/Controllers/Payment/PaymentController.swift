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
    let cartService = CartService.coppied
    var cart = Cart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartService.getCart() { cart in
            DispatchQueue.main.sync {
                self.cart = cart
                self.spinner.isHidden = true
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.price.text = String(format: "%.1f",cart.totalPrice as! CVarArg) + " $"
            }
        
            
        }
        

    }
    
    @IBAction func payWithCreditCardAction(_ sender: Any)
    {
        spinner.isHidden = false
        CoreData.shared.getAuthObject { auth in
            var payments = Payment(cardNumber:111,userId: auth!.id)
            
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
        return cart.addedProducts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentCell
        cell.label.text = cart.addedProducts![indexPath.row].productName
        cell.price.text = String(format: "%.1f",Double(cart.addedProducts![indexPath.row].price!) * Double(cart.addedProducts![indexPath.row].quantity!)) + " $"
        cell.quantity.text = String(Int(cart.addedProducts![indexPath.row].quantity!))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postpayment"
        {
            if let nextViewController = segue.destination as? PaymentDetailController {
                nextViewController.cart = cart
                    }
        }
    
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
