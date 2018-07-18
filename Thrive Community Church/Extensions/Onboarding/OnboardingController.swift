//
//  OnboardingController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 7/15/18.
//  Copyright © 2018 Thrive Community Church. All rights reserved.
//

import UIKit

// Make your life easier by declaring an OO extension to UIColor for things that are used often
extension UIColor {
	static var mainBlue = UIColor(red: 46/255, green: 190/255, blue: 216/255, alpha: 1)
	static var bgBlue = UIColor(red: 46/255, green: 190/255, blue: 216/255, alpha: 0.35)
	static var lessLightLightGray = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
	static var bgGreen = UIColor(red: 196/255, green: 214/255, blue: 118/255, alpha: 1)
	static var lighterBlueGray = UIColor(red: 70/255, green: 106/255, blue: 134/255, alpha: 1)
}

// CONTROLLER
// controls the each cell and how they are controlled
class OnboardingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	let onboardingKey = "onboarding"
	var onboardingString = String()
	
	// don't just use Arrays - they crash easily if there are too few or many cells vs count
	let pages = [
		Page(imageName: "listen_img",
			 headerText: "Take us with you on the go!",
			 bodyText: "Whether you're traveling or under the weather, you'll never miss a sermon series with our automatic weekly updates. Listen to sermons in the car, at work or in the gym. You can even stream your favorite messages in Full HD!"),
		Page(imageName: "notes_img",
			 headerText: "Your Notes. Your Device.",
			 bodyText: "Taking notes during the message has never been easier. Our note taker supports a full Emoji keyboard, for creating notes with beautiful bullited lists. Notes are saved locally on your device, and sending your notes to friends or sharing them online is only one tap away."),
		Page(imageName: "bible_img",
			 headerText: "Read The Entire Bible!",
			 bodyText: "With the power of YouVersion™️ and bible.com, the entire English Standard Version (ESV) of the bible is available at your fingertips. Take your bible with you, wherever you go."),
		Page(imageName: "final_img",
			 headerText: "Ready To Get Started?",
			 bodyText: "Tap DONE below to dive in and experience Thrive Community Church")
	]
	
	// Add previous button - private so that no other .swift classes can access this
	private let previousButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
		button.setTitleColor(UIColor.lessLightLightGray, for: .normal)
		return button
	}()
	
	// Dots at the bottom for viewing the page we are on & what not
	lazy var pageControl: UIPageControl = {
		let pc = UIPageControl()
		pc.currentPage = 0
		pc.numberOfPages = pages.count // access member of your class thanks to lazy var
		pc.currentPageIndicatorTintColor = UIColor.mainBlue
		pc.pageIndicatorTintColor = UIColor.bgBlue
		return pc
	}()
	
	// Add previous button - private so that no other .swift classes can access this
	private let nextButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("NEXT", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.setTitleColor(UIColor.mainBlue, for: .normal)
		button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
		return button
	}()
	
	// Add skip button - private so that no other .swift classes can access this
	private let skipButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Skip", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
		button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
		button.setTitleColor(UIColor.lighterBlueGray, for: .normal)
		return button
	}()
	
	// next button handler
	@objc private func handleNext() {
		
		// protect the crash for the 4 pages when 3 are visible
		// uses min so we dont end up on page 4 of 3
		let nextIndex = min(pageControl.currentPage + 1, pages.count - 1) // use the pc value for the value for what page we are on
		
		if nextButton.titleLabel?.text == "DONE" && pageControl.currentPage == pages.count - 1 {
			self.saveForCompletingOnboarding()
		}
		else {
			if pages.count - 1 == nextIndex {
				self.nextButton.setTitle("DONE", for: .normal)
			}
			else {
				self.nextButton.setTitle("NEXT", for: .normal)
			}
			
			if nextIndex > 0 {
				self.previousButton.setTitle("PREV", for: .normal)
			}
			
			// at the end
			if pageControl.currentPage == nextIndex {
				self.dismiss(animated: true, completion: nil)
			}
			else {
				pageControl.currentPage = nextIndex // reset value for pc.current
				let indexPath = IndexPath(item: nextIndex, section: 0)
				collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
			}
		}
	}
	
	@objc private func handleSkip() {
		self.saveForCompletingOnboarding()
	}
	
	
	// previous button handler
	@objc private func handlePrev() {
		
		// protect the crash for the 4 pages when 3 are visible
		// uses max so we dont end up on page -1
		let nextIndex = max(pageControl.currentPage - 1, 0) // use the pc value for the value for what page we are on
		pageControl.currentPage = nextIndex // reset value for pc.current
		
		if nextIndex == 0 {
			self.previousButton.setTitle("", for: .normal)
		}
		else {
			self.previousButton.setTitle("PREV", for: .normal)
		}
		
		if pages.count - 1 == nextIndex {
			self.nextButton.setTitle("DONE", for: .normal)
		}
		else {
			self.nextButton.setTitle("NEXT", for: .normal)
		}
		
		let indexPath = IndexPath(item: nextIndex, section: 0)
		collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
	override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
											withVelocity velocity: CGPoint,
											targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let x = targetContentOffset.pointee.x
		let pageID = x / view.frame.width // this is kinda cool
		pageControl.currentPage = Int(pageID) // set the dot to be the current page
		
		if pageControl.currentPage == 0 {
			self.previousButton.setTitle("", for: .normal)
		}
		else {
			self.previousButton.setTitle("PREV", for: .normal)
		}
		
		// change the text on the next button given the swipe action
		if pages.count - 1 == pageControl.currentPage {
			self.nextButton.setTitle("DONE", for: .normal)
		}
		else {
			self.nextButton.setTitle("NEXT", for: .normal)
		}
	}
	
	// MARK: Start
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupBottomControls()
		setupSkipButton()
		
		collectionView?.backgroundColor = UIColor(red: 27/255, green: 41/255, blue: 51/255, alpha: 1)
		// add this line to prevent NSInternalInconsistencyException & register cells
		collectionView?.register(OnboardingCell.self, forCellWithReuseIdentifier: "cellId") // adding custom View Cell - this is important too
		collectionView?.isPagingEnabled = true // allows for snaps between the cells
		collectionView?.showsHorizontalScrollIndicator = false
	}
	
	//using FilePrivate because the init of the button is private - this preserves the privacy
	fileprivate func setupBottomControls() {
		
		// Using UI Stack view for adding buttons to the bottom - much more effiencent & easy
		let bottomControlsStackView = UIStackView(arrangedSubviews:
			[previousButton, pageControl, nextButton])
		
		bottomControlsStackView.distribution = .fillEqually // Tells the stack view to split
		view.addSubview(bottomControlsStackView)
		
		bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
		
		if #available(iOS 11.0, *) {
			NSLayoutConstraint.activate([
				bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
				bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor), // safe for landscape
				bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
				bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
			])
		} else {
			// Fallback on earlier versions
			NSLayoutConstraint.activate([
				bottomControlsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
				bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // safe for landscape
				bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
			])
		}
	}
	
	fileprivate func setupSkipButton() {
		view.addSubview(skipButton)
		
		skipButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
			skipButton.widthAnchor.constraint(equalToConstant: 40),
			skipButton.heightAnchor.constraint(equalToConstant: 25),
			skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 28)
		])
	}
	
	// MARK: Save in UserDefaults
	
	func saveForCompletingOnboarding() {
		
		// check first again to make sure
		let savedAlready = loadAndCheckOnboarding()
		
		if !savedAlready {
			let completedTask = "completed"
			
			UserDefaults.standard.set(completedTask, forKey: onboardingKey)
			UserDefaults.standard.synchronize()
			
			self.dismiss(animated: true, completion: nil)
		}
		else {
			print("Already saved this operation, dismissing before saving a duplicate string.")
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	func loadAndCheckOnboarding() -> Bool {
		
		if let loadedData = UserDefaults.standard.string(forKey: onboardingKey) {
			onboardingString = loadedData
			
			if onboardingString == "completed" {
				return true
			}
		}
		return false
		
	}
	
}
