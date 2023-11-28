import SwiftUI
import CoreData



struct ContentView: View {
    
    // MARK:  - PROPERTIES
    
    @State private var showingInfoView: Bool = false
    
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
                
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                    // MARK:  REEL #1
                    
                    ZStack{
                        ReelView()
                        Image("gfx-bell")
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    HStack(alignment:.center, spacing: 0){
                        // MARK:  REEL #2
                        ZStack{
                            ReelView()
                            Image("gfx-seven")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        Spacer()
                        // MARK:  REEL #3
                        ZStack{
                            ReelView()
                            Image("gfx-cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK:  SPIN BUTTON
                    Button(action: {
                        print("Spin the reels")
                    }, label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    })
                    
                    
                    
                    
                }
                
                // MARK:  FOOTER
                
                Spacer()
                
                
                HStack {
                    // MARK:  BET 20
                    HStack(alignment:.center,spacing: 10) {
                        Button(action: {
                            print("Bet 20")
                        }, label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .modifier(BetNumberModifier())
                        })
                        .modifier(BetCapsuleModifier())
                        
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(0)
                            .modifier(CasinoChipModifier())
                    }
                    
                    // MARK:  BET 10
                    
                    HStack(alignment:.center,spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(1)
                            .modifier(CasinoChipModifier())
                        Button(action: {
                            print("Bet 10")
                        }, label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(.yellow)
                                .modifier(BetNumberModifier())
                        })
                        .modifier(BetCapsuleModifier())
                        
                        
                    }
                }
                
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
                    self.showingInfoView = true                }, label: {
                        Image(systemName: "info.circle")
                            .modifier(ButtonModifier())
                    })
            })
            
            .padding()
            .frame(maxWidth:720)
        }
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
    
}



// MARK:  - PREVIEW


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
