//
//  MasterViewController.swift
//  Notes
//
//  Created by Ольга on 19.03.2021.
//

import UIKit
import CoreData

class MainViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    private lazy var noteProvider: NoteProvider = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let provider = NoteProvider(with: appDelegate!.coreDataStack, fetchedResultsControllerDelegate: self)
        return provider
    }()
    
    // MARK: - View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Мои заметки"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        
        let addNoteBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNoteAction))
        self.navigationItem.rightBarButtonItem = addNoteBarButtonItem
        
        tableView.register(NoteCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.separatorStyle = .none
    }
}
    
// MARK: - Table View Data Source

extension MainViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return noteProvider.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = noteProvider.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NoteCell
        let note = noteProvider.fetchedResultsController.object(at: indexPath)
        cell.show(title: note.title ?? "", text: note.text ?? "", image: getImageFrom(imageData: note.image))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = noteProvider.fetchedResultsController.object(at: indexPath)
            noteProvider.delete(note: note)
        }
    }
}

// MARK: - Table View Delegate

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note = noteProvider.fetchedResultsController.object(at: indexPath)
        let vc = DetailViewController()
        vc.noteTitle = note.title ?? ""
        vc.noteText = note.text ?? ""
        vc.image = getImageFrom(imageData: note.image)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
}

// MARK: - Fetched results controller

extension MainViewController {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .none)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .none)
            default:
                return
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

// MARK: - Actions handler

extension MainViewController {
    
    @objc func addNoteAction() {
        let vc = CreatingViewController()
        vc.completionHandler = {[unowned self] title, text, image in
            self.noteProvider.createNote(title: title, text: text, imageData: image?.pngData())
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Utilities

extension MainViewController {
    
    private func getImageFrom(imageData: Data?) -> UIImage? {
        if let data = imageData {
            return UIImage(data: data)
        } else {
            return AppImage.defaultPhoto
        }
    }
}
