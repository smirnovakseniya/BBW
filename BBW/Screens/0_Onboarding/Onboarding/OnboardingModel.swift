import SwiftUI

final class OnboardingModel: OnboardingModelStatePotocol {
    @Published var currentIndex: Int = 0
    @Published var inputData: [OnboardingData] = [
//        .welcome(.init(
//            title1: L10n.onboardingWelcomeTitle1,
//            title2: L10n.onboardingWelcomeTitle2,
//            title3: L10n.onboardingWelcomeTitle3.capitalized,
//            backgroundImage: Asset.Assets.imgOnboardingWelcomeBack.name,
//            buttonTitle: L10n.onboardingWelcomeButton
//        )),
//        .name(.init(
//            index: 1,
//            title: L10n.onboardingNameTitle,
//            placeholder: L10n.onboardingNamePlaceholder,
//            text: "",
//            buttonTitle: L10n.onboardingNameButton,
//            randomButtonTitle: L10n.onboardingNameRandomButton
//        )),
//        .weightAHeight(.init(
//            index: 2,
//            title: L10n.onboardingHeightNWeightTitle,
//            heightPickerData: .init(
//                title: L10n.onboardingHeightNWeightHeightTitle,
//                minValue: 150,
//                maxValue: 210,
//                step: 1,
//                defaultValue: 165
//            ),
//            weightPickerData: .init(
//                title: L10n.onboardingHeightNWeightWeightTitle,
//                minValue: 80,
//                maxValue: 400,
//                step: 5,
//                defaultValue: 90
//            ),
//            buttonTitle: L10n.onboardingNameButton
//        )),
//        .age(.init(
//            index: 3,
//            title: L10n.onboardingAgeTitle,
//            agePickerData: .init(
//                title: L10n.onboardingAgePickerTitle,
//                minValue: 16,
//                maxValue: 100,
//                step: 1,
//                defaultValue: 21
//            ),
//            buttonTitle: L10n.onboardingAgeButton
//        )),
//        .nationality(.init(
//            index: 4,
//            title: L10n.onboardingNationalityTitle,
//            description: L10n.onboardingNationalityDescription,
//            list: [
//                .init(
//                    type: .european,
//                    image: Asset.Assets.imgOnboardingNationalityEuropean.name,
//                    title: L10n.onboardingNationalityEuropean
//                ),
//                .init(
//                    type: .asian,
//                    image: Asset.Assets.imgOnboardingNationalityAsian.name,
//                    title: L10n.onboardingNationalityAsian
//                ),
//                .init(
//                    type: .afro,
//                    image: Asset.Assets.imgOnboardingNationalityAfro.name,
//                    title: L10n.onboardingNationalityAfro
//                ),
//                .init(
//                    type: .arab,
//                    image: Asset.Assets.imgOnboardingNationalityArab.name,
//                    title: L10n.onboardingNationalityArab
//                ),
//                .init(
//                    type: .latina,
//                    image: Asset.Assets.imgOnboardingNationalityLatina.name,
//                    title: L10n.onboardingNationalityLatina
//                ),
//                .init(
//                    type: .indian,
//                    image: Asset.Assets.imgOnboardingNationalityIndian.name,
//                    title: L10n.onboardingNationalityIndian
//                )
//            ]
//        )),
//        .clothing(.init(
//            index: 5,
//            title: L10n.onboardingClothingTitle,
//            list: [
//                .init(
//                    type: .casual,
//                    image: Asset.Assets.imgOnboardingClothingCasual.name,
//                    title: L10n.onboardingClothingCasual
//                ),
//                .init(
//                    type: .sport,
//                    image: Asset.Assets.imgOnboardingClothingSport.name,
//                    title: L10n.onboardingClothingSport
//                ),
//                .init(
//                    type: .office,
//                    image: Asset.Assets.imgOnboardingClothingOffice.name,
//                    title: L10n.onboardingClothingOffice
//                ),
//                .init(
//                    type: .feminine,
//                    image: Asset.Assets.imgOnboardingClothingFeminine.name,
//                    title: L10n.onboardingClothingFeminine
//                ),
//                .init(
//                    type: .uniform,
//                    image: Asset.Assets.imgOnboardingClothingUniform.name,
//                    title: L10n.onboardingClothingUniform
//                ),
//                .init(
//                    type: .underwear,
//                    image: Asset.Assets.imgOnboardingClothingUnderwear.name,
//                    title: L10n.onboardingClothingUnderwear
//                )
//            ]
//        )),
//        .figure(.init(
//            index: 6,
//            title: L10n.onboardingFigureTitle,
//            list: [
//                .init(
//                    type: .conceals,
//                    image: Asset.Assets.imgOnboardingFigureConceals.name,
//                    title: L10n.onboardingFigureConceals
//                ),
//                .init(
//                    type: .emphasizes,
//                    image: Asset.Assets.imgOnboardingFigureEmphasizes.name,
//                    title: L10n.onboardingFigureEmphasizes
//                )
//            ]
//        )),
//        .bestPhoto(.init(
//            index: 7,
//            title: L10n.onboardingBestPhotoTitle,
//            description: L10n.onboardingBestPhotoDescription,
//            photos: [
//                .init(index: 0, image: Asset.Assets.imgOnboardingBestPhoto0.name),
//                .init(index: 1, image: Asset.Assets.imgOnboardingBestPhoto1.name),
//                .init(index: 2, image: Asset.Assets.imgOnboardingBestPhoto2.name),
//                .init(index: 3, image: Asset.Assets.imgOnboardingBestPhoto3.name),
//                .init(index: 4, image: Asset.Assets.imgOnboardingBestPhoto4.name),
//                .init(index: 5, image: Asset.Assets.imgOnboardingBestPhoto5.name)
//            ],
//            buttonTitle: L10n.onboardingBestPhotoButton
//        )),
//        .perfectLook(.init(
//            title: L10n.onboardingPerfectLookTitle,
//            backgroundImage: Asset.Assets.imgOnboardingPerfectLook.name,
//            ageTitle: L10n.onboardingPerfectLookYears,
//            weightTitle: L10n.onboardingPerfectLookWeight,
//            progressViewTitle: [
//                L10n.onboardingPerfectLookProgressView1,
//                L10n.onboardingPerfectLookProgressView2,
//                L10n.onboardingPerfectLookProgressView3
//            ],
//            buttonTitle: L10n.onboardingPerfectLookButton
//        )),
        .talkAbout(.init(
            index: 8,
            title: L10n.onboardingTalkAboutTitle,
            list: [
                .init(type: .justTalkin, title: L10n.onboardingTalkAboutCell1, image: "👋"),
                .init(type: .makeFriends, title: L10n.onboardingTalkAboutCell2, image: "🤝"),
                .init(type: .confidence, title: L10n.onboardingTalkAboutCell3, image: "💪"),
                .init(type: .romance, title: L10n.onboardingTalkAboutCell4, image: "🥰"),
                .init(type: .relationship, title: L10n.onboardingTalkAboutCell5, image: "👩‍❤️‍💋‍👨"),
                .init(type: .flirt, title: L10n.onboardingTalkAboutCell6, image: "🔥"),
                .init(type: .rolePlaying, title: L10n.onboardingTalkAboutCell7, image: "🍑"),
                .init(type: .psychology, title: L10n.onboardingTalkAboutCell8, image: "📚"),
                .init(type: .support, title: L10n.onboardingTalkAboutCell9, image: "🤗"),
                .init(type: .problemsInLife, title: L10n.onboardingTalkAboutCell10, image: "🚫"),
            ],
            buttonTitle: L10n.onboardingTalkAboutButton
        ))
    ]
    
    @Published var isContinueDisabled: Bool = true
}

extension OnboardingModel: OnboardingModelActionsProtocol {
    
    func configure(with inputData: OnboardingInputData) {}
    
    func moveToNextStep() {
        isContinueDisabled = false
        
        if currentIndex < inputData.count - 1 {
            withAnimation {
                currentIndex += 1
            }
        } else {
            print("Onboarding completed")
        }}
    
    func completeOnboarding() {
        
    }
    
    func handleIsDisabledButton(_ isDisabled: Bool) {
        isContinueDisabled = isDisabled
    }
    
    func setRandomName() {
        let name = generateRandomName()
        updateNameText(with: name)
        isContinueDisabled = name.isEmpty
    }
    
    
}

private extension OnboardingModel {
    
    func updateNameText(with newText: String) {
        if let index = inputData.firstIndex(where: {
            if case .name = $0 { return true }
            return false
        }) {
            if case var .name(data) = inputData[index] {
                inputData[index] = .name(data.updateText(newText))
            }
        }
    }
    func generateRandomName() -> String {
        [
            "Luna",
            "Stella",
            "Jasmine",
            "Serena",
            "Bianca",
            "Curvy",
            "Daisy",
            "Valentina",
            "Ruby",
            "Amara"
        ].randomElement() ?? ""
    }
}
