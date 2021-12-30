//
//  MyPokemonViewController.swift
//  TestPhincon
//
//  Created by Michael Tanakoman on 30/12/21.
//

import UIKit
import CoreData

class MyPokemonViewController: UIViewController {

    @IBOutlet weak var myPokemonTV: UITableView!
    
    let coreData = FuncCoreData()
    var savedPokemon: [SavedPokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myPokemonTV.delegate = self
        myPokemonTV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedPokemon = coreData.retrieve()
        myPokemonTV.reloadData()
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension MyPokemonViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myPokemonTV.dequeueReusableCell(withIdentifier: "myPokemonCell") as! MyPokemonTableViewCell
        cell.imagePokemon.sd_setImage(with: URL(string: savedPokemon[indexPath.row].urlImage), completed: nil)
        cell.namePokemon.text = savedPokemon[indexPath.row].name
        cell.typePokemon.text = savedPokemon[indexPath.row].type
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Release"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            coreData.delete(id: savedPokemon[indexPath.row].id)
            savedPokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
