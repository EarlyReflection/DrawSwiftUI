//
//  Path.swift
//  DrawSwiftUI
//
//  Created by Vladimir Dvornikov on 07/03/2023.
//

import SwiftUI

struct PathView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 85, y: 300))
            path.addLine(to: CGPoint(x: 315, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
//            path.closeSubpath() // замыкает концы линии
        }
//        .fill(.blue) // заливка фигуры
        .stroke(.blue, style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round)) // скругляет углы

        
    }
}

struct PathView_Previews: PreviewProvider {
    static var previews: some View {
        PathView()
    }
}
