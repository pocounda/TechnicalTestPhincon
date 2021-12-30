//
//  PokemonListViewController.swift
//  TestPhincon
//
//  Created by Michael Tanakoman on 29/12/21.
//

import UIKit
import SDWebImage

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var pokemonListTv: UITableView!
    
    let apiService = APIService()
    var dataPokemon = [ListPokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonListTv.delegate = self
        pokemonListTv.dataSource = self
        
        apiService.getPokemonData { data in
            self.dataPokemon = data
            
            DispatchQueue.main.async {
                self.pokemonListTv.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonListTv.dequeueReusableCell(withIdentifier: "cellPokemonList") as! PokemonListTableViewCell
        cell.imagePokemon.sd_setImage(with: URL(string: dataPokemon[indexPath.row].urlImage), completed: nil)
        cell.typePokemon.text = dataPokemon[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetailPostPage(dataSelectedPokemon: dataPokemon[indexPath.row])
    }
    
    func goToDetailPostPage(dataSelectedPokemon: ListPokemon){
        let showDetail = UIStoryboard(name: "PokemonDetail", bundle: nil)
        let vc = showDetail.instantiateViewController(identifier: "PokemonDetail") as! PokemonDetailViewController
        vc.dataSelectedPokemon = dataSelectedPokemon
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
