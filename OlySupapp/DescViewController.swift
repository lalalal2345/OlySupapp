import UIKit

class DescViewController: UIViewController {
    
    let text: String
    
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
        if #available(iOS 15.0, *) {
            self.sheetPresentationController?.detents = [.medium()]
            self.sheetPresentationController?.prefersGrabberVisible = true
            self.sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = false
        }
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.alpha = 0.85
        view.backgroundColor = .darkText
        addObjects()
    }
    
    func addObjects() {
        let scrollViewObject = UIScrollView()
        scrollViewObject.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollViewObject)
        NSLayoutConstraint.activate([
            scrollViewObject.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollViewObject.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollViewObject.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollViewObject.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        let labelObject = UILabel()
        labelObject.translatesAutoresizingMaskIntoConstraints = false
        labelObject.font = UIFont.systemFont(ofSize: 20)
        labelObject.textColor = .white
        labelObject.lineBreakMode = .byWordWrapping
        labelObject.numberOfLines = 0
        labelObject.text = text
        scrollViewObject.addSubview(labelObject)
        NSLayoutConstraint.activate([
            labelObject.topAnchor.constraint(equalTo: scrollViewObject.topAnchor, constant: 25),
            labelObject.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            labelObject.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scrollViewObject.bottomAnchor.constraint(equalTo: labelObject.bottomAnchor)
        ])
    }
}
