
import UIKit
import SnapKit
import AVFoundation



//MARK: - Properties
class MainViewController: UIViewController {
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    private let soundEffect = SoundEffect()
    
    
    private lazy var bootleCount: UIImageView = {
        let imageView = UIImageView()
        let bottleCountImage = UIImage(named: "bottleCount")
        imageView.image = bottleCountImage
        return imageView
    }()
    
    private lazy var myPageButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(myPageButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "myPageButton"), for: .normal)
        
        
        return button
    }()
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.cornerStyle = .capsule
        let image = UIImage(systemName: "plus.circle")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
            .withTintColor(.blue, renderingMode: .alwaysOriginal) // Set image color to blue
        config.image = image
        button.configuration = config
        button.tintColor = .blue
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        return button
    }()
    
    
    private let writeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemPink
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "pencil")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.configuration = config
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.alpha = 0.0
        button.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainBottleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "mainBottle"), for: .normal)
        return button
    }()
    
    
    
    private var isActive: Bool = false {
        didSet {
            showActionButtons()
        }
    }
    private var animation: UIViewPropertyAnimator?
}



//MARK: - View Cycle

extension MainViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoBackground()
        view.bringSubviewToFront(myPageButton)

        soundEffect.playOceanSound()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupVideoBackground()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPlayerLayer?.frame = view.bounds
        floatingButton.frame = CGRect(x: view.frame.size.width - 60 - 8 - 20, y: view.frame.size.height - 60 - 8 - 40, width: 60, height: 60)
        writeButton.frame = CGRect(x: view.frame.size.width - 60 - 8 - 20, y: view.frame.size.height - 60 - 80 - 8 - 40, width: 60, height: 60)
        //        stopMusicButton.frame = CGRect(x: view.frame.size.width - 60 - 8 - 20, y: view.frame.size.height - 60 - 160 - 8 - 40, width: 60, height: 60)
    }
}


//MARK: - Setup UI

extension MainViewController {
    
    func setupUI() {
        view.addSubview(floatingButton)
        view.addSubview(writeButton)
        //        view.addSubview(stopMusicButton)
        view.addSubview(myPageButton)
        view.addSubview(bootleCount)
        
        setupConstraints()
        
    }
    
}
//MARK: - Constraints
extension MainViewController {
    func setupConstraints() {
        
        myPageButton.snp.makeConstraints { make in
            //            make.top.
        }
        
        bootleCount.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(50)
        }
        
        myPageButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.center.equalToSuperview()
        }
    }
}

//MARK: - Button Action
extension MainViewController {
    
    @objc private func didTapFloatingButton() {
        isActive.toggle()
    }
    
    @objc private func writeButtonTapped() {
        let sendMessageVC = SendMessageViewController()
        self.navigationController?.pushViewController(sendMessageVC, animated: true)
    }
    
    @objc private func mainBottleButtonTapped() {
    }
    
    
    @objc private func myPageButtonTapped() {
        let myPageVC = MyPageViewController()
        print("myPageButonTapped!")
        self.navigationController?.pushViewController(myPageVC, animated: true)
    }
    
    private func showActionButtons() {
        popButtons()
        rotateFloatingButton()
    }
    
    private func popButtons() {
        if isActive {
            writeButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.writeButton.layer.transform = CATransform3DIdentity
                self.writeButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                self.writeButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                self.writeButton.alpha = 0.0
            }
        }
    }
    
    private func rotateFloatingButton() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let fromValue = isActive ? 0 : CGFloat.pi / 4
        let toValue = isActive ? CGFloat.pi / 4 : 0
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        floatingButton.layer.add(animation, forKey: nil)
    }
    
}


//MARK: - Background Player
extension MainViewController {
    func setupVideoBackground() {
        guard let path = Bundle.main.path(forResource: "mainBackground", ofType: "mp4") else {
            debugPrint("Video not found")
            return
        }
        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayerLayer?.frame = view.frame
        //MARK: - 비디오 그래비티 나중에 다시와서 해결하기
        videoPlayerLayer?.videoGravity = .resizeAspectFill
        videoPlayer?.isMuted = true
        videoPlayer?.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loopVideo), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
    }
    
    @objc func loopVideo() {
        videoPlayer?.seek(to: CMTime.zero)
        videoPlayer?.play()
    }
    
}

//MARK: - Background Music
extension MainViewController {
    
    
}





