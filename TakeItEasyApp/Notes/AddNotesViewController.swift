//
//  AddNotesViewController.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-08.
//

import UIKit
import Speech

class AddNotesViewController: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteBody: UITextField!
    @IBOutlet weak var textToSpeechLabel: UILabel!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()
    let bufferRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask : SFSpeechRecognitionTask!
    var isStrat = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textToSpeechLabel.text = ""
    }
    
    @IBAction func saveNotePressed(_ sender: Any) {
        NotesHelper.notes.addNote(title: noteTitle.text!, body: noteBody.text!)
    }
    

    @IBAction func startTextToSpeech(_ sender: Any) {
        if(isStrat) {
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
        
        isStrat = true
        
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
        isStrat = false
    }
}
