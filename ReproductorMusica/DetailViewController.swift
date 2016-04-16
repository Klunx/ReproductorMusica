//
//  DetailViewController.swift
//  ReproductorMusica
//
//  Created by Fernando Renteria Correa on 12/04/2016.
//  Copyright © 2016 Fernando Renteria Correa. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController, AVAudioPlayerDelegate {

    private var reproductor: AVAudioPlayer!
    var song = SongObj()
    var songList = [SongObj]();
    var currentSong = 0

    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songImg: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var shuffle: UISwitch!
    
    @IBAction func reproducir() {
        reproductorPlay()
    }
    
    @IBAction func pause() {
        if reproductor.playing {
            reproductor.pause()
        }
    }
    
    @IBAction func detener() {
        if reproductor.playing {
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
    }
    
    @IBAction func updateVolume() {
        reproductor.volume = Float(self.stepper.value)
    }
    
    func reproductorPlay() {
        if !reproductor.playing {
            reproductor.play()
        }
    }
    
    func updateSongInfo() {
        self.songName.text = self.song.songName
        self.songImg.image = UIImage(named: self.song.imgSong)
        let sonidoURL = NSBundle.mainBundle().URLForResource(self.song.songPath, withExtension: self.song.songExt)
        
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURL!)
        } catch {
            print("Error al cargar el archivo de sonido")
        }
        reproductor?.delegate = self
        reproductor?.prepareToPlay()
        reproductorPlay()
        self.stepper.value = Double(reproductor.volume)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.song.songName != "") {
            updateSongInfo()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
        print("Inside")
        if self.shuffle.on {
            var randomSong = Int(arc4random_uniform(UInt32(self.songList.count)))
            
            repeat {
                randomSong = Int(arc4random_uniform(UInt32(self.songList.count)))
            } while (randomSong == currentSong)
            
            self.song = songList[randomSong]
            updateSongInfo()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
