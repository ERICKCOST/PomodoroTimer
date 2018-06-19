//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Swift on 09/05/2018.
//  Copyright © 2018 Erick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var labelTempo: UILabel!
    
    @IBOutlet weak var sliderTempo: UISlider!
    @IBOutlet weak var progressContagem: UIProgressView!
    
    @IBOutlet weak var btnIniciar: UIButton!
    @IBOutlet weak var btnPausar: UIButton!
    @IBOutlet weak var btnReiniciar: UIButton!
    
    
    @IBOutlet weak var botao10: UIButton!
    @IBOutlet weak var botao25: UIButton!
    @IBOutlet weak var botao15: UIButton!
    
    
    @IBOutlet weak var imagemTomate: UIImageView!
    
    
    //MARK: Propriedade
    
    var contador = 0
    var tempoInicial = 0
    var temporizador = Timer()
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        
        self.labelTempo.textColor = UIColor.white
        
        btnIniciar.isEnabled = false
        btnPausar.isEnabled = false
        btnReiniciar.isEnabled = false
        
        progressContagem.isHidden = true
    
        
        super.viewDidLoad()
        
    }
    
    //MARK: Actions
    
    @IBAction func almentar25Min(_ sender: UIButton) {
        
        contador = 1500
        atualizarLabel(segundos: contador)
        sliderTempo.value = 25

        
        btnIniciar.isEnabled = true
        
    }
    
    @IBAction func almentar10min(_ sender: UIButton) {
        
        contador = 600
        atualizarLabel(segundos: contador)
        
        sliderTempo.value = 10

        
        btnIniciar.isEnabled = true
        
    }
    @IBAction func almentar15min(_ sender: UIButton) {
        
        contador = 900
        
        atualizarLabel(segundos: contador)
        
        sliderTempo.value = 15

        btnIniciar.isEnabled = true
        
        
    }
    
    @IBAction func almentarMinutoAMinuto(_ sender: UISlider) {
        
        let tempo = sender.value
        
        contador = Int(tempo)*60
        
        atualizarLabel(segundos: contador)
        btnIniciar.isEnabled = false
        
        if sliderTempo.value != 0 {
            btnIniciar.isEnabled = true
        }
        
    }
    
    @IBAction func iniciar(_ sender: UIButton) {
        
        self.imagemTomate.image = #imageLiteral(resourceName: "871cc5a8a5f00c21047fd7342403b4d3-tomato.png")
        
        tempoInicial = contador
        
        btnIniciar.isEnabled = false
        btnPausar.isEnabled = true
        btnReiniciar.isEnabled = true
        botao10.isEnabled = false
        botao15.isEnabled = false
        botao25.isEnabled = false
        
        botao10.isHidden = true
        botao15.isHidden = true
        botao25.isHidden = true
        
        progressContagem.isHidden = false
        sliderTempo.isHidden = true
        sliderTempo.isEnabled = false
        
        
        
        
        //Temporisador
        
        temporizador = Timer.scheduledTimer(withTimeInterval: 1, repeats: true , block: { (tempo) in
            
            self.contador -= 1
            
            if self.contador >= 0{
                
             
                
                let progress = (Float((self.tempoInicial - self.contador) / self.tempoInicial))
                
                let div = roundf(progress / Float(self.tempoInicial))
                //FIXME: arrumar divisao
                   print (self.progressContagem.progress , progress , roundf(2/6), div)
                self.progressContagem.progress = Float((self.tempoInicial - self.contador)  / self.tempoInicial)
                
                self.atualizarLabel(segundos: self.contador)
            }
            else{
                
                if self.labelTempo.textColor == UIColor.black{
                    self.labelTempo.textColor = UIColor.white
                }else{
                    self.labelTempo.textColor = UIColor.black
                }
            }
        })
    }
    
    @IBAction func pausar(_ sender: UIButton) {
        btnIniciar.isEnabled = true
        btnPausar.isEnabled = false
        btnReiniciar.isEnabled = true
        
        temporizador.invalidate()
    }
    
    
    @IBAction func reiniciar(_ sender: UIButton) {
        
        self.labelTempo.textColor = UIColor.white
        
        btnIniciar.isEnabled = true
        btnPausar.isEnabled = false
        btnReiniciar.isEnabled = false
        botao10.isEnabled = true
        botao15.isEnabled = true
        botao25.isEnabled = true
        
        botao10.isHidden = false
        botao15.isHidden = false
        botao25.isHidden = false
        
        progressContagem.isHidden = true
        sliderTempo.isHidden = false
        sliderTempo.isEnabled = true
        
        temporizador.invalidate()
        
        contador = tempoInicial
        atualizarLabel(segundos: contador)
    }
    
    
    
    //MARK: Métodos PROPRIOS
    
    func atualizarLabel(segundos: Int) {
        
        
        let minutos = segundos / 60
        let seg = segundos % 60
        
        labelTempo.text = "\(minutos)Min \(seg)Seg"
        
    }
    
}

