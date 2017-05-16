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
    let view = UIAlertController(title: "Additional Settings", message: "Try my quiz at http://www.visheshsood.com/vishesh.json !", preferredStyle: .alert)
    view.addTextField { (urlInput) in
      urlInput.placeholder = "Insert URL"
    }
    
    let defaultAction = UIAlertAction(title: "Update Quiz", style: .default, handler: { alert -> Void in
      let urlText : String = view.textFields![0].text!
      print(urlText)
      self.currentQuiz = []
      if urlText != ""{
        self.downloadJSON(URLString: urlText)
      }
    })
    
    
    view.addAction(defaultAction)
    self.present(view, animated: true, completion: nil)
  }

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    DispatchQueue.global().async {
      self.downloadJSON()
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    tableView.tableFooterView = UIView()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentQuiz.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
    cell.imageView?.image = UIImage(named: "Questions.png")
    cell.textLabel?.text = currentQuiz[indexPath.row].Title
    cell.detailTextLabel?.text = currentQuiz[indexPath.row].Description
    cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    
    return cell
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
  
  func downloadJSON(URLString: String = "http://tednewardsandbox.site44.com/questions.json") {
    var submittedURL = URL(string: URLString)
    let sessionConfiguration = URLSessionConfiguration.default
    let currentSession = URLSession(configuration: sessionConfiguration)
    if submittedURL == nil{
      submittedURL = URL(string: "invalid URL")
    }
    let task = currentSession.dataTask(with: submittedURL!) {(data, response, err) in
      if err != nil
      {
        let downloadedJsonFile = UserDefaults.standard
        if (downloadedJsonFile.value(forKey: "localJsonFile") != nil){
          let file = downloadedJsonFile.value(forKey: "localJsonFile") as! NSArray
          for quiz in file {
            let currentQuiz = quiz as! [String : Any]
            let title = currentQuiz["title"] as! String
            let desc = currentQuiz["desc"] as! String
            let questions : [Dictionary<String,Any>] = currentQuiz["questions"] as! Array
            self.currentQuiz.append(Quiz(title: title, desc: desc, questions: questions))
          }
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
        }
      } else {
        if let content = data {
          do {
            let tempJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            let downloadedJSON = UserDefaults.standard
            downloadedJSON.set(tempJSON, forKey: "localJsonFile")
            downloadedJSON.synchronize()
            for quiz in tempJSON {
              let current = quiz as! [String : Any]
              let title = current["title"] as! String
              let desc = current["desc"] as! String
              let questions : [Dictionary<String,Any>] = current["questions"] as! Array
              self.currentQuiz.append(Quiz(title: title, desc: desc, questions: questions))
            }
            DispatchQueue.main.async {
              self.tableView.reloadData()
            }
          }
          catch{
          }
        }
      }
    }
    task.resume()
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

