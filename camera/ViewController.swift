//
//  ViewController.swift
//  camera
//
//  Created by 立岡力 on 2021/01/03.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // イメージビュー
    @IBOutlet weak var pictureImage: UIImageView!
    
    
    
    // カメラを起動する
    @IBAction func cameraButtonAction(_ sender: Any) {
        // カメラかフォトライブラリーどちらから画像を取得するか選択
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
       
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // カメラを起動するための選択肢を定義
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action) in
            
                // カメラを起動
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            
            })
            alertController.addAction(cameraAction)
        }
        // フォトライブラリーが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            // フォトライブラリーを起動するための選択肢を定義
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action) in
                
                // フォトライブラリーを起動
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            
            })
            alertController.addAction(photoLibraryAction)
        }
        // キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // iPadで落ちてしまう対策
        alertController.popoverPresentationController?.sourceView = view
        
        // 選択肢を画面に表示
        present(alertController, animated: true, completion: nil)
        
}
        
        
        
        
    // SNSに投稿する
    @IBAction func shareButtonAction(_ sender: Any) {
        
        // 表示画像をアンラップしてシェア画像を取り出し
        if let shareImage = pictureImage.image?.resize() {
            let shareItems = [shareImage]
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = view
            present(controller, animated: true, completion: nil)
        }
        
    }
    
    // 撮影が終わった時に呼び出されるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 撮影した画像を配置したcaptureImageに渡す
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        // モーダルビューを閉じる
        dismiss(animated: true, completion: {
        
            // エフェクト画面に遷移
            self.performSegue(withIdentifier: "showEffectView", sender: nil)
        })
    }
    // 次の画面遷移するときに渡す画像を格納する場所
    var captureImage : UIImage?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nextViewController = segue.destination as? EffectViewController{
            
            nextViewController.originalImage = captureImage
        }
        
    }
    
}

