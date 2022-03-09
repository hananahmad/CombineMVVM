//
//  LinkHistoryViewController.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/23/22.
//

import Foundation
import UIKit
import Combine

final class LinkHistoryViewController: UIViewController, CoordinatorBoard {
    
    // MARK: - Properties
    private typealias DataSource = UITableViewDiffableDataSource<LinkHistoryViewModel.Section, ShortLink>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<LinkHistoryViewModel.Section, ShortLink>

    
    private lazy var contentView = LinkHistoryView()
    
    private let viewModel: LinkHistoryViewModel
    private var bindings = Set<AnyCancellable>()
    
    private var dataSource: DataSource!
    weak var homeChildCoordinator: HomeChildCoordinator?

    // MARK: - Lifecycle
    init(viewModel: LinkHistoryViewModel = LinkHistoryViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        setUpTableView()
        configureDataSource()
        setupTargets()
        setUpBindings()
    }
    
    private func setUpTableView() {
        contentView.tableView.register(
            ShortenURLTableCell.self, forCellReuseIdentifier: ShortenURLTableCell.identifier)
        contentView.tableView.separatorStyle = .none
    }
    
    // MARK: - SetupBindings

    private func setUpBindings() {
        func bindViewToViewModel() {
            contentView.addLinkTextField.textPublisher
                .debounce(for: 1.0, scheduler: RunLoop.main)
                .removeDuplicates()
                .sink { [weak viewModel] in
                    viewModel?.validateLink(link: $0)
                }
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.$links
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.updateSections()
                })
                .store(in: &bindings)
            
            let stateValueHandler: (LinkHistoryViewModelState) -> Void = { [weak self] state in
                
                self?.contentView.addLinkTextField.layer.borderColor = UIColor.white.cgColor

                switch state {
                case .loading:
                    self?.contentView.startLoading()
                case .finishedLoading:
                    self?.contentView.finishLoading()
                case .error(let error):
                    self?.contentView.finishLoading()
                    self?.showError(error)
                case .emptyTextField:
                    self?.contentView.addLinkTextField.layer.borderColor = UIColor.secondaryRed.cgColor
                    self?.contentView.addLinkTextField.textColor = .secondaryRed
                    self?.contentView.addLinkTextField.placeholder = "Please add a link here"

                case .validText:
                    self?.contentView.addLinkTextField.layer.borderColor = UIColor.white.cgColor
                    self?.contentView.addLinkTextField.textColor = .neutralVeryDarkVioletColor
                    
                }
            }
            
            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateSections() {
        var snapshot = Snapshot()
        snapshot.appendSections([.shortLink])
        snapshot.appendItems(viewModel.links)
        
        if !viewModel.links.isEmpty {
            self.setupInitialViews()
            self.contentView.addLinkTextField.text = ""
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - Actions
    private func setupTargets() {
        contentView.shortURLButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    @objc private func onClick() {
        viewModel.enterLink(link: contentView.addLinkTextField.text ?? "")
    }
    
    private func setupInitialViews() {
        self.contentView.tableView.isHidden = false
        self.contentView.headingLabel.isHidden = false
        self.contentView.illustrationImageView.isHidden = true
        self.contentView.logoImageView.isHidden = true
        self.contentView.letsGetStartedLabel.isHidden = true
        self.contentView.pasteLinkHintLabel.isHidden = true
    }
}

// MARK: - UITableViewDataSource

extension LinkHistoryViewController {
    private func configureDataSource() {
        dataSource = DataSource(tableView: contentView.tableView, cellProvider: {(tableview, indexPath, link) -> UITableViewCell? in
            let cell = tableview.dequeueReusableCell(withIdentifier: ShortenURLTableCell.identifier, for: indexPath) as? ShortenURLTableCell
            cell?.viewModel = ShortenURLCellViewModel(linkHistory: link)
            
            //Copy button tapped
            cell?.copyBtnPressed = { // [weak self] in
                cell?.viewModel.isCopied = true
            }
            
            //Delete button tapped
            cell?.deleteBtnPressed = { [weak self] in
                guard let link = self?.dataSource.itemIdentifier(for: indexPath) else { return }

                var snapshot = Snapshot()
                snapshot.deleteItems([link])
        
                self?.dataSource.apply(snapshot)
            }
            
            return cell
        })
    }
}
