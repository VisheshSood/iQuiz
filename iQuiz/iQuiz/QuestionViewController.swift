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
    
    for i in QuestionViewController.arrayOfButton{
      if i.title(for: .normal) == title{
        i.backgroundColor = UIColor.gray
        QuestionViewController.clickedButton = i.title(for: .normal)
      }else{
        i.backgroundColor = UIColor.cyan
      }
    }
    
  }
  
  public static var numberOfQuestion = 0
  public static var currentNumberOfQuestion = 0
  
  public static var fetchedQuizOnQuestionViewController = [Quiz]()
  var fetchedQuestions = [Questions]()
  
  @IBAction func submitButton(_ sender: UIButton) {
    
    if QuestionViewController.clickedButton != nil{
      AnswerViewController.fetchedQuestionsOnAnswerViewController = fetchedQuestions
      QuestionViewController.currentNumberOfQuestion = QuestionViewController.currentNumberOfQuestion - 1
      AnswerViewController.quizQuestion = fetchedQuestions
      let viewController = storyboard?.instantiateViewController(withIdentifier: "answer")
      self.navigationController?.pushViewController(viewController!, animated: true)
    }else{
      let warningAlert = UIAlertController(title: "Warning", message: "Please select an answer", preferredStyle: UIAlertControllerStyle.alert)
      warningAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
      
      present(warningAlert, animated: true, completion: nil)
    }
    
    //        AnswerViewController.fetchedQuestionsOnAnswerViewController = fetchedQuestions
    //        QuestionViewController.currentNumberOfQuestion = QuestionViewController.currentNumberOfQuestion - 1
    //        AnswerViewController.quizQuestion = fetchedQuestions
    //        let viewController = storyboard?.instantiateViewController(withIdentifier: "answer")
    //        self.navigationController?.pushViewController(viewController!, animated: true)
    
  }
  @IBOutlet weak var label: UILabel!
  public static var cellName:String = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.hidesBackButton = true
    //label.text = QuestionViewController.cellName
    QuestionViewController.arrayOfButton = []
    for subject in QuestionViewController.fetchedQuizOnQuestionViewController{
      if (subject.Title == QuestionViewController.cellName){
        let questions: [Dictionary<String, Any>] = subject.Questions
        for questionsItems in questions{
          let text = questionsItems["text"] as! String
          let answers : [String] = questionsItems["answers"] as! Array
          let answer = questionsItems["answer"] as! String
          self.fetchedQuestions.append(Questions(text: text, answer: answer, answers: answers))
        }
      }
    }
    QuestionViewController.arrayOfButton.append(firstButton)
    QuestionViewController.arrayOfButton.append(secondButton)
    QuestionViewController.arrayOfButton.append(thirdButton)
    QuestionViewController.arrayOfButton.append(fourthButton)
    label.text = fetchedQuestions[QuestionViewController.numberOfQuestion - QuestionViewController.currentNumberOfQuestion].Text
    //print(fetchedQuestions[QuestionViewController.numberOfQuestion - QuestionViewController.currentNumberOfQuestion].answers)
    for i in 0...fetchedQuestions[QuestionViewController.numberOfQuestion - QuestionViewController.currentNumberOfQuestion].AnswersList.count - 1{
      QuestionViewController.arrayOfButton[i].setTitle(fetchedQuestions[QuestionViewController.numberOfQuestion - QuestionViewController.currentNumberOfQuestion].AnswersList[i], for: .normal)
      //print(QuestionViewController.arrayOfButton[i].title(for: .normal)!)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
}

//Questions Class
class Questions {
  var Text : String
  var Answer : String
  var AnswersList : [String]
  
  //var question
  init(text : String, answer : String, answers : [String]) {
    self.Text = text
    self.Answer = answer
    self.AnswersList = answers
  }

}
