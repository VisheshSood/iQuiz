//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Vishesh Sood on 5/8/17.
//  Copyright © 2017 Vishesh Sood. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
  
  @IBOutlet weak var firstButton: UIButton!
  @IBOutlet weak var secondButton: UIButton!
  @IBOutlet weak var thirdButton: UIButton!
  @IBOutlet weak var fourthButton: UIButton!
  
  public static var arrayOfButton : [UIButton] = []
  
  public static var clickedButton:String? = nil
  
  @IBAction func answerOptions(_ sender: UIButton) {
    let title = sender.title(for: .normal)
    
    for i in QuestionViewController.arrayOfButton {
      if i.title(for: .normal) == title {
        i.backgroundColor = UIColor.orange
        QuestionViewController.clickedButton = i.title(for: .normal)
      }else{
        i.backgroundColor = UIColor.white
      }
    }
    
  }
  
  
  public static var QuestionCount = 0
  public static var CurrentQuestion = 0
  
  public static var fetchedQuizOnQuestionViewController = [Quiz]()
  
  var questionsReceived = [Questions]()
  
  @IBAction func submitButton(_ sender: UIButton) {
    
    if QuestionViewController.clickedButton != nil {
      AnswerViewController.fetchedQuestionsOnAnswerViewController = questionsReceived
      QuestionViewController.CurrentQuestion = QuestionViewController.CurrentQuestion - 1
      AnswerViewController.quizQuestion = questionsReceived
      let viewController = storyboard?.instantiateViewController(withIdentifier: "answer")
      self.navigationController?.pushViewController(viewController!, animated: true)
    } else {
      let warningAlert = UIAlertController(title: "Warning", message: "You must choose an answer!", preferredStyle: UIAlertControllerStyle.alert)
      warningAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
      
      present(warningAlert, animated: true, completion: nil)
    }
    
  }
  @IBOutlet weak var label: UILabel!
  public static var cellName:String = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.hidesBackButton = true
    QuestionViewController.arrayOfButton = []
    for subject in QuestionViewController.fetchedQuizOnQuestionViewController{
      if (subject.Title == QuestionViewController.cellName){
        let questions: [Dictionary<String, Any>] = subject.Questions
        for questionsItems in questions{
          let text = questionsItems["text"] as! String
          let answers : [String] = questionsItems["answers"] as! Array
          let answer = questionsItems["answer"] as! String
          self.questionsReceived.append(Questions(Question: text, Answer: answer, AnswersList: answers))
        }
      }
    }
    QuestionViewController.arrayOfButton.append(firstButton)
    QuestionViewController.arrayOfButton.append(secondButton)
    QuestionViewController.arrayOfButton.append(thirdButton)
    QuestionViewController.arrayOfButton.append(fourthButton)
    label.text = questionsReceived[QuestionViewController.QuestionCount - QuestionViewController.CurrentQuestion].Question
    for i in 0...questionsReceived[QuestionViewController.QuestionCount - QuestionViewController.CurrentQuestion].AnswersList.count - 1{
      QuestionViewController.arrayOfButton[i].setTitle(questionsReceived[QuestionViewController.QuestionCount - QuestionViewController.CurrentQuestion].AnswersList[i], for: .normal)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
}

//Questions Class
class Questions {
  var Question : String
  var Answer : String
  var AnswersList : [String]
  
  //var question
  init(Question : String, Answer : String, AnswersList : [String]) {
    self.Question = Question
    self.Answer = Answer
    self.AnswersList = AnswersList
  }
  
}
