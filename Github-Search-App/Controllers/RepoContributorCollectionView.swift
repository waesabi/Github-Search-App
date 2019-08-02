//
//  RepoContributorCollectionView.swift
//  Github-Search-App
//
//  Created by sanket kumar on 31/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

protocol RepoContributorSelectionDelegate {
    func repoContributorSelected(repoContributorViewModel: ContributorViewModel)
}

class RepoContributorCollectionView: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var delegate: RepoContributorSelectionDelegate?
    
    let contributorCellId = "contributorCellId"
    
    var repoContributors: [RepoContributor]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var repoContributoListModel: ContributorListModel? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ContributorCell.self, forCellWithReuseIdentifier: contributorCellId)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repoContributoListModel?.numberOfContributors ?? 0
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contributorCellId, for: indexPath) as! ContributorCell
        if let viewModel = self.repoContributoListModel {
            cell.contributorViewModel = ContributorViewModel(repoContributor: viewModel.repoContributor(for: indexPath.row))
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 200, height: view.frame.height - 32)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let viewModel = repoContributoListModel else { return }
        delegate?.repoContributorSelected(repoContributorViewModel: ContributorViewModel(repoContributor: viewModel.repoContributor(for: indexPath.row)))
    }
    
}



