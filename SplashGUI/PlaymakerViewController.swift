//
//  PlaymakerViewController.swift
//  SplashGUI
//
//  Created by Seyyedfarid Kamizi on 2/2/23.
//

import UIKit
import CoreServices
import playmaker

//fileNames
var fileURLs: [URL] = []

var currentFileSelected: String = ""

class PlaymakerViewController: UIViewController, UIDocumentPickerDelegate {
    
    
    //folder path
    var pickedFolderURL: URL? = nil
    var directoryContainsMDFiles: Bool = false
    
    
    @IBOutlet var playgroundIt: UIButton!
    @IBOutlet var playgroundTextEditor: UITextView!
    @IBOutlet var fileList: UIStackView!
    
    //File Buttons
    @IBOutlet var nextFileButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    // Text Editor Buttons
    @IBOutlet var h1Button: UIButton!
    @IBOutlet var h2Button: UIButton!
    @IBOutlet var h3Button: UIButton!
    @IBOutlet var noteButton: UIButton!
    @IBOutlet var codeBlockButton: UIButton!
    @IBOutlet var codeLineButton: UIButton!
    @IBOutlet var boldButton: UIButton!
    @IBOutlet var italicsButton: UIButton!
    @IBOutlet var ulButton: UIButton!
    @IBOutlet var horizontalButton: UIButton!
    @IBOutlet var linkButton: UIButton!
    @IBOutlet var imageButton: UIButton!
    
    /* -------------------- Functions Below ------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playgroundIt.isEnabled = false
        self.playgroundTextEditor.text = ""
    }
    

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let safelyWrappedURL = urls.first else { return }
        self.pickedFolderURL = safelyWrappedURL
        
        clearFileList()
        
        let mdFiles = safelyWrappedURL.getFilesOfTypeInDirectory(directory: safelyWrappedURL, fileExtension: "md")
        
        if mdFiles.count > 0 {
            directoryContainsMDFiles = true
            self.playgroundIt.isEnabled = true
        }
        
        setupFileList()
    }
    
    
    @IBAction func selectFolder(_ sender: Any) {
        let documentPickerController = UIDocumentPickerViewController(documentTypes: [kUTTypeFolder as String], in: .open)
        documentPickerController.delegate = self
        present(documentPickerController, animated: true)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        let textToSave = playgroundTextEditor.text ?? ""
        let fileURL = fullFilePath(fileName: currentFileSelected)
        
        do {
            try textToSave.write(to: fileURL, atomically: true, encoding: .utf8)
            print("File saved successfully at \(fileURL.path)")
        } catch {
            print("Error saving file: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func playgroundize(_ sender: Any) {
        guard let safelyUnwrapped = pickedFolderURL else { return }
        guard directoryContainsMDFiles else { return }
        
        let arr: [String] = [safelyUnwrapped.relativePath]
        playmaker.init(args: arr)
        
        let file = safelyUnwrapped.getFilesOfTypeInDirectory(directory: safelyUnwrapped, fileExtension: "playground")
        
        if(file.count > 0) {
            cleanUp()
        }
    }
        
    func cleanUp() {
        self.pickedFolderURL = nil
        self.playgroundIt.isEnabled = false
    }
    
    
    @IBAction func h1ButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert("#", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted symbol
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 1, 0)
    }
    
    
    @IBAction func h2ButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(contentsOf:"##", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted symbol
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 2, 0)
    }
    
    
    @IBAction func h3ButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(contentsOf:"###", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted symbol
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 3, 0)
    }
    
    
    @IBAction func noteButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(">", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted quote mark
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 1, 0)
    }
    
    
    @IBAction func codeBlockButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(contentsOf:"```\n\n```", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted quote mark
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 4, 0)
    }
    
    
    @IBAction func codeLineButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(contentsOf:"``", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted quote mark
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 1, 0)
    }
    
    
    @IBAction func boldButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(contentsOf:"****", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted quote mark
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 2, 0)
    }
    
    
    @IBAction func italicsButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(contentsOf:"**", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted quote mark
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 1, 0)
    }
    
    
    @IBAction func ulButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(contentsOf:"* ", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted quote mark
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 2, 0)
    }
    
    
    @IBAction func horizontalButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(contentsOf:"---\n", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted quote mark
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 4, 0)
    }
    
    
    @IBAction func linkButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(contentsOf:"[<insert title here>](<insert URL here>)\n", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted quote mark
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 1, 0)
    }
    
    
    @IBAction func imageButtonTapped(_ sender: Any) {
        // Get the current cursor position
        let cursorPosition = playgroundTextEditor.selectedRange.location
        
        // Get the current text of the UITextView
        var newText = playgroundTextEditor.text ?? ""
            
        // Insert the opening quote mark behind the cursor position
        newText.insert(contentsOf:"![<alt text>](<image.jpg>)", at: newText.index(newText.startIndex, offsetBy: cursorPosition))
            
        // Update the text of the UITextView
        playgroundTextEditor.text = newText
            
        // Adjust the cursor position after the inserted quote mark
        playgroundTextEditor.selectedRange = NSMakeRange(cursorPosition + 2, 0)
    }
    
    
    func createButton(name: String) {
        // Create a new button object
        let fileButton = UIButton(type: .roundedRect)
        // Set the button's properties.
        playgroundTextEditor.text.append("\(name)\n")
        // Set its background color
        fileButton.backgroundColor = UIColor.systemBlue

        // Set its title color
        fileButton.setTitleColor(UIColor.white, for: .normal)

        // Set its title
        fileButton.setTitle(name, for: .normal)
        fileButton.contentHorizontalAlignment = .left
        fileButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        
        //add its action
        fileButton.addTarget(self, action: #selector(openFile(sender:)), for: .touchUpInside)

        // Add the button to the view hierarchy.
        fileList.addArrangedSubview(fileButton)
        
    }
    
    
    func setupFileList() {
        sortFileList()
        for currentFile in fileURLs {
            createButton(name: currentFile.lastPathComponent.description)
        }
    }
    
    
    //called every time a folder is opened from DocumentPicker
    func clearFileList(){
        fileURLs = []
        for fileButton in fileList.arrangedSubviews {
            fileList.removeArrangedSubview(fileButton)
            fileButton.removeFromSuperview()
        }
    }
    
    
    func sortFileList(){
        fileURLs = fileURLs.sorted { $0.lastPathComponent.lowercased() < $1.lastPathComponent.lowercased() }
    }
    
    
    func fullFilePath(fileName: String) -> URL {
    
        guard let pickedFolderURL = pickedFolderURL else {
                // Handle the case where pickedFolderURL is nil or not set
                exit(0)
        }
        let fullFilePath = pickedFolderURL.appendingPathComponent(fileName)
        
        return fullFilePath
    }
    

    func readFile(fileName: String) -> String{
        guard let fileContents = try? String(contentsOf: fullFilePath(fileName: fileName), encoding: .utf8) else { exit(0) }
        updateSelectedFile(selectedFile: fileName)
        return fileContents
    }
    
    
    func updateSelectedFile(selectedFile: String) {
        currentFileSelected = selectedFile
    }
    
    
    @objc func openFile(sender: UIButton){
        playgroundTextEditor.text = readFile(fileName: sender.titleLabel!.text!)
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
                        fileURLs.append(fileURL)
                    }
                } catch { print(error, fileURL) }
            }
        }
        
        return stringDisplay
    }
    
}
