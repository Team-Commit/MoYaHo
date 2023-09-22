

import SwiftUI
import RiveRuntime

struct LoginView: View {
    var body: some View {
        ZStack {
            Text("hello")
            RiveViewModel(fileName: "login").view()
                .ignoresSafeArea()
                .frame(width: 1000, height: 800)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
