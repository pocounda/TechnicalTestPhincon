//
//  PokemonDetailViewController.swift
//  TestPhincon
//
//  Created by Michael Tanakoman on 29/12/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var tableAbilities: UITableView!
    @IBOutlet weak var tableMoves: UITableView!
    
    let apiService = APIService()
    let coreData = FuncCoreData()
    var dataSelectedPokemon: ListPokemon?
    var arrayAbilities: [String] = []
    var arrayMoves: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePokemon.sd_setImage(with: URL(string: dataSelectedPokemon!.urlImage), completed: nil)
        
        tableAbilities.delegate = self
        tableAbilities.dataSource = self
        
        tableMoves.delegate = self
        tableMoves.dataSource = self
        
        apiService.getPokemonDetail(url: dataSelectedPokemon?.url ?? "") { data in
            
            for abilities in data.abilities{
                self.arrayAbilities.append(abilities.ability.name)
            }
            
            for moves in data.moves{
                self.arrayMoves.append(moves.move.name)
            }
            
            DispatchQueue.main.async {
                self.tableAbilities.reloadData()
                self.tableMoves.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = dataSelectedPokemon?.name
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func btnCatchClicked(_ sender: Any) {
        let randomBool = Bool.random()
        if randomBool == true{
            showPopUpSuccess()
        }else{
            showPopUpTryAgain(title: "Try Again", message: "You're not lucky", bool: false)
        }
    }
    
    func showPopUpSuccess(){
        let alert = UIAlertController(title: "You Got Pokemon", message: "name this pokemon", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Pokemon Name"
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveButton = UIAlertAction(title: "Save", style: .default) { [self] _ in
            if let inputName = alert.textFields![0].text{
                if inputName == ""{
                    showPopUpTryAgain(title: "Try Again", message: "You must input name", bool: true)
                }else{
                    let id = coreData.retrieve().count + 1
                    coreData.save(name: inputName, dataPokemon: dataSelectedPokemon!, id: id)
                }
            }
        }
        alert.addAction(cancelButton)
        alert.addAction(saveButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showPopUpTryAgain(title: String, message: String, bool: Bool){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            if bool{
                self.showPopUpSuccess()
            }
        }))
        self.present(alert, animated: true)
    }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
            return arrayAbilities.count
        }else if tableView.tag == 2{
            return arrayMoves.count
        }else{
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if tableView.tag == 1{
            cell.textLabel?.text = arrayAbilities[indexPath.row]
        }else if tableView.tag == 2{
            cell.textLabel?.text = arrayMoves[indexPath.row]
        }
        return cell
    }
}

