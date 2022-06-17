//
//  ShowDetailController.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import UIKit

class ShowDetailController: UIViewController {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var quantity: UILabel!
    var quantityTextNumber = 1
    var product = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTitle.text = product.productName
        quantity.text = String(quantityTextNumber)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addToBasketAction(_ sender: Any)
    {
        if quantityTextNumber > 0
        {
            let addcart = Cart.coppied
            
            
            CoreData.shared.getAuthObject(completionBlock: { auth in
                
                let cartProduct = CartProduct(userId: auth!.id , productId: Int64(self.product.productId!), quantitiy: Int64(self.product.amount!))
                addcart.addToCart(product: cartProduct) { [self] addedProduct, data, response in
                    if response.getStatusCode() == 200
                    {
                        CoreData.shared.addToBasket(product: self.product, quantityNew: quantityTextNumber)
                        print("*********************OLDU**********************OLDU**********************")
                    }
                    else{
                        print("Error")
                    }
                }
                //CoreData.shared.addToBasket(product: product, quantityNew: quantityTextNumber)
                self.navigationController?.popViewController(animated: true)
            })
            
        }
        else
        {
            Alert.makeAlert(titleInput: "", messageInput: "Lütfen en az bir ürün seçiniz.", viewController: self)
        }
        
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {quantityTextNumber += 1;quantity.text = String(quantityTextNumber)}
    @IBAction func minusButtonAction(_ sender: Any)
    {
        if quantityTextNumber != 0
        {
            quantityTextNumber -= 1;quantity.text = String(quantityTextNumber)
        }
    }
}
