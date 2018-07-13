//
//  ViewController.swift
//  Alamofire Server Data
//
//  Created by Ahmet Berkay CALISTI on 07/07/2018.
//  Copyright © 2018 Ahmet Berkay CALISTI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [Person]()
    
    
    // Since Alamofire is thread-safe which means that it automatically brings the responses into the main thread it will update the UI properly
    @IBAction func onGetTapped() {
        print("GET")
        NetworkingService.shared.getPeople { response in
            self.people = response.people
            self.tableView.reloadData()
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "PeopleToDetails",
        let detailsVC = segue.destination as? DetailsViewController,
            
            // The weird thing about Swift three is that if you send a swift object which is your own custom object and pass it as any at least for segue I don't know about other anything else, when it gets passed as any it loses like the bridging between swift and objective c to be able to pass that object kind of gets messy. So you actually have to cast it, so we'll do guard let a sender will do guard let person 
        let person = sender as AnyObject as? Person
            else { return }
        detailsVC.person = person
        
    }
}




extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return people.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = people[indexPath.row].name
        
        return cell
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PeopleToDetails", sender: people[indexPath.row])
    }
}
