//
//  ViewController.swift
//  Project27
//
//  Created by Edwin Przeźwiecki Jr. on 29/10/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        
        currentDrawType += 1
        
        /// Challenge 1:
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        /// Challenge 1:
        case 6:
            drawStarEmoji()
        case 7:
            drawTWINString()
        default:
            break
        }
    }
    
    func drawRectangle() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = img
    }
    
    func drawCircle() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = img
    }
    
    func drawCheckerboard() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        imageView.image = img
    }
    
    func drawRotatedSquares() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = img
    }
    
    func drawLines() {
        
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = render.image { ctx in
            
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = img
    }
    
    func drawImagesAndText() {
        
        /// 1. Create a renderer at the correct size:
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            /// 2. Define a paragraph style that aligns text to the center:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            /// 3. Create an attributes dictionary containing that paragraph style, and also a font:
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            /// 4. Wrap that attributes dictionary and a string into an instance of NSAttributedString:
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            /// 5: Load an image from the project and draw it to the context.
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        /// 6. Update the image view with the finished result.
        imageView.image = img
    }
    
    /// Challenge 1:
    func drawStarEmoji() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var length: CGFloat = 240
            
            ctx.cgContext.rotate(by: -.pi / 2)
            ctx.cgContext.move(to: CGPoint(x: length, y: 0))
            
            for _ in 0 ..< 360 {
                ctx.cgContext.rotate(by: -.pi / 0.83333)
                ctx.cgContext.addLine(to: CGPoint(x: length, y: 0))
                ctx.cgContext.rotate(by: -.pi / 0.83333)
                ctx.cgContext.addLine(to: CGPoint(x: length, y: 0))
                ctx.cgContext.rotate(by: -.pi / 0.83333)
                ctx.cgContext.addLine(to: CGPoint(x: length, y: 0))
                ctx.cgContext.rotate(by: -.pi / 0.83333)
                ctx.cgContext.addLine(to: CGPoint(x: length, y: 0))
                ctx.cgContext.rotate(by: -.pi / 0.83333)
                ctx.cgContext.addLine(to: CGPoint(x: length, y: 0))
                ctx.cgContext.rotate(by: -.pi / 0.83333)
                ctx.cgContext.addLine(to: CGPoint(x: length, y: 0))
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.systemYellow.cgColor)
            ctx.cgContext.setLineWidth(5)
            ctx.cgContext.strokePath()
        }
        imageView.image = img
    }
    
    /// Challenge 2:
    func drawTWINString() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            ctx.cgContext.translateBy(x: 256, y: 256)
            /// "T":
            ctx.cgContext.move(to: CGPoint(x: -250, y: -64))
            ctx.cgContext.addLine(to: CGPoint(x: -134, y: -64))
            ctx.cgContext.move(to: CGPoint(x: -192, y: -64))
            ctx.cgContext.addLine(to: CGPoint(x: -192, y: 64))
            /// "W":
            ctx.cgContext.move(to: CGPoint(x: -122, y: -64))
            ctx.cgContext.addLine(to: CGPoint(x: -122, y: 64))
            ctx.cgContext.addLine(to: CGPoint(x: -60, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: -6, y: 64))
            ctx.cgContext.addLine(to: CGPoint(x: -6, y: -64))
            /// "I":
            ctx.cgContext.move(to: CGPoint(x: 60, y: 64))
            ctx.cgContext.addLine(to: CGPoint(x: 60, y: -64))
            /// "N":
            ctx.cgContext.move(to: CGPoint(x: 134, y: 64))
            ctx.cgContext.addLine(to: CGPoint(x: 134, y: -64))
            ctx.cgContext.addLine(to: CGPoint(x: 250, y: 64))
            ctx.cgContext.addLine(to: CGPoint(x: 250, y: -64))
            
            ctx.cgContext.setStrokeColor((UIColor.black.cgColor))
            ctx.cgContext.setLineWidth(3)
            ctx.cgContext.strokePath()
        }
        imageView.image = img
    }
}

