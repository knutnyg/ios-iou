//
//  SummaryViewController.swift
//  iou
//
//  Created by Knut Nygaard on 3/11/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit
import JBChartView
import CorePlot
//import PNCharstSwift


class SummaryGraphViewController:UIViewController, CPTBarPlotDataSource, CPTBarPlotDelegate{
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blueColor()
        
//        let url = NSURL(string: "https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50")
//        let data = NSData(contentsOfURL: url!)
//        let image = UIImage(data: data)
        


        var host = CPTGraphHostingView(frame: CGRect(x: 10, y: 50, width: 300, height: 150))
        host.allowPinchScaling = false
        self.view.addSubview(host)
        
        // create graph
        var graph = CPTXYGraph(frame: CGRectZero)
        graph.title = "Hello Graph"
        graph.paddingLeft = 0
        graph.paddingTop = 0
        graph.paddingRight = 0
        graph.paddingBottom = 0
        // hide the axes
//        var axes = graph.axisSet as CPTXYAxisSet
//        var lineStyle = CPTMutableLineStyle()
//        lineStyle.lineWidth = 1
//        axes.xAxis.axisLineStyle = lineStyle
//        axes.yAxis.axisLineStyle = lineStyle
//        axes.yAxis.orthogonalPosition = 0
        
        // add a pie plot
        var pie = CPTBarPlot(frame: CGRectZero)
        pie.dataSource = self
        var plotSpace = graph.defaultPlotSpace
        plotSpace.setPlotRange(CPTPlotRange(location: -30, length: 60.0), forCoordinate: CPTCoordinate.Y)
        plotSpace.setPlotRange(CPTPlotRange(location: 0.0, length: 7), forCoordinate: CPTCoordinate.X)
        
        graph.addPlot(pie)
        
        host.hostedGraph = graph

        var aImage = readResponseFromFile()
        var iw = UIImageView(image: aImage)
        iw.setTranslatesAutoresizingMaskIntoConstraints(false)
        iw.layer.cornerRadius = 25
        iw.clipsToBounds = true
        self.view.addSubview(iw)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[image(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["image":iw]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[image(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["image":iw]))
        
        

    }
    
    func numberForPlot(plot: CPTPlot!, field fieldEnum: UInt, recordIndex idx: UInt) -> NSNumber! {
        println(fieldEnum)
        switch fieldEnum {
        case 1:
            return NSNumber(unsignedInt: arc4random_uniform(5))
        case 0:
            return idx//NSNumber(unsignedInt: arc4random_uniform(10) - 5)
        default:
            return 0
        }
    }

    
    func numberOfRecordsForPlot(plot: CPTPlot!) -> UInt {
        return 8
    }
    
    func readResponseFromFile() -> UIImage{
        let path = NSBundle.mainBundle().pathForResource("image", ofType: "png")
        var data = NSData(contentsOfFile: path!)!
        //        var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        return UIImage(data: data)!
    }
}