//
//  PlaymakerViewController.swift
//  SplashGUI
//
//  Created by Seyyedfarid Kamizi on 2/2/23.
//

import UIKit
import CoreServices
import playmaker

class PlaymakerViewController: UIViewController, UIDocumentPickerDelegate {

    var pickedFolderURL: URL?
    var directoryContainsMDFiles: Bool = false
    
    @IBOutlet var playgroundIt: UIButton!
    @IBOutlet var feedbackTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedbackTextView.text = ""
        self.playgroundIt.isEnabled = false
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let safelyWrappedURL = urls.first else { return }
        self.pickedFolderURL = safelyWrappedURL
        
        self.feedbackTextView.text = "Input ⟶ \(safelyWrappedURL.relativePath )\n\n"
        let mdFiles = safelyWrappedURL.getFilesOfTypeInDirectory(directory: safelyWrappedURL, fileExtension: "md")
        
        mdFiles.forEach { mdFileStr in
            self.feedbackTextView.text = self.feedbackTextView.text + "\n" + mdFileStr

        }
        
        if mdFiles.count > 0 {
            directoryContainsMDFiles = true
            self.playgroundIt.isEnabled = true
        }
    }
    
    @IBAction func selectFile(_ sender: Any) {
        let documentPickerController = UIDocumentPickerViewController(documentTypes: [kUTTypeFolder as String], in: .open)
        
        documentPickerController.delegate = self
        
        self.present(documentPickerController, animated: true)
    }
    
    
    
    @IBAction func playgroundize(_ sender: Any) {
        guard let safelyUnwrapped = pickedFolderURL else { return }
        guard directoryContainsMDFiles else { return }
        
        let arr: [String] = [safelyUnwrapped.relativePath]
        playmaker.init(args: arr)
        
        let file = safelyUnwrapped.getFilesOfTypeInDirectory(directory: safelyUnwrapped, fileExtension: "playground")
        
        if(file.count > 0) {
            self.feedbackTextView.text = "Output ⟶ " + file[0]
            cleanUp()
        }
        
    }
    
    func cleanUp() {
        self.pickedFolderURL = nil
        self.playgroundIt.isEnabled = false
    }
    
}

extension URL {
    
    func getFilesOfTypeInDirectory(directory: URL, fileExtension: String) -> [String] {
        var stringDisplay: [String] = []
        
        if let enumerator = FileManager.default.enumerator(at: directory, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
            for case let fileURL as URL in enumerator {
                do {
                    let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                    if fileURL.pathExtension == fileExtension {
                        stringDisplay.append("\t\(fileURL.relativePath)\n")
                    }
                } catch { print(error, fileURL) }
            }
        }
        
        return stringDisplay
    }
    
}
