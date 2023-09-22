



import UIKit
import SnapKit



class MyPageViewController: UIViewController {
    
    private lazy var backGroundImaege: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        
        
        return imageView
    }()
    
}




//MARK: - View Cycle
extension MyPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupUI()
        
        
    }
}



//MARK: - Setup UI
extension MyPageViewController {
    
    
    func setupUI() {
        
        setConstraints()
    }
    
    func setConstraints() {
        
    }
    
}
