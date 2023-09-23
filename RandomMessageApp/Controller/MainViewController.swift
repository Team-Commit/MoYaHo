
import UIKit
import SnapKit
import AVFoundation


//MARK: - Properties
class MainViewController: UIViewController {
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    private let soundEffect = SoundEffect()
    
    private lazy var topLabel: CustomLabel = {
        let label = CustomLabel(style: .mainPageLabel)
        return label
    }()

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
    
    private lazy var mainBottleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "mainBottle"), for: .normal)
        button.addTarget(self, action: #selector(mainBottleButtonTapped), for: .touchUpInside)
        return button
    }()
}



//MARK: - View Cycle

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoBackground()
        soundEffect.playOceanSound()
        setupUI()
    }
}


//MARK: - Setup UI

extension MainViewController {
    
    func setupUI() {
        view.addSubview(myPageButton)
        view.addSubview(bootleCount)
        view.addSubview(mainBottleButton)
        view.addSubview(topLabel)
        setupConstraints()
    }
    
}
//MARK: - Constraints
extension MainViewController {
    func setupConstraints() {
        
        myPageButton.snp.makeConstraints { make in
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
        
        mainBottleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        topLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
    }
}

//MARK: - Button Action
extension MainViewController {
    
    @objc private func mainBottleButtonTapped() {
        DispatchQueue.main.async {
            self.videoPlayerLayer?.opacity =
            self.videoPlayerLayer?.opacity == 1.0 ? 0.3 : 1.0
        }
    }
    
    @objc private func myPageButtonTapped() {
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
        videoPlayerLayer?.frame = view.bounds
        videoPlayerLayer?.videoGravity = .resizeAspectFill
        videoPlayerLayer?.opacity = 1.0
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




