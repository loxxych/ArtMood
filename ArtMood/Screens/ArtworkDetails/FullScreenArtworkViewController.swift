//
//  FullScreenArtworkViewController.swift
//  ArtMood
//
//  Created by loxxy on 17.03.2026.
//

import UIKit

final class FullScreenArtworkViewController: UIViewController {
    // MARK: - Constants
    private enum Const {
        static let fatalError: String = "init(coder:) has not been implemented"
        
        static let closeButtonSize: CGFloat = 36
        static let closeButtonTop: CGFloat = 12
        static let closeButtonRight: CGFloat = 16
        
        static let imageHorizontalInset: CGFloat = 16
        
        static let minimumZoomScale: CGFloat = 1
        static let maximumZoomScale: CGFloat = 4
        static let doubleTapZoomScale: CGFloat = 2.5
        
        static let bgColor: UIColor = .black
        static let tintColor: UIColor = .white
        
        static let closeImage: UIImage = UIImage(systemName: "xmark") ?? UIImage()
    }
    
    // MARK: - Fields
    private let closeButton: UIButton = UIButton(type: .system)
    private let scrollView: UIScrollView = UIScrollView()
    private let artworkImageView: UIImageView = UIImageView()
    
    private let artwork: Artwork
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    init(artwork: Artwork) {
        self.artwork = artwork
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerImageIfNeeded()
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        view.backgroundColor = Const.bgColor
        
        configureScrollView()
        configureArtworkImageView()
        configureCloseButton()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = Const.minimumZoomScale
        scrollView.maximumZoomScale = Const.maximumZoomScale
        scrollView.zoomScale = Const.minimumZoomScale
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bouncesZoom = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureArtworkImageView() {
        scrollView.addSubview(artworkImageView)
        
        artworkImageView.image = UIImage(named: artwork.imageName)
        artworkImageView.contentMode = .scaleAspectFit
        artworkImageView.isUserInteractionEnabled = true
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            artworkImageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: Const.imageHorizontalInset),
            artworkImageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -Const.imageHorizontalInset),
            artworkImageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            artworkImageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            artworkImageView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -(Const.imageHorizontalInset * 2)),
            artworkImageView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }
    
    private func configureCloseButton() {
        view.addSubview(closeButton)
        
        closeButton.tintColor = Const.tintColor
        closeButton.setImage(Const.closeImage.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: Const.closeButtonSize),
            closeButton.heightAnchor.constraint(equalToConstant: Const.closeButtonSize),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.closeButtonTop),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.closeButtonRight)
        ])
    }
    
    private func configureGestures() {
        let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleDoubleTap(_:))
        )
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
    }
    
    // MARK: - Helpers
    private func centerImageIfNeeded() {
        let scrollSize: CGSize = scrollView.bounds.size
        let contentSize: CGSize = scrollView.contentSize
        
        let verticalInset: CGFloat = max(0, (scrollSize.height - contentSize.height) / 2)
        let horizontalInset: CGFloat = max(0, (scrollSize.width - contentSize.width) / 2)
        
        scrollView.contentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        )
    }
    
    private func zoomRect(for scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect: CGRect = .zero
        
        zoomRect.size.width = scrollView.bounds.width / scale
        zoomRect.size.height = scrollView.bounds.height / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        
        return zoomRect
    }
    
    // MARK: - Actions
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        if scrollView.zoomScale > Const.minimumZoomScale {
            scrollView.setZoomScale(Const.minimumZoomScale, animated: true)
        } else {
            let tapPoint: CGPoint = gesture.location(in: artworkImageView)
            let zoomRectangle: CGRect = zoomRect(for: Const.doubleTapZoomScale, center: tapPoint)
            scrollView.zoom(to: zoomRectangle, animated: true)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension FullScreenArtworkViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        artworkImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImageIfNeeded()
    }
}
