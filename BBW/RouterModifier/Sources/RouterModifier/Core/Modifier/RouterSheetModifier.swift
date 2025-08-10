//
//  RouterSheetModifier.swift
//  RouterModifier
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

struct RouterSheetModifier<ScreenView, ScreenType> where ScreenView: View, ScreenType: RouterScreenProtocol {

    // MARK: Public

    var isFullScreenCover: Bool = false
    let publisher: AnyPublisher<ScreenType, Never>
    var screen: (ScreenType) -> ScreenView
    let onDismiss: ((ScreenType) -> Void)?

    // MARK: Private
    
    @State private var screenType: ScreenType?

	private var isPresented: Binding<Bool> { 
		Binding<Bool>(
			get: { screenType != nil },
			set: {
				if !$0 {
					if let type = screenType { onDismiss?(type) }
					screenType = nil
				}
			})
	}

	@ViewBuilder
	private var screenContent: some View {
		if let type = screenType {
			screen(type)
		} else {
			EmptyView()
		}
	}
}

// MARK: - ViewModifier

extension RouterSheetModifier: ViewModifier {

    func body(content: Content) -> some View {
#if os(iOS)
        if isFullScreenCover {
            content
                .onReceive(publisher) { screenType = $0 }
                .fullScreenCover(
                    isPresented: isPresented,
                    content: { screenContent }
                )
        } else {
            content
                .onReceive(publisher) { screenType = $0 }
                .sheet(
                    isPresented: isPresented,
                    content: { screenContent }
                )
        }
#else
		content
			.onReceive(publisher) { screenType = $0 }
			.sheet(
				isPresented: isPresented,
				content: { screenContent })
#endif
    }
}
