//
//  EffectViewController.swift
//  camera
//
//  Created by 立岡力 on 2021/01/04.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 画面遷移時に元の画面を表示
        effectImage.image = originalImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // エフェクト前画面
    // 前の画面より画像を設定
    var originalImage : UIImage?
    
    
    @IBOutlet weak var effectImage: UIImageView!
    
    @IBAction func effectButtonAction(_ sender: Any) {
        if let image = originalImage {
            let filterName = "CIPhotoEffectMono"
            let rotate = image.imageOrientation
            let inputImage = CIImage(image: image)
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
            
            effectFilter.setDefaults()
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            guard let outputImage = effectFilter.outputImage else {
                return
            }
            
            let ciContext = CIContext(options: nil)
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
               
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        // 画面を閉じて前の画面に戻る
        dismiss(animated: true, completion: nil)
    }
    

}
