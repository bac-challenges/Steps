//
//  LineChart.swift
//  LineChart
//
//  Created by Nguyen Vu Nhat Minh on 25/8/17.
//  Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit

class LineChart: UIView {
    
    /// gap between each point
    var lineGap: CGFloat = 60
    
    /// preseved space at top of the chart
    let topSpace: CGFloat = 40.0
    
    /// preserved space at bottom of the chart to show labels along the Y axis
    let bottomSpace: CGFloat = 40.0
    
    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
    let topHorizontalLine: CGFloat = 100.0 / 100.0
    
    var dataEntries: [PointEntry]? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// Contains the main line which represents the data
    private let dataLayer: CALayer = CALayer()

    /// Contains dataLayer and gradientLayer
    private let mainLayer: CALayer = CALayer()
    
    /// Contains mainLayer and label for each data entry
    private let scrollView: UIScrollView = UIScrollView()
    
    /// Contains horizontal lines
    private let gridLayer: CALayer = CALayer()
    
    /// An array of CGPoint on dataLayer coordinate system that the main line will go through.
	/// These points will be calculated from dataEntries array
    private var dataPoints: [CGPoint]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        mainLayer.addSublayer(dataLayer)
        layer.addSublayer(gridLayer)
		layer.addSublayer(mainLayer)
		backgroundColor = .clear
    }
    
    override func layoutSubviews() {

		if let dataEntries = dataEntries {
			
            mainLayer.frame = CGRect(x: 0,
									 y: 0,
									 width: CGFloat(dataEntries.count) * lineGap,
									 height: self.frame.size.height)
			
            dataLayer.frame = CGRect(x: 0,
									 y: topSpace,
									 width: mainLayer.frame.width,
									 height: mainLayer.frame.height - topSpace - bottomSpace)
			
            dataPoints = convertDataEntriesToPoints(entries: dataEntries)
			
            gridLayer.frame = CGRect(x: 0,
									 y: topSpace,
									 width: self.frame.width,
									 height: mainLayer.frame.height - topSpace - bottomSpace)
			
            clean()
            drawHorizontalLines()
			drawCurvedChart()
			drawLables()
        }
    }
    
    // Convert an array of PointEntry to an array of CGPoint on dataLayer coordinate system
    private func convertDataEntriesToPoints(entries: [PointEntry]) -> [CGPoint] {
		
        if let max = entries.max()?.value,
		   let min = entries.min()?.value {
            
            var result: [CGPoint] = []
            let minMaxRange: CGFloat = CGFloat(max - min) * topHorizontalLine
            
            for i in 0..<entries.count {
                let height = dataLayer.frame.height * (1 - ((CGFloat(entries[i].value) - CGFloat(min)) / minMaxRange))
                let point = CGPoint(x: CGFloat(i)*lineGap + 40, y: height)
                result.append(point)
            }
            return result
        }
        return []
    }
    
    //  Draw a zigzag line connecting all points in dataPoints
    private func drawChart() {
		
        if let dataPoints = dataPoints, dataPoints.count > 0, let path = createPath() {
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = UIColor.white.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }

    // Create a zigzag bezier path that connects all points in dataPoints
    private func createPath() -> UIBezierPath? {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
            return nil
        }
        let path = UIBezierPath()
        path.move(to: dataPoints[0])
        
        for i in 1..<dataPoints.count {
            path.addLine(to: dataPoints[i])
        }
        return path
    }
    
    // Draw a curved line connecting all points in dataPoints
    private func drawCurvedChart() {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
            return
        }
        if let path = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = UIColor.white.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }
    
    //  Create titles at the bottom for all entries showed in the chart
    private func drawLables() {
        if let dataEntries = dataEntries, dataEntries.count > 0 {
            for i in 0..<dataEntries.count {
				let textLayer = horizontalTextLabel(width: lineGap, height: 16, value: i)
                mainLayer.addSublayer(textLayer)
            }
        }
    }
    
    // Create horizontal lines (grid lines) and show the value of each line
    private func drawHorizontalLines() {
        guard let dataEntries = dataEntries else {
            return
        }
        
        var gridValues: [CGFloat]? = nil
        if dataEntries.count < 4 && dataEntries.count > 0 {
            gridValues = [0, 1]
        } else if dataEntries.count >= 4 {
            gridValues = [0, 0.25, 0.5, 0.75, 1]
        }
		
        if let gridValues = gridValues {
            gridValues.forEach { value in
				let height = value * gridLayer.frame.size.height
				
				let path = UIBezierPath()
				path.move(to: CGPoint(x: 0, y: height))
				path.addLine(to: CGPoint(x: gridLayer.frame.size.width, y: height))
				
				// Vertical Line Layer
				let lineLayer = verticalLineLayer(path: path)
				gridLayer.addSublayer(lineLayer)
				
				// Vertical text labels position
				let min = 0
				let max = 20000
				var lineValue: Int = 0
				var minMaxGap: CGFloat = 0
				minMaxGap = CGFloat(max - min) * topHorizontalLine
				lineValue = Int((1-value) * minMaxGap) + Int(min)
				
				// Vertical labels
				let textLayer = verticalTextLabel(width: 50, height: height, value: lineValue)
				gridLayer.addSublayer(textLayer)
			}
        }
    }
    
    private func clean() {
        mainLayer.sublayers?.forEach({
            if $0 is CATextLayer {
                $0.removeFromSuperlayer()
            }
        })
        dataLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
        gridLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
	
	// Create Vertical Line Layer
	private func verticalLineLayer(path: UIBezierPath) -> CAShapeLayer {
		let lineLayer = CAShapeLayer()
		lineLayer.path = path.cgPath
		lineLayer.fillColor = UIColor.clear.cgColor
		lineLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
		lineLayer.lineWidth = 0.5
		return lineLayer
	}
	
	// Create Horizontal Text Label
	private func horizontalTextLabel(width: CGFloat, height: CGFloat, value: Int) -> CATextLayer {
		let x = lineGap*CGFloat(value) - lineGap/2 + 40
		let y = mainLayer.frame.size.height - bottomSpace/2 - 8
		
		var textLayer = CATextLayer()
		textLayer.frame = CGRect(x: x, y: y, width: width, height: height)
		textLayer.alignmentMode = .center
		styleTextLayer(&textLayer, value: dataEntries![value].label)
		return textLayer
	}
	
	// Create Vertical Text Label
	private func verticalTextLabel(width: CGFloat, height: CGFloat, value: Int) -> CATextLayer {
		let x = frame.width - width - 16
		let y = height-16
		
		var textLayer = CATextLayer()
		textLayer.frame = CGRect(x: x, y: y, width: width, height: 16)
		textLayer.alignmentMode = .right
		styleTextLayer(&textLayer, value:  "\(value)")
		return textLayer
	}
	
	// Chart Legent Text Label
	private func styleTextLayer( _ textLayer: inout CATextLayer, value: String) {
		textLayer.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
		textLayer.backgroundColor = UIColor.clear.cgColor
		textLayer.contentsScale = UIScreen.main.scale
		textLayer.font = UIFont.systemFont(ofSize: 0, weight: .semibold)
		textLayer.fontSize = 11
		textLayer.string = value
	}
}
