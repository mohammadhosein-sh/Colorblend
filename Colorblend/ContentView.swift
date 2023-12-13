import SwiftUI

struct ColorSchemeView: View {
    // State variables to store the selected colors
    @State private var firstColor: Color = .red
    @State private var secondColor: Color = .blue
    
    // State variable to store the compatible colors
    @State private var compatibleColors: [Color] = []
    
    var body: some View {
        VStack {
            // Color pickers for selecting the first and second colors
            VStack {
                ColorPicker("Select the first color", selection: $firstColor)
                    .padding()
                
                ColorPicker("Select the second color", selection: $secondColor)
                    .padding()
            }
            
            // Button to generate compatible colors
            Button("Generate Compatible Colors") {
                compatibleColors = generateCompatibleColors()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(8)
            
            // Text to indicate the compatible colors section
            Text("Compatible Colors:")
                .font(.headline)
                .padding()
            
            // Display compatible colors in a horizontal stack of rectangles with HEX codes
            HStack {
                ForEach(compatibleColors, id: \.self) { color in
                    VStack {
                        Rectangle()
                            .fill(color)
                            .frame(width: 50, height: 50)
                            .padding()
                        
                        // Display the HEX code of the color
                        Text(color.toHexString())
                            .font(.caption)
                    }
                }
            }
        }
        .padding()
    }
    
    // Function to generate compatible colors based on the selected colors
    func generateCompatibleColors() -> [Color] {
        // Extract RGB components of the selected colors
        guard let components1 = firstColor.cgColor?.components, let components2 = secondColor.cgColor?.components else {
            return []
        }
        
        // Calculate compatible colors based on the selected colors
        
        // Calculate compatibleColor1 as the average of the two selected colors
        let compatibleColor1 = Color(
            red: (components1[0] + components2[0]) / 2,
            green: (components1[1] + components2[1]) / 2,
            blue: (components1[2] + components2[2]) / 2
        )
        
        // Calculate compatibleColor2 as a mix of 75% from the first color and 25% from the second color
        let compatibleColor2 = Color(
            red: (components1[0] * 0.75 + components2[0] * 0.25),
            green: (components1[1] * 0.75 + components2[1] * 0.25),
            blue: (components1[2] * 0.75 + components2[2] * 0.25)
        )
        
        // Calculate compatibleColor3 as a mix of 25% from the first color and 75% from the second color
        let compatibleColor3 = Color(
            red: (components1[0] * 0.25 + components2[0] * 0.75),
            green: (components1[1] * 0.25 + components2[1] * 0.75),
            blue: (components1[2] * 0.25 + components2[2] * 0.75)
        )
        
        // Calculate compatibleColor4 as a mix of 40% from the first color and 40% from the second color
        let compatibleColor4 = Color(
            red: (components1[0] * 0.4 + components2[0] * 0.4),
            green: (components1[1] * 0.4 + components2[1] * 0.4),
            blue: (components1[2] * 0.4 + components2[2] * 0.4)
        )
        
        // Return the array of compatible colors
        return [compatibleColor1, compatibleColor2, compatibleColor3, compatibleColor4]
    }
}

struct ColorSchemeView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSchemeView()
    }
}

extension Color {
    func toHexString() -> String {
        guard let components = cgColor?.components else {
            return ""
        }
        
        let r = UInt8(components[0] * 255)
        let g = UInt8(components[1] * 255)
        let b = UInt8(components[2] * 255)
        
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}

