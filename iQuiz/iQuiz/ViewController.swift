//
//  ViewController.swift
//  iQuiz
//
//  Created by Vishesh Sood on 5/1/17.
//  Copyright © 2017 Vishesh Sood. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  let topicHeadings = ["Mathematics", "Marvel Super Heroes", "Science"]
  let topicDescription = ["Simple Arithmetic","Comic Questions","Things That Dont Make Sense"]
  let topicIcons = ["Math.png","Marvel.png","Science.png"]
  
  
  @IBAction func settingButton(_ sender: UIBarButtonItem) {
    let view = UIAlertController(title: "Settings Pressed", message: "OK", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    view.addAction(defaultAction)
    self.present(view, animated: true, completion: nil)
  }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return topicHeadings.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = UITableViewCell(style: .subtitle, reuseIdentifier: "Row")
    row.imageView?.image = UIImage(named: topicIcons[indexPath.row])
    row.textLabel?.text = topicHeadings[indexPath.row]
    row.detailTextLabel?.text = topicDescription[indexPath.row]
    row.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    
    return row
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.tableFooterView = UIView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

