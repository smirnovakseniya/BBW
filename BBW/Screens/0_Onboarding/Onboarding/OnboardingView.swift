import SwiftUI

struct OnboardingContainerView<Model: OnboardingModelStatePotocol>: View {
    
    @ObservedObject var model: Model
    let intent: OnboardingIntentProtocol & OnboardingActionProtocol
    
    var body: some View {
        VStack {
            VStack {
                progressIndicator(for: model.currentData)
                    .padding(.top, 16)
                
                titleForData(for: model.currentData)
                
                viewForData(for: model.currentData)
                
                buttonForData(for: model.currentData, isDisabled: $model.isContinueDisabled)
                    .padding(.bottom, 40)
            }
            .padding(.horizontal, 16)
        }
        .background(
            backgroundImageName(for: model.currentData)
        )
        .ignoresSafeArea(.keyboard)
        .animation(.easeInOut, value: model.currentIndex)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    // MARK: Subviews
    
    @ViewBuilder
    private func progressIndicator(for data: OnboardingData) -> some View {
        if let index = data.index {
            HStack(spacing: 4) {
                ForEach(1...10, id: \.self) { i in
                    ZStack {
                        if i <= index {
                            Circle()
                                .fill(customGradient)
                            Text(i.description)
                                .foregroundColor(Asset.Colors.fff0Fa.swiftUIColor)
                        } else {
                            Circle()
                                .fill(Asset.Colors.fff0Fa.swiftUIColor)
                            Text(i.description)
                                .foregroundStyle(customGradient)
                        }
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func titleForData(for data: OnboardingData) -> some View {
        let title: String? = {
            switch data {
            case .welcome, .perfectLook, .finish, .girlIntro:
                return nil
            case let .name(model as Titled),
                let .weightAHeight(model as Titled),
                let .age(model as Titled),
                let .nationality(model as Titled),
                let .clothing(model as Titled),
                let .figure(model as Titled),
                let .bestPhoto(model as Titled),
                let .talkAbout(model as Titled),
                let .character(model as Titled),
                let .purposes(model as Titled):
                return model.title
            }
        }()
        
        let description: String? = {
            switch data {
            case .welcome, .name, .weightAHeight, .age, .clothing, .figure, .perfectLook, .talkAbout, .character, .purposes, .finish, .girlIntro:
                return nil
            case let .nationality(model as TitledDescription),
                let .bestPhoto(model as TitledDescription):
                return model.description
            }
        }()
        
        if title == nil, description == nil {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 8) {
                if let title {
                    Text(title)
                        .font(FontFamily.SFProRounded.semibold.swiftUIFont(size: 30))
                }
                
                if let description {
                    Text(description)
                        .font(FontFamily.SFProRounded.regular.swiftUIFont(size: 16))
                }
            }
            .padding(.top, 48)
            .padding(.bottom, 36)
            .foregroundColor(Asset.Colors._000000.swiftUIColor)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    private func viewForData(for data: OnboardingData) -> some View {
        switch data {
        case .welcome(let model):
            OnboardingWelcomeView(model: model)
        case .name(let model):
            OnboardingNameView(model: model) { name in
                intent.updateCommonData(for: .name(name))
            }
        case .weightAHeight(let model):
            OnboardingHeightNWeightView(model: model) { heightPickerValue in
                intent.updateCommonData(for: .height(heightPickerValue))
            } onWeightPickerValueChanged: { weightPickerValue in
                intent.updateCommonData(for: .weight(weightPickerValue))
            }
        case .age(let model):
            OnboardingAgeView(model: model) { agePickerValue in
                intent.updateCommonData(for: .age(agePickerValue))
            }
        case .nationality(let model):
            OnboardingNationalityView(model: model) { data in
                intent.updateCommonData(for: .nationality(data))
            }
        case .clothing(let model):
            OnboardingClothingView(model: model) { data in
                intent.updateCommonData(for: .clothing(data))
            }
        case .figure(let model):
            OnboardingFigureView(model: model) { data in
                intent.updateCommonData(for: .figure(data))
            }
        case .bestPhoto(let model):
            OnboardingBestPhotoView(model: model.photos) { data in
                intent.updateCommonData(for: .bestPhoto(data))
            }
        case .perfectLook(let model):
            OnboardingPerfectLookView(model: model, userData: intent.onboardingData)
        case .talkAbout(let model):
            OnboardingTalkAboutView(model: model) { data in
                intent.updateCommonData(for: .talkAbout(data))
            }
        case .character(let model):
            OnboardingCharacterView(model: model) { data in
                intent.updateCommonData(for: .character(data))
            }
        case .purposes(let model):
            OnboardingPurposesView(model: model)
        case .finish(let model):
            OnboardingFinishView(model: model)
        case .girlIntro(let model):
            OnboardingGirlsIntroView(model: model, name: intent.onboardingData.name)
        }
    }
    
    @ViewBuilder
    private func buttonForData(for data: OnboardingData, isDisabled: Binding<Bool>) -> some View {
        switch data {
        case let .welcome(model as TitledButton),
            let .weightAHeight(model as TitledButton),
            let .age(model as TitledButton),
            let .bestPhoto(model as TitledButton),
            let .perfectLook(model as TitledButton),
            let .character(model as TitledButton),
            let .purposes(model as TitledButton),
            let .finish(model as TitledButton),
            let .girlIntro(model as TitledButton):
            OnboardingButton(
                isDisabled: false,
                text: model.buttonTitle
            ) {
                intent.nextStep()
            }
        case .name(let model):
            VStack(spacing: 8) {
                OnboardingButton(
                    isDisabled: isDisabled.wrappedValue,
                    text: model.buttonTitle
                ) {
                    intent.nextStep()
                }
                
                GradientButton(
                    text: model.randomButtonTitle,
                    image: Asset.Assets.icOnboardingRandom.name
                ) {
                    intent.handleRandomName()
                }
            }
        case .nationality, .clothing, .figure:
            EmptyView()
        case let .talkAbout(model as TitledButton):
            OnboardingButton(
                isDisabled: isDisabled.wrappedValue,
                text: model.buttonTitle
            ) {
                intent.nextStep()
            }
        }
    }
    
    @ViewBuilder
    private func backgroundImageName(for data: OnboardingData) -> some View {
        switch data {
        case let .welcome(model as BackgroundImage),
            let .perfectLook(model as BackgroundImage),
            let .finish(model as BackgroundImage):
            Image(model.backgroundImage)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        case .name, .weightAHeight, .age, .nationality, .clothing, .figure, .bestPhoto, .talkAbout, .character, .purposes:
            EmptyView()
        case .girlIntro:
            ZStack(alignment: .bottom) {
                Image(intent.prepareGirlsPhoto())
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                CircularView()
            }
           
        }
    }
}
