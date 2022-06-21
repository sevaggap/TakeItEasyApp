//
//  UpdateNotesViewController.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-08.
//

import UIKit
import Speech

class UpdateNotesViewController: UIViewController {

    var titleData : String? = " "
    var bodyData : String? = " "
    var noteId : Int64 = 0
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteBody: UITextView!
    @IBOutlet weak var textToSpeechLabel: UILabel!
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()
    let bufferRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask : SFSpeechRecognitionTask!
    var isStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitle.text = titleData
        noteBody.text = bodyData
        textToSpeechLabel.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if traitCollection.userInterfaceStyle == .dark
                {
            imageViewBackground.image = UIImage(named: "TakeItEasyBackground-Dark")
        } else {
            imageViewBackground.image = UIImage(named: "TakeItEasyBackground")
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle == .dark
                {
            imageViewBackground.image = UIImage(named: "TakeItEasyBackground-Dark")
        } else {
            imageViewBackground.image = UIImage(named: "TakeItEasyBackground")
        }
    }
    
    @IBAction func updateNotePressed(_ sender: Any) {
        print("updating")
        NotesHelper.notes.updateNote(noteId: noteId, title: noteTitle.text!, body: noteBody.text!)
    }

    @IBAction func startTextToSpeech(_ sender: Any) {
        if(isStart) {
            cancelSpeechRecognition()
            textToSpeechLabel.text = ""
        } else {
            startSpeechRecognition()
            textToSpeechLabel.text = "Text to Speech Enable"

        }
        
    }
    
    func startSpeechRecognition(){
        let inputNode = audioEngine.inputNode
        let recordFile = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordFile){ buffer, _ in
            self.bufferRecognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        do{
            try audioEngine.start()
        } catch {
            print("could not start audio engine")
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: bufferRecognitionRequest, resultHandler: {resp,error in
            guard let res = resp else{
                print("it's not working", error)
                return
            }
            
            let msg = resp?.bestTranscription.formattedString
            self.noteBody.text = msg
            
        })
        
        isStart = true
        
    }
    
    func cancelSpeechRecognition(){
        recognitionTask.finish()
        recognitionTask.cancel()
        recognitionTask = nil
        bufferRecognitionRequest.endAudio()
        audioEngine.stop()
        if audioEngine.inputNode.numberOfInputs > 0 {
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        isStart = false
    }
    
}
