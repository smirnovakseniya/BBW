import SwiftUI
import RouterModifier

struct OnboardingPaywallView<Model: OnboardingPaywallModelStatePotocol>: View {
    
    @ObservedObject var model: Model
    let intent: (OnboardingPaywallIntentProtocol & OnboardingPaywallActionProtocol & MoreInfoActionProtocol)
    
    private var isSelectedType: Binding<OnboardingPaywallButtonType> {
        Binding(
            get: {
                model.isSelectedProductId == .month ? .left : .right
            },
            set: { newValue in
                model.isSelectedProductId = newValue == .left ? .month : .week
            }
        )
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            Text(model.data.title)
                .font(FontFamily.SFProRounded.semibold.swiftUIFont(size: 32))
                .foregroundColor(Asset.Colors._000000.swiftUIColor)
                .padding(.bottom, 16)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(model.data.features, id: \.id) { item in
                    HStack(spacing: 10) {
                        Text(item.emoji)
                        Text(item.title)
                    }
                    .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 20))
                    .foregroundColor(Asset.Colors._000000.swiftUIColor)
                }
            }
            .padding(.bottom, 28)
            
            HStack(spacing: 0) {
                PaywallButtonView(
                    isSelectedType: isSelectedType,
                    data: model.data.leftButton,
                    price: model.prices.monthlyPrice
                )
                PaywallButtonView(
                    isSelectedType: isSelectedType,
                    data: model.data.rightButton,
                    price: model.prices.weeklyPrice
                )
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
            
            HStack(spacing: 4) {
                Image(Asset.Assets.icOnboardingPaywallClock.name)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .scaledToFill()
                Text(model.data.description)
                    .font(FontFamily.SFProRounded.regular.swiftUIFont(size: 14))
                    .foregroundColor(Asset.Colors._000000.swiftUIColor)
            }
            .padding(.bottom, 8)
            
            OnboardingButton(
                isDisabled: false,
                text: model.data.buttonTitle
            ) {
                intent.onPurchaseButtonTap()
            }
            .padding(.bottom, 40)
            .overlay(
                HStack(spacing: 32) {
                    Text(model.data.moreInfoViewData.termsOfUse)
                        .onTapGesture {
                            intent.onTermsOfUseButtonTappred()
                        }
                    Text(model.data.moreInfoViewData.privacyPolice)
                        .onTapGesture {
                            intent.onPrivacyPoliceButtonTappred()
                        }
                    Text(model.data.moreInfoViewData.restore)
                        .onTapGesture {
                            intent.onRestoreButtonTappred()
                        }
                }
                    .underline()
                    .font(FontFamily.SFProRounded.regular.swiftUIFont(size: 12))
                    .foregroundColor(Asset.Colors._000000.swiftUIColor.opacity(0.6))
                    .offset(y: 68 / 2)
                    .frame(maxWidth: .infinity)
            )
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(
            ZStack {
                Image(model.girlImageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                LinearGradient(
                    colors: [
                        Asset.Colors.fff0Fa.swiftUIColor.opacity(0),
                        Asset.Colors.fff0Fa.swiftUIColor.opacity(0.8),
                        Asset.Colors.fff0Fa.swiftUIColor
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .padding(.top, 120)
            }
        )
        .navigationBarBackButtonHidden()
        .overlay(
            Button(action: {
                intent.onDismiss()
            }) {
                Image(systemName: "multiply")
                    .resizable()
                    .foregroundColor(Asset.Colors.fff0Fa.swiftUIColor)
                    .frame(width: 13, height: 13)
                    .scaledToFit()
            }
                .frame(width: 32, height: 32)
                .padding(.leading, 12)
                .padding(.top, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        )
        
        .onAppear {
            intent.viewOnAppear()
        }
    }
}

//MARK: Subviews

private struct PaywallButtonView: View {
    @Binding var isSelectedType: OnboardingPaywallButtonType
    let data: OnboardingPaywallButtonData
    let price: OnboardingPaywallPricePeriodData
    
    private var isSelected: Bool {
        isSelectedType == data.type
    }
    
    private var cornerShape: some InsettableShape {
        RoundedCorner(radius: 20, corners: data.type == .left ? [.topLeft, .bottomLeft] : [.topRight, .bottomRight])
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Text(data.title)
                .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 14))
                .foregroundColor(Asset.Colors._000000.swiftUIColor.opacity(0.7))
            Text(price.price)
                .font(FontFamily.SFProRounded.semibold.swiftUIFont(size: 26))
                .foregroundColor(Asset.Colors._000000.swiftUIColor)
            Text(price.pricePerDay)
                .font(FontFamily.SFProRounded.regular.swiftUIFont(size: 14))
                .foregroundColor(Asset.Colors._000000.swiftUIColor.opacity(0.4))
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(
            BlurView(
                colorTint: isSelected ? Asset.Colors.e958Bf.color : Asset.Colors.fff0Fa.color,
                colorTintAlpha: 0.2,
                blurRadius: 10,
                scale: 1
            )
            .clipShape(cornerShape)
        )
        .overlay(
            cornerShape
                .stroke(customGradient, lineWidth: isSelected ? 1 : 0)
        )
        .onTapGesture {
            isSelectedType = data.type
        }
    }
}
