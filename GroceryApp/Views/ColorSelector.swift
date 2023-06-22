//
//  ColorSelector.swift
//  GroceryApp
//
//  Created by Brenda Saavedra Cantu on 16/06/23.
//

import SwiftUI

enum Colors: String, CaseIterable {
    case green = "#58D68D"
    case red = "#C70039"
    case blue = "#5DADE2"
    case purple = "#7D3C98"
    case yellow = "#F7DC6F"
}

struct ColorSelector: View {
    
    @Binding var colorCode: String
    
    var body: some View {
        HStack {
            ForEach(Colors.allCases, id:\.rawValue) { color in
                Image(systemName: colorCode == color.rawValue ? "record.circle.fill":"circle.fill")
                    .font(.title)
                    .foregroundColor(Color.fromHex(color.rawValue))
                    .clipShape(Circle())
                    .onTapGesture {
                        colorCode = color.rawValue
                    }
            }
        }
    }
}

struct ColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelector(colorCode: .constant(Colors.green.rawValue))
    }
}
