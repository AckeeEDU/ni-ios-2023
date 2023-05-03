//
//  AssertSnapshot.swift
//  TVShowsTests
//
//  Created by Igor Rosocha on 22.03.2023.
//

import SnapshotTesting
import SwiftUI
import XCTest

let devices = [
    ViewImageConfig.iPhoneXsMax,
    .iPhone8Plus,
    .iPadPro12_9,
]

/// Checks if the given view matches the image references on the disk.
///
/// - Parameters:
///    - layout: The size constraint for a snapshot (similar to PreviewLayout). Leave empty if you want to run snapshots on preselected devices.
///    - perceptualPrecision: Precision that is used to match snapshots. Several attempts showed that 0.93 is the magic number
///                           that makes sure that most snapshots from Apple Silicon match snapshots from Intel
public func AssertSnapshot<View: SwiftUI.View>(
    _ view: View,
    layout: SwiftUISnapshotLayout? = nil,
    record: Bool = false,
    line: UInt = #line,
    file: StaticString = #file,
    function: String = #function,
    perceptualPrecision: Float = 0.93
) {
    let strategies: [Snapshotting<View, UIImage>]
    if let layout = layout {
        strategies = imageStrategies(
            layout: layout,
            perceptualPrecision: perceptualPrecision
        )
    } else {
        strategies = devices.flatMap {
            imageStrategies(
                layout: .device(config: $0),
                perceptualPrecision: perceptualPrecision
            )
        }
    }

    assertSnapshots(
        matching: view,
        as: strategies,
        record: record,
        file: file,
        testName: function,
        line: line
    )
}

// MARK: - Helpers

private func imageStrategies<View: SwiftUI.View>(
    layout: SwiftUISnapshotLayout,
    perceptualPrecision: Float
) -> [Snapshotting<View, UIImage>] {
    [
        .image(
            drawHierarchyInKeyWindow: false,
            perceptualPrecision: perceptualPrecision,
            layout: layout,
            traits: .init(userInterfaceStyle: .light)
        ),
        .image(
            drawHierarchyInKeyWindow: false,
            perceptualPrecision: perceptualPrecision,
            layout: layout,
            traits: .init(userInterfaceStyle: .dark)
        ),
    ]
}
