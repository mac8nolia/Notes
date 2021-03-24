//
//  NoteProvider.swift
//  Notes
//
//  Created by Ольга on 23.03.2021.
//

import CoreData

class NoteProvider {
    
    private let coreDataStack: CoreDataStack
    
    private weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?
    
    init(with coreDataStack: CoreDataStack,
         fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?) {
        self.coreDataStack = coreDataStack
        self.fetchedResultsControllerDelegate = fetchedResultsControllerDelegate
    }
    
    /**
     A fetched results controller for the Note entity, sorted by time stamp of creating
     */
    lazy var fetchedResultsController: NSFetchedResultsController<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: coreDataStack.context,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = fetchedResultsControllerDelegate
        
        do {
            try controller.performFetch()
        } catch {
            fatalError("###\(#function): Failed to performFetch: \(error)")
        }
        
        return controller
    }()
    
    /**
     Creates new Note in database
     */
    func createNote(title: String, text: String, imageData: Data?) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: coreDataStack.context) else { return }
        let note = Note(entity: entity, insertInto: coreDataStack.context)
        
        note.title = title
        note.text = text
        if let data = imageData {
            note.image = data
        }
        // Create timestamp with current time for next sorting of the notes
        note.timestamp = Date()
        
        coreDataStack.saveContext()
    }
    
    /**
     Deletes Note from database
     */
    func delete(note: Note) {
        coreDataStack.context.delete(note)
        coreDataStack.saveContext()
    }
}
