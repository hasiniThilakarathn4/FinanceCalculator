//
//  HideKeyboardExtension.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-03-07.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
