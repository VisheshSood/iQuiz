//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Vishesh Sood on 5/8/17.
//  Copyright © 2017 Vishesh Sood. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
  
  public static var quizQuestion = [Questions]()
  
  @IBOutlet weak var firstButton: UIButton!
  @IBOutlet weak var secondButton: UIButton!
  @IBOutlet weak var thirdButton: UIButton!
  @IBOutlet weak var fourthButton: UIButton!
  
  @IBOutlet weak var label: UILabel!
  
  var AnswerButtons : [UIButton] = []
  
  public static var fetchedQuestionsOnAnswerViewController = [Questions]()
  @IBAction func nextButton(_ sender: UIButton) {
    if QuestionViewController.CurrentQuestion == 0 {
      QuestionViewController.clickedButton = nil
      let viewController = storyboard?.instantiateViewController(withIdentifier: "finish")
      self.navigationController?.pushViewController(viewController!, animated: true)
    } else {
      QuestionViewController.clickedButton = nil
      let viewController = storyboard?.instantiateViewController(withIdentifier: "question")
      self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.hidesBackButton = true
    
    AnswerButtons = []
    AnswerButtons.append(firstButton)
    AnswerButtons.append(secondButton)
    AnswerButtons.append(thirdButton)
    AnswerButtons.append(fourthButton)
    
    
    let answerValue = Int (AnswerViewController.quizQuestion[QuestionViewController.QuestionCount - (QuestionViewController.CurrentQuestion + 1)].Answer)
    
    var answerRawText = ""
    
    label.text = AnswerViewController.quizQuestion[QuestionViewController.QuestionCount - (QuestionViewController.CurrentQuestion + 1)].Question
    
    answerRawText = AnswerViewController.quizQuestion[QuestionViewController.QuestionCount - (QuestionViewController.CurrentQuestion + 1)].AnswersList[answerValue! - 1]
    
    for i in 0...QuestionViewController.arrayOfButton.count - 1{
      AnswerButtons[i].setTitle(QuestionViewController.arrayOfButton[i].title(for: .normal), for: .normal)
      if AnswerButtons[i].title(for: .normal) == answerRawText{
        AnswerButtons[i].backgroundColor = UIColor.green
      }
    }
    
    if QuestionViewController.clickedButton != answerRawText{
      FinishViewController.wrongQuestions = FinishViewController.wrongQuestions + 1
      for i in 0...QuestionViewController.arrayOfButton.count - 1{
        if AnswerButtons[i].title(for: .normal) == QuestionViewController.clickedButton{
          AnswerButtons[i].backgroundColor = UIColor.red
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
