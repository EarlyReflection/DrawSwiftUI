//
//  ShapeView.swift
//  DrawSwiftUI
//
//  Created by Vladimir Dvornikov on 07/03/2023.
//

import SwiftUI

struct ShapeView: View {
    var body: some View {
        ZStack {
            Triangle()
                .stroke(lineWidth: 30)
                .fill(.red)
                .frame(width: 300, height: 300)
                .scaleEffect(0.5)
            Arc(startAngle: .degrees(0), endAngle: .degrees(270), clockwise: true)
                .strokeBorder(.blue, lineWidth: 15) // во отличие от .stroke делает обводку внутрь фигуры
                .frame(width: 300, height: 300)
        }
    }
}

struct ShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeView()
    }
}

// треугольник с относительными координатами в пространстве CGRect
struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.closeSubpath()

        return path
    }
}

//Дуга с  с относительными координатами в пространстве CGRect
struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        //корректирующие значения, возвращают к привычной системме координат
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2 - insetAmount,
                    startAngle: modifiedStart,
                    endAngle: modifiedEnd,
                    clockwise: !clockwise)
        
        return path
    }
    // метод для правильной работы со strokeBrder
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}
