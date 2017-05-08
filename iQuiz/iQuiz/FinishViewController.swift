//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Vishesh Sood on 5/8/17.
//  Copyright © 2017 Vishesh Sood. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
  public static var numberOfMissedQuestions = 0
  
  @IBOutlet weak var label: UILabel!
  
  @IBAction func finishButton(_ sender: UIButton) {
    FinishViewController.numberOfMissedQuestions = 0
    let warningAlert = UIAlertController(title: "Warning", message: "Are you sure you want to return to home page", preferredStyle: UIAlertControllerStyle.alert)
    
    warningAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
      QuestionViewController.arrayOfButton = []
      QuestionViewController.numberOfQuestion = 0
      QuestionViewController.currentNumberOfQuestion = 0
      QuestionViewController.fetchedQuizOnQuestionViewController = []
      AnswerViewController.quizQuestion = []
      AnswerViewController.fetchedQuestionsOnAnswerViewController = []
      self.navigationController?.popToRootViewController(animated: false)
    }))
    
    warningAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler:nil))
    
    present(warningAlert, animated: true, completion: nil)
    //self.navigationController?.popToRootViewController(animated: false)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    label.text = "You answered \(QuestionViewController.numberOfQuestion - FinishViewController.numberOfMissedQuestions) of \(QuestionViewController.numberOfQuestion) question correctly"
    self.navigationItem.hidesBackButton = true
    // Do any additional setup after loading the view.
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
