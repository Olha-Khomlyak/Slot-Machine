import SwiftUI
import CoreData


// MARK:  - PROPERTIES

struct ContentView: View {
    
    
    // MARK:  BODY
    var body: some View {
        ZStack {
            // MARK:  BACKGROUND
            
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {                // MARK:  HEADER
                LogoView()
                
                Spacer()
                
                // MARK:  SCORE
                
                HStack {
                    HStack{
                        Text("Your\nscore".uppercased())
                            .scoreLableStyle()
                            .multilineTextAlignment(.trailing)
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    Spacer()
                    HStack{
                        Text("200")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        Text("Your\nscore".uppercased())
                            .scoreLableStyle()
                            .multilineTextAlignment(.leading)
                    }
                    .modifier(ScoreContainerModifier())
                }
                // MARK:  SLOT MACHINE
                // MARK:  FOOTER
                
                Spacer()
            }
            
            // MARK:  BUTTONS
            .overlay(alignment: .topLeading, content: {
                Button(action: {
                    print("Reset the game")
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                        .modifier(ButtonModifier())
                })
            })
            .overlay(alignment: .topTrailing, content: {
                Button(action: {
                    print("Info View")
                }, label: {
                    Image(systemName: "info.circle")
                        .modifier(ButtonModifier())
                })
            })
            
            .padding()
            .frame(maxWidth:720)
        }
    }
    
}



// MARK:  - PREVIEW


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
