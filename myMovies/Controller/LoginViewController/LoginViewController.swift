//
//  LoginViewController.swift
//  myMovies
//
//  Created by Raman Kozar on 30/08/2023.
//

import UIKit
import LIHAlert
import SwiftMessages

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginSelector: UISegmentedControl!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var inputLabelAPIKey: UITextField!
    
    var processingAlert: LIHAlert?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()

    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let key = inputLabelAPIKey.text else {
            return
        }
        
        if key.isEmpty {
            return
        }
        
        TMDB_API().validateAPIKey(apiKey: key) { status in
            
            if status != 200 {
                
                self.errorLabel.text = "Your credentials are incorrect"
                self.errorLabel.textColor = .red
                
                self.showAlertLogging(isSuccess: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.errorLabel.text = " "
                    self.inputLabelAPIKey.text = " "
                }
                
            } else {
                
                self.processingAlert?.show(nil, hidden: nil)
                
                self.errorLabel.textColor = .green
                self.errorLabel.text = "Your credentials are correct"
                
                CoreDataMethods().saveAPI_KeyIntoCoreData(key)
                
                let operationQueue = OperationQueue()
                
                let oneOperation = BlockOperation {
                    TMDB_API().dataRequest(requestType: APIRequestParameters.latest, apiKey: key)
                }

                let twoOperation = BlockOperation {
                    TMDB_API().dataRequest(requestType: APIRequestParameters.popular, apiKey: key)
                }

                let threeOperation = BlockOperation {
                    TMDB_API().dataRequest(requestType: APIRequestParameters.nowPlaying, apiKey: key)
                }

                let fourOperation = BlockOperation {
                    TMDB_API().dataRequest(requestType: APIRequestParameters.topRated, apiKey: key)
                }
                
                let fiveOperation = BlockOperation {
                    TMDB_API().dataRequest(requestType: APIRequestParameters.upcoming, apiKey: key)
                }
                
                twoOperation.addDependency(oneOperation)
                threeOperation.addDependency(twoOperation)
                fourOperation.addDependency(threeOperation)
                fiveOperation.addDependency(fourOperation)
                
                operationQueue.addOperations([
                    oneOperation,
                    twoOperation,
                    threeOperation,
                    fourOperation,
                    fiveOperation
                ], waitUntilFinished: false)
                
                operationQueue.addBarrierBlock {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        
                        self.processingAlert?.hideAlert({ () -> () in
                            
                            self.showAlertLogging(isSuccess: true)
                            
                            let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewControllerID")
                            homeController.modalTransitionStyle = .crossDissolve
                            homeController.modalPresentationStyle = .fullScreen
                            
                            self.navigationController?.pushViewController(homeController, animated: false)
                            
                        })
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func showAlertLogging(isSuccess: Bool) {
    
        if isSuccess {
            
            let success = MessageView.viewFromNib(layout: .cardView)
            success.configureTheme(.success)
            success.configureDropShadow()
            success.configureContent(title: "Success", body: "You have successfully logged in!")
            success.button?.isHidden = true
            
            var successConfig = SwiftMessages.defaultConfig
            successConfig.presentationStyle = .top
            successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
            
            SwiftMessages.show(config: successConfig, view: success)
            
        } else {
        
            let error = MessageView.viewFromNib(layout: .tabView)
            error.configureTheme(.error)
            error.configureContent(title: "Error", body: "Login attempt failed!")
            error.button?.isHidden = true
            
            SwiftMessages.show(view: error)
            
        }
        
    }
    
    @IBAction func changedValueSelector(_ sender: Any) {
        
        if loginSelector.selectedSegmentIndex == 1 {
            
            let refreshAlert = UIAlertController(title: "Exit application", message: "Are you sure that you want to exit?", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        exit(0)
                    }
                    
                }
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                self.loginSelector.selectedSegmentIndex = 0
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
    }
    
    func setupView() {
        
        self.errorLabel.text = " "
    
        self.processingAlert = LIHAlertManager.getProcessingAlert(message: "Signing in...")
        self.processingAlert?.touchBackgroundToDismiss = false
        self.processingAlert?.dimsBackground = false
        self.processingAlert?.initAlert(self.view)
        
    }
    
}
