//
//  ContentView.swift
//  Convert
//
//  Created by Md. Shoibur Rahman Khan Sifat on 9/29/24.
//

import SwiftUI


struct ContentView: View {
    let conversion: Dictionary<String, [String]> = [
        "Temperature": ["Celcius", "Fahrenheit", "Kelvin"],
        "Length": ["Meters", "Kilometers", "Feet", "Yards", "Miles"],
        "Time": ["Seconds", "Minutes", "Hours", "Days"],
        "Volume": ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
    ]
    @State private var selectedConversion = "Length"{
        didSet{
            if let units = conversion[selectedConversion] {
                selectedInputUnit = units.first ?? ""
                selectedOutputUnit = units[1]
            }
        }
    }
    @State private var selectedInputUnit:String = "Meters"
    @State private var selectedOutputUnit:String = "Kilometers"
    
    
    
    
    @State private var input: Double = 0.0
    @State private var output: Double = 0.0
    @FocusState private var isFocused: Bool
    
    func convert(from inputUnit: String, to outputUnit: String, input: Double) -> Double{
        switch (inputUnit,outputUnit){
        case ("Celcius", "Fahrenheit"):
            return input * 9/5 + 32
        case ("Celcius", "Kelvin"):
            return input + 273.15
        case ("Fahrenheit", "Celcius"):
            return (input - 32) * 5/9
        case ("Fahrenheit", "Kelvin"):
            return (input - 32) * 5/9 + 273.15
        case ("Kelvin", "Celcius"):
            return input - 273.15
        case ("Kelvin", "Fahrenheit"):
            return (input - 273.15) * 9/5 + 32
        case ("Meters", "Kilometers"):
            return input / 1000
        case ("Meters", "Feet"):
            return input * 3.28084
        case ("Meters", "Yards"):
            return input * 1.09361
        case ("Meters", "Miles"):
            return input * 0.000621371
        case ("Kilometers", "Meters"):
            return input * 1000
        case ("Kilometers", "Feet"):
            return input * 3280.84
        case ("Kilometers", "Yards"):
            return input * 1093.61
        case ("Kilometers", "Miles"):
            return input * 0.621371
        case ("Feet", "Meters"):
            return input * 0.3048
        case ("Feet", "Kilometers"):
            return input * 0.0003048
        case ("Feet", "Yards"):
            return input * 0.333333
        case ("Feet", "Miles"):
            return input * 0.000189394
        case ("Yards", "Meters"):
            return input * 0.9144
        case ("Yards", "Kilometers"):
            return input * 0.0009144
        case ("Yards", "Feet"):
            return input * 3
        case ("Yards", "Miles"):
            return input * 0.000538813
        case ("Miles", "Meters"):
            return input * 1609.344
        case ("Miles", "Kilometers"):
            return input * 1.60934
        case ("Miles", "Feet"):
            return input * 5280.00
        case ("Miles", "Yards"):
            return input * 1760
        case ("Seconds", "Minutes"):
            return input / 60
        case ("Seconds", "Hours"):
            return input / 3600
        case ("Seconds","Days"):
            return input / 86400
        case ("Minutes", "Seconds"):
            return input * 60
        case ("Minutes", "Hours"):
            return input / 60
        case ("Minutes", "Days"):
            return input / 1440
        case ("Hours", "Seconds"):
            return input * 3600
        case ("Hours", "Minutes"):
            return input * 60
        case ("Hours", "Days"):
            return input / 24
        case ("Days", "Seconds"):
            return input * 86400
        case ("Days", "Minutes"):
            return input * 1440
        case ("Days", "Hours"):
            return input * 24
        case ("Milliliters","Liters"):
            return input / 1000
        case ("Milliliters","Cups"):
            return input * 0.0042267
        case ("Milliliters","Pints"):
            return input * 0.0021133
        case ("Milliliters","Gallons"):
            return input * 0.000264172
        case ("Liters","Milliliters"):
            return input * 1000
        case ("Liters","Cups"):
            return input * 4.22675
        case ("Liters","Pints"):
            return input * 2.11338
        case ("Liters","Gallons"):
            return input * 0.26417205393700787
        case ("Cups","Milliliters"):
            return input * 236.58823659
        case ("Cups","Liters"):
            return input * 0.236588
        case ("Cups","Pints"):
            return input * 0.5
        case ("Cups","Gallons"):
            return input * 0.0625
        case ("Pints","Milliliters"):
            return input * 473.1764731
        case ("Pints","Liters"):
            return input * 0.473176
        case ("Pints","Cups"):
            return input * 2
        case ("Pints","Gallons"):
            return input * 0.125
        case ("Gallons","Milliliters"):
            return input * 3785.4117847
        case ("Gallons","Liters"):
            return input * 3.78541
        case ("Gallons","Cups"):
            return input * 16
        case ("Gallons","Pints"):
            return input * 8
        default:
            return input
        }
    }
    
            var body: some View {
                NavigationStack {
                    VStack(alignment: .leading) {
                        Picker("Select Unit", selection: $selectedConversion) {
                            ForEach(Array(conversion.keys).sorted(), id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: selectedConversion){
                            if let units = conversion[selectedConversion] {
                                selectedInputUnit = units.first ?? ""
                                selectedOutputUnit = units[1]
                                input = 0
                            }
                        }
                        .padding(.horizontal,16)
                        Form {
                            Section("Convert"){
                                GeometryReader{geometry in
                                    HStack{
                                        TextField("Enter Value", value: $input,format: .number)
                                            .keyboardType(.decimalPad)
                                            .focused($isFocused)
                                        Picker("", selection: $selectedInputUnit) {
                                            ForEach(conversion[selectedConversion] ?? [], id: \.self) {
                                                Text($0)
                                            }
                                        }
                                        .frame(width: geometry.size.width * 0.4)
                                        
                                    }
                                }
                                
                                
                            }
                            
                            
                            Section("To"){
                                GeometryReader{geometry in
                                    HStack{
                                        Text("\(convert(from: selectedInputUnit, to: selectedOutputUnit, input: input))")
                                            
                                        Spacer()
                                        Picker("", selection: $selectedOutputUnit) {
                                            ForEach(conversion[selectedConversion] ?? [], id: \.self) {
                                                Text($0)
                                            }
                                        }
                                        .frame(width: geometry.size.width * 0.4)
                                    }
                                }
                                
                            }
                           
                        }
                    }
                    
                            
                          
                    
                    .navigationTitle("Convert")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        if isFocused{
                            Button("Done"){
                                isFocused = false
                            }
                        }
                    }
                    
                }
            }
}
