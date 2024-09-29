//
//  HandTrackingController.swift
//  HoopMaster
//
//  Created by Victor-Silviu Maftei on 29/09/2024.
//
import SwiftUI
import ARKit
import Vision

struct HandTrackingController: UIViewControllerRepresentable {
    
    
    @Binding var handPosition: CGPoint
    @Binding var isTouched: Bool
    @Binding var targetPosition: CGPoint
    @Binding var showEndGameOverlay: Bool
    @Binding var showCameraTargetOverlay: Bool
    @Binding var targetsTouched: Int
    
    func makeUIViewController(context: Context) -> ARViewController {
        let viewController = ARViewController()
        viewController.handPosition = $handPosition
        viewController.isTouched = $isTouched
        viewController.targetPosition = $targetPosition
        viewController.showEndGameOverlay = $showEndGameOverlay
        viewController.showCameraTargetOverlay = $showCameraTargetOverlay
        viewController.targetsTouched = $targetsTouched
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
    }
}

