//
//  FormattingHelper.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-03-10.
//

import SwiftUI

extension Double {
    /// Formats a number as currency with commas (Rs. 100,000.00)
    func formattedCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return "Rs. \(formatter.string(from: NSNumber(value: self)) ?? "0.00")"
    }

    /// Formats a number as a percentage (7.50%)
    func formattedPercentage() -> String {
        return "\(String(format: "%.2f", self))%"
    }

    /// Formats a number as a time duration in years (5.2 years)
    func formattedYears() -> String {
        return "\(String(format: "%.1f", self)) years"
    }
}

extension String {
    /// Formats the string input dynamically with thousand separators.
    func formattedWithCommas() -> String {
        let rawText = self.numericOnly() // Remove non-numeric characters except "."
        
        guard let number = Double(rawText) else { return self }

        let isDecimal = self.contains(".")
        let formatted = NumberFormatter.localizedString(from: NSNumber(value: number), number: .decimal)

        return isDecimal && !formatted.contains(".") ? formatted + "." : formatted
    }

    /// Ensures only numeric input (removes non-numeric characters except ".").
    func numericOnly() -> String {
        let filtered = self.filter { "0123456789.".contains($0) }
        let decimalCount = filtered.filter { $0 == "." }.count

        return decimalCount > 1 ? String(filtered.dropLast()) : filtered
    }
}
