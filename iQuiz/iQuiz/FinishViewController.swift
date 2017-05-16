//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Vishesh Sood on 5/8/17.
//  Copyright © 2017 Vishesh Sood. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
  
  public static var wrongQuestions = 0
  
  @IBOutlet weak var label: UILabel!
  
  @IBAction func finishButton(_ sender: UIButton) {
    FinishViewController.wrongQuestions = 0
    self.navigationController?.popToRootViewController(animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.hidesBackButton = true
    label.text = "You answered \(QuestionViewController.QuestionCount - FinishViewController.wrongQuestions) of \(QuestionViewController.QuestionCount) questions correctly"
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
