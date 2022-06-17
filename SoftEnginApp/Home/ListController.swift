//
//  ListController.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 8.01.2022.
//

import UIKit

class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
  
    

    @IBOutlet weak var segmentedView: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var products = [Product]()
    var filteredProducts = [Product]()
    var selectedProduct = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        FetchProduct.shared.getProduct { products in
            self.products = products
            self.filteredProducts = products.filter({ product in
                return product.category == "Cep Telefonu"
            })
            DispatchQueue.main.sync {self.tableView.reloadData()}
            
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func segmentedViewChanged(_ sender: Any)
    {
        if segmentedView.selectedSegmentIndex == 0
        {
            filterByCategory(category: "Cep Telefonu")
        }
        else if segmentedView.selectedSegmentIndex == 1
        {
            filterByCategory(category: "Teknolojik Ürünler")
        }
        else if segmentedView.selectedSegmentIndex == 2
        {
            filterByCategory(category: "Oyun konsolu")
        }
        else
        {
            filterByCategory(category: "Kişisel Bakım")
        }
    }
    
    func filterByCategory(category : String){
        self.filteredProducts = products.filter({ product in
            return product.category == category
        })
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        cell.label.text = filteredProducts[indexPath.row].productName ?? ""
        cell.price.text = String(format: "%.1f",filteredProducts[indexPath.row].price!) + " $"
        cell.product = filteredProducts[indexPath.row]
        cell.yourController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedProduct = filteredProducts[indexPath.row]
        self.performSegue(withIdentifier: "fullScreenSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "fullScreenSegue")
        {
            let des = segue.destination as! ShowDetailController
            des.product = selectedProduct
            
        }
    }
    
    
}

class ListCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var price: UILabel!
    var product = Product()
    weak var yourController : ListController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addButtonAction(_ sender: Any)
    {
        let addcart = Cart.coppied
        
        /*
        let cartProduct = CartProduct(userId: auth.id, productId: <#T##Int#>, quantitiy: <#T##Int#>)
        
        addcart.addToCart(product: product) { [self] addedProduct, data, response in
            if response.getStatusCode() == 200
            {
                CoreData.shared.addToBasket(product: self.product, quantityNew: 1)
                print("*********************OLDU**********************OLDU**********************")
            }
            else{
                print("Error")
            }
        }
        */
       // CoreData.shared.addToBasket(product: product, quantityNew: 1)
        Alert.makeAlert(titleInput: "", messageInput: "Ürün sepetinize eklendi.", viewController: yourController!)
    }
}
