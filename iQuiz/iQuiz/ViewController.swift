//
//  ViewController.swift
//  iQuiz
//
//  Created by Vishesh Sood on 5/1/17.
//  Copyright © 2017 Vishesh Sood. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  var currentQuiz = [Quiz]()
  
  
  let topicIcons = ["Math.png","Marvel.png","Science.png"]
  let topicHeadings = ["Mathematics", "Marvel Super Heroes", "Science!"]
  let topicDescription = ["Simple Arithmetic","Comic Questions","Things That Dont Make Sense"]
  
  @IBAction func settingButton(_ sender: UIBarButtonItem) {
    let view = UIAlertController(title: "Settings Pressed", message: "OK", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    view.addAction(defaultAction)
    self.present(view, animated: true, completion: nil)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getJsonFile()
    tableView.tableFooterView = UIView()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentQuiz.count
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
    let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
    QuestionViewController.cellName = (cell.textLabel?.text!)!
    QuestionViewController.fetchedQuizOnQuestionViewController = currentQuiz
    for i in 0...currentQuiz.count-1 {
      if currentQuiz[i].Title == cell.textLabel?.text{
        QuestionViewController.QuestionCount = currentQuiz[i].Questions.count
        QuestionViewController.CurrentQuestion = currentQuiz[i].Questions.count
      }
    }
    let viewController = storyboard?.instantiateViewController(withIdentifier: "question")
    self.navigationController?.pushViewController(viewController!, animated: true)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getJsonFile() {
    let url = URL(string: "https://tednewardsandbox.site44.com/questions.json")
    let sessionConfiq = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfiq)
    
    DispatchQueue.global().async {
      let task = session.dataTask(with: url!) {(data, response, err) in
        if err != nil
        {
          print ("ERROR")
        }else{
          if let content = data{
            do{
              let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
              for eachQuizFromData in myJson {
                let eachQuiz = eachQuizFromData as! [String : Any]
                let title = eachQuiz["title"] as! String
                let desc = eachQuiz["desc"] as! String
                let questions : [Dictionary<String,Any>] = eachQuiz["questions"] as! Array
                self.currentQuiz.append(Quiz(title: title, desc: desc, questions: questions))
              }
              self.tableView.reloadData()
            
            }
            catch{
              
            }
          }
        }
        
      }
      
      task.resume()
      DispatchQueue.main.async {
        //self.jsonArray = myJson
      }
      
    }
    
  }
  
  
}

// Quiz class to make it easier to obtain quiz information
class Quiz {
  var Title : String
  var Description : String
  var Questions : [Dictionary<String, Any>]
  
  
  init(title : String, desc : String, questions : [Dictionary<String, Any>]) {
    self.Title = title
    self.Description = desc
    self.Questions = questions
  }
}

