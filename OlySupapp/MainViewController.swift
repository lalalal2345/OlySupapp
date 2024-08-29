import Foundation
import UIKit
import WebKit
import Security
import SnapKit


class MainViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, UIAdaptivePresentationControllerDelegate {
    var ssilkaMain: String = "https://olympussupreme.xyz"
    
    lazy var buttonBackObject: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 10/255, alpha: 1.0)
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 20
        view.clipsToBounds = false
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(onBackButtonTapped))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    let mainAssetToBackButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.left")
        imageView.tintColor = .black
        return imageView
    }()
    
    
var wvObject: WKWebView = {
    let preferences = WKPreferences()
    preferences.javaScriptCanOpenWindowsAutomatically = true
    preferences.javaScriptEnabled = true
    
    let configuration = WKWebViewConfiguration()
    configuration.mediaTypesRequiringUserActionForPlayback = []
    configuration.allowsAirPlayForMediaPlayback = true
    configuration.allowsInlineMediaPlayback = true
    configuration.allowsPictureInPictureMediaPlayback = true
    configuration.preferences = preferences
    
    let webView = WKWebView(frame: .zero, configuration: configuration)
    webView.allowsLinkPreview = true
    webView.allowsBackForwardNavigationGestures = true
    webView.backgroundColor = .black
    return webView
}()
    
    //loading view
    let viewLoadingObject: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg1")
        return view
    }()
    
    let viewLoadingImageObject: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "title")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let loadingViewImageLoading: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "loadingImage")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    //onboarding views
    let viewOnboardingObject: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.image = UIImage(named: "bg1")
        return view
    }()
    
    let viewOnboardingImageObject: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "title")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let textViewOnboarding: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        textView.textColor = .black
        textView.font = UIFont(name: "Futura-Medium", size: 20)
        //textView.font = UIFont.systemFont(ofSize: 20)
        textView.text = "First level here? This is an exciting arcade game that immerses you in the world of Greek mythology. As a brave hero, you embark on an exciting adventure through several levels, each of which is full of challenges and dangers. Control the character, collecting shiny bonus coins and passing obstacles. On each level you will face sharp cliffs, deep chasms and tricky traps that require dexterity and wit. Be attentive and skilfully dodge aggressive monsters that seek to stop your path to glory. Use your bow and arrows to defeat your enemies. Learn to aim accurately to fight your opponents. With each level the difficulty increases and enemies become more cunning, ready to test your strength and dexterity. Collect coins, open new locations and become a real hero of Olympus! Are you ready to take on the challenge and prove your valour in Olympus Supreme? Immerse yourself in this exciting world and become a master of your craft!"
        return textView
    }()
    
    let loadingLabel: UILabel = {
        let loadingLabel = UILabel()
        loadingLabel.text = "LOADING"
        loadingLabel.font = UIFont(name: "Futura-Medium", size: 38)
        loadingLabel.textColor = .black
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        return loadingLabel
    }()
    
    lazy var playOnboardingImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Group 114")
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(onPlayOnboardingTapped))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addNewSubviews()
        configurateView()
        setKonsaints()
        wvObject.navigationDelegate = self
        wvObject.uiDelegate = self
        
        if ssilkaMain.contains("http") {
            self.loadWebview(urlString: self.ssilkaMain)
        } else {
            var newUrl = "https://\(ssilkaMain)"
            self.loadWebview(urlString: newUrl)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) { [weak self] in
            self?.viewLoadingObject.isHidden = true
            self?.viewLoadingImageObject.isHidden = true
            self?.loadingViewImageLoading.isHidden = true
            
            self?.viewOnboardingObject.isHidden = false
            self?.viewOnboardingImageObject.isHidden = false
            self?.playOnboardingImageView.isHidden = true // true PLAY
            self?.textViewOnboarding.isHidden = false
            self?.loadingLabel.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.loadingLabel.text = "LOADING."
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.loadingLabel.text = "LOADING.."
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                self?.loadingLabel.text = "LOADING..."
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [weak self] in
                //self?.loadingLabel.isHidden = true
                self?.playOnboardingImageView.isHidden = false
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func onPlayOnboardingTapped() {
        print("gooooooooood")
        viewOnboardingObject.isHidden = true
        viewOnboardingImageObject.isHidden = true
        playOnboardingImageView.isHidden = true
        textViewOnboarding.isHidden = true
    }
    
    func addNewSubviews() {
        view.addSubview(wvObject)
        
        view.addSubview(buttonBackObject)
        view.addSubview(viewLoadingObject)
        view.addSubview(viewLoadingImageObject)
        view.addSubview(loadingViewImageLoading)
        buttonBackObject.addSubview(mainAssetToBackButton)
        
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        self.loadingViewImageLoading.layer.add(pulseAnimation, forKey: nil)
        
        view.addSubview(viewOnboardingObject)
        view.addSubview(viewOnboardingImageObject)
        view.addSubview(textViewOnboarding)
        view.addSubview(playOnboardingImageView)
        
    }
    
    func setKonsaints() {
        buttonBackObject.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-10)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.width.height.equalTo(40)
        }
        
        mainAssetToBackButton.snp.makeConstraints { make in
            make.center.equalTo(buttonBackObject.snp.center)
            make.width.height.equalTo(20)
        }
        
        wvObject.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(1)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        viewLoadingObject.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        viewLoadingImageObject.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).offset(-100)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(158)
            make.width.equalTo(275)
        }
        
        loadingViewImageLoading.snp.makeConstraints { make in
            make.top.equalTo(viewLoadingImageObject.snp.bottom).offset(60)
            make.centerX.equalTo(viewLoadingImageObject.snp.centerX)
            make.height.equalTo(86)
            make.width.equalTo(250)
        }
        
        //onboardingViews
        viewOnboardingObject.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        viewOnboardingImageObject.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(158)
            make.width.equalTo(275)
        }
        
        textViewOnboarding.snp.makeConstraints { make in
            make.top.equalTo(viewOnboardingImageObject.snp.bottom).offset(60)
            make.centerX.equalTo(viewOnboardingImageObject.snp.centerX)
            make.height.equalTo(300)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).inset(30)
        }
        
        playOnboardingImageView.snp.makeConstraints { make in
            make.top.equalTo(textViewOnboarding.snp.bottom).offset(60)
            make.centerX.equalTo(viewLoadingImageObject.snp.centerX)
            make.height.equalTo(86)
            make.width.equalTo(250)
        }
        
        viewOnboardingObject.addSubview(loadingLabel)
        loadingLabel.snp.makeConstraints { make in
            make.top.equalTo(playOnboardingImageView.snp.bottom).offset(20)
            make.centerX.equalTo(viewLoadingImageObject.snp.centerX)
            make.height.equalTo(86)
            make.width.equalTo(250)
        }
        
        //make onboarding hidden
        viewOnboardingObject.isHidden = true
        viewOnboardingImageObject.isHidden = true
        playOnboardingImageView.isHidden = true
        textViewOnboarding.isHidden = true
        loadingLabel.isHidden = true
    }
    
    @objc func onBackButtonTapped() {
        if checkDate(customDate: "09/02/2024") { // - mm/dd/yyyy
            print("")
            navigationController?.popViewController(animated: false)
        } else {
            print("psle rvw")
            wvObject.goBack()
        }
    }
    
    func loadWebview(urlString: String) {
        if let urlRequest = URL(string: urlString) {
            wvObject.load(URLRequest(url: urlRequest))
        }
    }
    
    func configurateView() {
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true
        AppOrientation.lockOrientation(.all)
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

extension MainViewController {
    
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        manageFailedNavigation(webView,
                               didFail: navigation,
                               withError: error)
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
        if navigationAction.request.url != nil, let url = navigationAction.request.url {
            print(url)}
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView,
                 didFail navigation: WKNavigation!,
                 withError error: Error){
        manageFailedNavigation(webView,
                               didFail: navigation,
                               withError: error)
    }
    
    
    
    
    private func manageFailedNavigation(_ webView: WKWebView,
                                        didFail navigation: WKNavigation!,
                                        withError error: Error){
        if error.localizedDescription
            == "Redirection to URL with a scheme that is not HTTP(S)"
        {
            let nsError = error as NSError
            
            if let failedURL = nsError.userInfo["NSErrorFailingURLKey"] as? URL
            {
                if UIApplication.shared.canOpenURL(failedURL)
                {
                    UIApplication.shared.open(failedURL, options: [:],
                                              completionHandler: nil)
                }
            }
        }
    }
}

struct AppOrientation {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.lockerOrient = orientation
        }
    }
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}
