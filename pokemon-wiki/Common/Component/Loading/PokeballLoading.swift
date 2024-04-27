//
//  PokeballLoading.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 27/4/2567 BE.
//

import Foundation
import UIKit
import Lottie

class PokeballLoading: UIView {
    
    @IBOutlet weak var pokeballAnimation: LottieAnimationView!
    
    static let nibName = "PokeballLoading"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        pokeballAnimation.animation          = LottieAnimation.named("pokeballLoading")
        pokeballAnimation.backgroundBehavior = .pauseAndRestore
        pokeballAnimation.loopMode           = .loop

    }

    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: PokeballLoading.nibName, bundle: .main)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
