import SwiftUI

struct ContentView: View {
    @State private var input = ""
    @State private var fromUnit = "Meters"
    @State private var toUnit = "Feet"

    let units = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Enter value", text: $input)
                        .keyboardType(.decimalPad)
                }

                Section("From") {
                    Picker("From", selection: $fromUnit) {
                        ForEach(units, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }

                Section("To") {
                    Picker("To", selection: $toUnit) {
                        ForEach(units, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Result") {
                    Text(result)
                }
            }
            .navigationTitle("Unit Converter")
        }
    }

    var result: String {
        guard let value = Double(input), !input.isEmpty else {
            return "Enter a number"
        }

        let toMeters: [String: Double] = [
            "Meters": 1,
            "Kilometers": 1000,
            "Feet": 0.3048,
            "Yards": 0.9144,
            "Miles": 1609.344
        ]

        guard let inputFactor = toMeters[fromUnit],
              let outputFactor = toMeters[toUnit] else {
            return "Error"
        }

        let meters = value * inputFactor
        let output = meters / outputFactor

        return String(format: "%.4f \(toUnit)", output)
    }
}

#Preview {
    ContentView()
}
