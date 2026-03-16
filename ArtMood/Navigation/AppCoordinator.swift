//
//  AppCoordiantor.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Fields
    let navigationController: UINavigationController
    
    private var draftAnswers = QuizDraftAnswers()
    
    // MARK: - Lifecycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Naviagtion logic
    func start() {
        showStart()
    }
    
    private func showStart() {
        let viewController = StartViewController()
        
        viewController.onGetStarted = { [weak self] in
            self?.draftAnswers = QuizDraftAnswers()
            self?.showMoodPick()
        }
        
        viewController.onFavouritesTapped = { [weak self] in
            self?.showFavourites()
        }
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func showMoodPick() {
        let viewController = MoodPickViewController()
        
        viewController.onBackTapped = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        viewController.onMoodSelected = { [weak self] mood in
            self?.draftAnswers.mood = mood
            self?.showPalettePick()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showPalettePick() {
        let viewController = PalettePickViewController()
        
        viewController.onPaletteSelected = { [weak self] palette in
            self?.draftAnswers.palette = palette
            self?.showTypePick()
        }
        
        viewController.onBackTapped = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showTypePick() {
        let viewController = TypePickViewController()
        
        viewController.onTypeSelected = { [weak self] type in
            guard let self else { return }
            self.draftAnswers.type = type
            
            guard
                let mood = self.draftAnswers.mood,
                let palette = self.draftAnswers.palette,
                let type = self.draftAnswers.type
            else {
                return
            }
            
            let answers = QuizAnswers(
                mood: mood,
                palette: palette,
                type: type
            )
            
            self.showGallery(with: answers)
        }
        
        viewController.onBackTapped = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showGallery(with answers: QuizAnswers) {
        let viewController = GalleryViewController(answers: answers)
        
        viewController.onBackTapped = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        viewController.onFavouritesTapped = { [weak self] in
            self?.showFavourites()
        }
        
        viewController.onArtworkTapped = { [weak self] artwork in
            self?.showArtworkDetails(with: artwork)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showFavourites() {
        let viewController = FavouritesViewController()
        
        viewController.onBackTapped = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        viewController.onArtworkTapped = { [weak self] artwork in
            self?.showArtworkDetails(with: artwork)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showArtworkDetails(with artwork: Artwork) {
        let viewController = ArtworkDetailsViewController(artwork: artwork)
        
        viewController.onBackTapped = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        viewController.onFavouriteTapped = { artwork in
            print("Favourite tapped for \(artwork.title)")
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
