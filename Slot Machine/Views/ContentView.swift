import SwiftUI
import CoreData



struct ContentView: View {
    
    // MARK:  - PROPERTIES
    
    @State private var showingInfoView: Bool = false
    @State private var reels:Array = [0,1,2]
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    
    @State private var casinoChips20Opacity: Double = 0
    @State private var casinoChips10Opacity: Double = 1
    @State private var showingModal:Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false
    
    
    
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    let haptics = UINotificationFeedbackGenerator()
    
    
    // MARK:  FUNCTIONS
    
    func spinReels(){
        reels = reels.map({ _ in Int.random(in: 0...symbols.count - 1)})
        playSound(sound: "spin", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    func checkWinning(){
        if reels[0] == reels[1] && reels[0] == reels[2] && reels[1] == reels[2] {
            // PLAYER WINS
            playerWins()
            // NEW HIGHSCORE
            if coins > highScore {
                newHighScore()
            } else {
                playSound(sound: "win", type: "mp3")
            }
        } else {
            // PLAYER LOSES
            playerLoses()
        }
    }
    
    func playerWins(){
        coins += betAmount * 10
    }
    
    func newHighScore() {
        highScore = coins
        UserDefaults.standard.set(highScore, forKey: "HighScore")
        playSound(sound: "high-score", type: "mp3")
    }
    
    func playerLoses(){
        if coins >= betAmount {
            coins -= betAmount
        }
    }
    
    func activateBetAmount(bet amount: Int) {
        betAmount = amount
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    func isGameOver(){
        if coins <= 0 {
            // SHOW MODAL WINDOW
            showingModal = true
            playSound(sound: "game-over", type: "mp3")
        }
    }
    
    func resetGame() {
        UserDefaults.standard.setValue(0, forKey: "HighScore")
        highScore = 0
        coins = 100
        activateBetAmount(bet: 10)
        playSound(sound: "chimeout", type: "mp3")
    }
    
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
                        Text("Your\nCoins".uppercased())
                            .scoreLableStyle()
                            .multilineTextAlignment(.trailing)
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    Spacer()
                    HStack{
                        Text("\(highScore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        Text("Your\nScore".uppercased())
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
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration: Double.random(in: 0.5...0.7)), value: animatingSymbol)
                            .onAppear(perform: {
                                self.animatingSymbol.toggle()
                                playSound(sound: "riseup", type: "mp3")
                            })
                    }
                    HStack(alignment:.center, spacing: 0){
                        // MARK:  REEL #2
                        ZStack{
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingSymbol)
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }
                        Spacer()
                        // MARK:  REEL #3
                        ZStack{
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)), value: animatingSymbol)
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }
                        
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK:  SPIN BUTTON
                    Button(action: {
                        withAnimation {
                            self.animatingSymbol = false
                        }
                        self.spinReels()
                        withAnimation {
                                     self.animatingSymbol = true
                                   }
                        self.checkWinning()
                        self.isGameOver()
                        
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
                            activateBetAmount(bet: 20)
                            casinoChips20Opacity = 1
                            casinoChips10Opacity = 0
                        }, label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(casinoChips20Opacity == 1 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        })
                        .modifier(BetCapsuleModifier())
                        
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: casinoChips20Opacity == 1 ? 0 : 20)
                            .opacity(casinoChips20Opacity)
                            .modifier(CasinoChipModifier())
                    }
                    
                    // MARK:  BET 10
                    Spacer()
                    HStack(alignment:.center,spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: casinoChips10Opacity == 1 ? 0 : -20)
                            .opacity(casinoChips10Opacity)
                            .modifier(CasinoChipModifier())
                        Button(action: {
                            activateBetAmount(bet: 10)
                            casinoChips20Opacity = 0
                            casinoChips10Opacity = 1
                        }, label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(casinoChips10Opacity == 1 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        })
                        .modifier(BetCapsuleModifier())
                        
                        
                    }
                }
                
            }
            
            // MARK:  BUTTONS
            .overlay(alignment: .topLeading, content: {
                Button(action: {
                    self.resetGame()
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
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            
            // MARK:  POPUP
            if $showingModal.wrappedValue {
                ZStack {
                    Color("ColorBlack").edgesIgnoringSafeArea(.all)
                    // MODAL
                    VStack (spacing:0){
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight:72)
                            
                            Text("Bad luck! You lost allof your coins. \nLet's play again.")
                                .font(.system(.body,design: .rounded))
                                .foregroundColor(.gray)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .layoutPriority(1)
                            
                            Button(action: {
                                self.showingModal = false
                                self.animatingModal = false
                                self.activateBetAmount(bet: 10)
                                self.coins = 100
                            }, label: {
                                Text("New game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal,12)
                                    .padding(.vertical,8)
                                    .frame(minWidth: 128)
                                    .background {
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundStyle(Color("ColorPink"))
                                    }
                            })
                            
                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorBlack"), radius: 6, x: 0, y: 8)
                    .opacity($animatingModal.wrappedValue ? 1 : 0)
                    .offset(y: $animatingModal.wrappedValue ? 0 : -100)
                    .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0), value: self.animatingModal)
                    .onAppear {
                        self.animatingModal = true
                    }
                }
            }
            
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
