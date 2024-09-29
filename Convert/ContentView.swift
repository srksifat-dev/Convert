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
    
    func convert(from inputUnit: String, to outputUnit: String, input: Double) -> Double{
        switch (inputUnit,outputUnit){
        case ("Celcius", "Fahrenheit"):
            return input * 9/5 + 32
        case ("Celcius", "Kelvin"):
            return input + 273.15
        case ("Fahrenheit", "Celcius"):
            return (input - 32) * 5/9
        case ("Fahrenheit", "Kelvin"):
            return (input - 3) * 5/9
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
            return input * 0.0006
        case ("Kilometers", "Meters"):
            return input * 1000
        case ("Kilometers", "Feet"):
            return input * 3280.84
        case ("Kilometers", "Yards"):
            return input * 1093.61
        case ("Kilometers", "Miles"):
            return input * 0.621371
        case ("Feet", "Meters"):
            return input / 3.28084
        case ("Feet", "Kilometers"):
            return input / 3280.84
        case ("Feet", "Yards"):
            return input / 3.28084
        case ("Feet", "Miles"):
            return input / 5280.00
        case ("Yards", "Meters"):
            return input / 1.09361
        case ("Yards", "Kilometers"):
            return input / 1093.61
        case ("Yards", "Feet"):
            return input * 3.28084
        case ("Yards", "Miles"):
            return input * 0.000538813
        case ("Miles", "Meters"):
            return input * 1609.344
        case ("Miles", "Kilometers"):
            return input * 1609.344 / 1.609344
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
            return input / 236.58823659
        case ("Milliliters","Pints"):
            return input / 473.1764731
        case ("Milliliters","Gallons"):
            return input / 3785.4117847
        case ("Liters","Milliliters"):
            return input * 1000
        case ("Liters","Cups"):
            return input * 4.54609177
        case ("Liters","Pints"):
            return input * 1.3333333333333333
        case ("Liters","Gallons"):
            return input * 0.26417205393700787
        case ("Cups","Milliliters"):
            return input * 236.58823659
        case ("Cups","Liters"):
            return input / 4.54609177
        case ("Cups","Pints"):
            return input / 1.7320508075629696
        case ("Cups","Gallons"):
            return input / 7.4635294118
        case ("Pints","Milliliters"):
            return input * 473.1764731
        case ("Pints","Liters"):
            return input * 1.3333333333333333
        case ("Pints","Cups"):
            return input * 2.3658823659
        case ("Pints","Gallons"):
            return input * 0.86602540378148142
        case ("Gallons","Milliliters"):
            return input * 3785.4117847
        case ("Gallons","Liters"):
            return input * 0.26417205393700787
        case ("Gallons","Cups"):
            return input * 7.4635294118
        case ("Gallons","Pints"):
            return input * 2.6417205393700787
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
                            }
                        }
                        .padding(.horizontal,16)
                        Form {
                            Section("Convert"){
                                HStack{
                                    TextField("Enter Value", value: $input,format: .number)
                                        .keyboardType(.decimalPad)
                                    Picker("", selection: $selectedInputUnit) {
                                        ForEach(conversion[selectedConversion] ?? [], id: \.self) {
                                            Text($0)
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                            
                            Section("To"){
                                HStack{
                                    Text("\(convert(from: selectedInputUnit, to: selectedOutputUnit, input: input),specifier: "%.2f")")
                                    Picker("", selection: $selectedOutputUnit) {
                                        ForEach(conversion[selectedConversion] ?? [], id: \.self) {
                                            Text($0)
                                        }
                                    }
                                }
                            }
                           
                        }
                    }
                    
                            
                          
                    
                    .navigationTitle("Convert")
                    .navigationBarTitleDisplayMode(.inline)
                    
                }
            }
}
