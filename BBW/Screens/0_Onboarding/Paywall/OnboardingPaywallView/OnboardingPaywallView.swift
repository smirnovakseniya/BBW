import SwiftUI

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
                .font(.sfProRoundedSemibold(size: 32))
                .foregroundColor(._000000)
                .padding(.bottom, 16)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(model.data.features, id: \.id) { item in
                    HStack(spacing: 10) {
                        Text(item.emoji)
                        Text(item.title)
                    }
                    .font(.sfProRoundedMedium(size: 20))
                    .foregroundColor(._000000)
                }
            }
            .padding(.bottom, 28)
            
            HStack(spacing: 0) {
                OnboardingPaywallButtonView(
                    isSelectedType: isSelectedType,
                    data: model.data.leftButton,
                    price: model.prices.monthlyPrice
                )
                OnboardingPaywallButtonView(
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
                    .font(.sfProRoundedRegular(size: 14))
                    .foregroundColor(._000000)
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
                            intent.onTermsOfUseButtonTapped()
                        }
                    Text(model.data.moreInfoViewData.privacyPolice)
                        .onTapGesture {
                            intent.onPrivacyPolicyButtonTapped()
                        }
                    Text(model.data.moreInfoViewData.restore)
                        .onTapGesture {
                            intent.onRestoreButtonTapped()
                        }
                }
                    .underline()
                    .font(.sfProRoundedRegular(size: 12))
                    .foregroundColor(._000000.opacity(0.6))
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
                        .FFF_0_FA.opacity(0),
                        .FFF_0_FA.opacity(0.8),
                        .FFF_0_FA
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .padding(.top, 200)
            }
        )
        .navigationBarBackButtonHidden()
        .overlay(
            Button(action: {
                intent.onDismiss()
            }) {
                Image(systemName: "multiply")
                    .resizable()
                    .foregroundColor(.FFF_0_FA)
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
        .onDisappear {
            intent.viewOnDisappear()
        }
    }
}
