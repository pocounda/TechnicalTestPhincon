//
//  APIService.swift
//  TestPhincon
//
//  Created by Michael Tanakoman on 29/12/21.
//

import Foundation

class APIService{
    var arrayDataPokemon: [ListPokemon] = []
    let myGroup = DispatchGroup()
    
    func getPokemonData(completion: @escaping ([ListPokemon]) -> Void){
        let jsonURLString = "https://pokeapi.co/api/v2/pokemon?limit=200&offset=0"
        guard let url = URL(string: jsonURLString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            do{
                let results = try JSONDecoder().decode(Results.self, from: data)
                
                for data in results.results{
                    self.myGroup.enter()
                    self.getPokemonDetail(url: data.url) { url in
                        self.arrayDataPokemon.append(ListPokemon(name: data.name, url: data.url, urlImage: url.sprites.front_default))
                        self.myGroup.leave()
                    }
                }
                
                self.myGroup.notify(queue: .main){
                    completion(self.arrayDataPokemon)
                }
                
            }catch let jsonErr{
                print(jsonErr)
            }
        }.resume()
    }
    
    func getPokemonDetail(url: String, completion: @escaping (DetailPokemon) -> Void){
        let jsonURLString = url
        guard let url = URL(string: jsonURLString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            do{
                let results = try JSONDecoder().decode(DetailPokemon.self, from: data)
                
                DispatchQueue.main.sync {
                    completion(results)
                }
            }catch let jsonErr{
                print(jsonErr)
            }
        }.resume()
    }
}
