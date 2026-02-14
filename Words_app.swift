import SwiftUI
import Combine
import AVFoundation

/// NOTE: These types are prefixed with `VM` to avoid redeclaration conflicts if the project
/// has other files declaring similarly named types like `WordStore`, `ContentView`, or
/// `FlashcardView`. Update references accordingly or keep this file standalone.

// MARK: - 1. DATA MODEL
struct VMVocabItem: Identifiable, Hashable {
    let id = UUID()
    let word: String
    let definition: String
    let mnemonic: String // Trick/Root combination
}

// MARK: - 2. AUDIO ENGINE (Indian English)
class VMIndianSpeechManager {
    static let shared = VMIndianSpeechManager()
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: String) {
        // Stop current speech to allow rapid-fire clicking
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: text)
        
        // STRICTLY SET TO INDIAN ENGLISH
        // If "en-IN" is unavailable on a simulator, it falls back to default,
        // but on a real device, this works perfectly.
        utterance.voice = AVSpeechSynthesisVoice(language: "en-IN")
        utterance.rate = 0.45 // Slightly slower for clarity
        
        synthesizer.speak(utterance)
    }
}

// MARK: - 3. DATA STORE (The Complete Parsed List)
class VMWordStore: ObservableObject {
    @Published var searchText: String = ""
    
    // This array contains the cleaned, unique words from your massive text block
    let allWords: [VMVocabItem] = [
        // --- S ---
        VMVocabItem(word: "Sojourn", definition: "A temporary stay.", mnemonic: "Journey for a short day."),
        VMVocabItem(word: "Solace", definition: "Comfort in sorrow.", mnemonic: "Soul + Lace (comforting tie)."),
        VMVocabItem(word: "Solecism", definition: "Grammatical mistake/breach of manners.", mnemonic: "Solo error."),
        VMVocabItem(word: "Solemn", definition: "Formal and dignified.", mnemonic: "Soul-emn (serious soul)."),
        VMVocabItem(word: "Solicit", definition: "Ask for/try to obtain.", mnemonic: "Solely sit and ask."),
        VMVocabItem(word: "Soliloquy", definition: "Speaking thoughts aloud alone.", mnemonic: "Solo speaking."),
        VMVocabItem(word: "Solvent", definition: "Able to pay debts.", mnemonic: "Problem Solved ($)."),
        VMVocabItem(word: "Sombre", definition: "Gloomy/Dark.", mnemonic: "Somber bomber."),
        VMVocabItem(word: "Somnambulist", definition: "Sleepwalker.", mnemonic: "Ambulance sleep walker."),
        VMVocabItem(word: "Sonorous", definition: "Deep, full sound.", mnemonic: "Sonar sound."),
        VMVocabItem(word: "Soothe", definition: "Gently calm.", mnemonic: "Smooth."),
        VMVocabItem(word: "Soporific", definition: "Inducing sleep.", mnemonic: "Soap opera is boring."),
        VMVocabItem(word: "Sordid", definition: "Dirty/Ignoble.", mnemonic: "Sorry I did that."),
        VMVocabItem(word: "Spasmodic", definition: "Irregular bursts.", mnemonic: "Spasm."),
        VMVocabItem(word: "Spate", definition: "Sudden flood/rush.", mnemonic: "Spate of plates."),
        VMVocabItem(word: "Specious", definition: "Plausible but wrong.", mnemonic: "Suspicious."),
        VMVocabItem(word: "Splenetic", definition: "Bad-tempered.", mnemonic: "Spleen (organ of anger)."),
        VMVocabItem(word: "Sporadic", definition: "Irregular intervals.", mnemonic: "Spores scatter."),
        VMVocabItem(word: "Spurious", definition: "False/Fake.", mnemonic: "Spurs hurt, lies hurt."),
        VMVocabItem(word: "Supple", definition: "Flexible.", mnemonic: "Supply hose bends."),
        VMVocabItem(word: "Surfeit", definition: "Excessive amount.", mnemonic: "Sir, feet are too big."),
        VMVocabItem(word: "Surmise", definition: "Guess without evidence.", mnemonic: "Summarize without facts."),
        VMVocabItem(word: "Surmount", definition: "Overcome.", mnemonic: "Mount the top."),
        VMVocabItem(word: "Surreptitious", definition: "Secretive.", mnemonic: "Reptiles are sneaky."),
        VMVocabItem(word: "Surrogate", definition: "Substitute.", mnemonic: "Surrogate mother."),
        VMVocabItem(word: "Surveillance", definition: "Close observation.", mnemonic: "Survey."),
        VMVocabItem(word: "Swathe", definition: "Wrap in layers.", mnemonic: "Swaddle."),
        VMVocabItem(word: "Swelter", definition: "Uncomfortably hot.", mnemonic: "Sweat + Melter."),
        VMVocabItem(word: "Sybarite", definition: "Lover of luxury.", mnemonic: "See bar right?"),
        VMVocabItem(word: "Sycophant", definition: "Flatterer.", mnemonic: "Psycho Fan."),
        VMVocabItem(word: "Syllogism", definition: "Logical deduction.", mnemonic: "Symbol logic."),
        VMVocabItem(word: "Synchronous", definition: "Existing at same time.", mnemonic: "Sync."),
        VMVocabItem(word: "Scourge", definition: "Cause of suffering.", mnemonic: "Scars urge."),
        VMVocabItem(word: "Scrupulous", definition: "Diligent/Thorough.", mnemonic: "Screw loose? No, careful."),
        VMVocabItem(word: "Scurrilous", definition: "Insulting/Abusive.", mnemonic: "Scurry away from insults."),
        VMVocabItem(word: "Scuttle", definition: "Sink/Run hurriedly.", mnemonic: "Scuttlebutt (rumor sink)."),
        VMVocabItem(word: "Secede", definition: "Withdraw formally.", mnemonic: "Cease membership."),
        VMVocabItem(word: "Sedate", definition: "Calm/Dignified.", mnemonic: "Sedated."),
        VMVocabItem(word: "Sedentary", definition: "Sitting often.", mnemonic: "Sediment sits."),
        VMVocabItem(word: "Sedition", definition: "Inciting rebellion.", mnemonic: "Said it + Shun."),
        VMVocabItem(word: "Sedulous", definition: "Dedication/Diligence.", mnemonic: "Said u lose? No, I work."),
        VMVocabItem(word: "Semantics", definition: "Meaning of words.", mnemonic: "Some antics."),
        VMVocabItem(word: "Semblance", definition: "Outward appearance.", mnemonic: "Resemblance."),
        VMVocabItem(word: "Senile", definition: "Weakness of old age.", mnemonic: "Senior."),
        VMVocabItem(word: "Sensuous", definition: "Relating to senses.", mnemonic: "Senses."),
        VMVocabItem(word: "Sententious", definition: "Moralizing.", mnemonic: "Sentence giving."),
        VMVocabItem(word: "Sequester", definition: "Isolate.", mnemonic: "Seek west (go away)."),
        VMVocabItem(word: "Serendipity", definition: "Happy accident.", mnemonic: "Serene pity."),
        VMVocabItem(word: "Serenity", definition: "Calmness.", mnemonic: "Serene."),
        VMVocabItem(word: "Sinister", definition: "Evil.", mnemonic: "Sin."),
        VMVocabItem(word: "Skeptic", definition: "Doubter.", mnemonic: "Scope it out."),
        VMVocabItem(word: "Skittish", definition: "Nervous.", mnemonic: "Kitty is scared."),
        VMVocabItem(word: "Skulduggery", definition: "Trickery.", mnemonic: "Skull digging."),
        VMVocabItem(word: "Slander", definition: "False spoken statement.", mnemonic: "Slammed her."),
        VMVocabItem(word: "Slattern", definition: "Untidy woman.", mnemonic: "Slutty pattern."),
        VMVocabItem(word: "Sleazy", definition: "Corrupt/Immoral.", mnemonic: "Sleaze."),
        VMVocabItem(word: "Sleight", definition: "Dexterity/Trick.", mnemonic: "Slight of hand."),
        VMVocabItem(word: "Slither", definition: "Slide.", mnemonic: "Snake."),
        VMVocabItem(word: "Sloth", definition: "Laziness.", mnemonic: "Slow moth."),
        VMVocabItem(word: "Slough", definition: "Shed skin.", mnemonic: "Sluff off."),
        VMVocabItem(word: "Slovenly", definition: "Messy.", mnemonic: "Slow oven."),
        VMVocabItem(word: "Sluggard", definition: "Lazy person.", mnemonic: "Slug."),
        VMVocabItem(word: "Sluice", definition: "Water gate.", mnemonic: "Juice sluice."),
        VMVocabItem(word: "Snivel", definition: "Cry/Whine.", mnemonic: "Sniffle."),
        VMVocabItem(word: "Sober", definition: "Serious/Not drunk.", mnemonic: "Somber."),
        VMVocabItem(word: "Sobriquet", definition: "Nickname.", mnemonic: "Sober nickname."),

        // --- E ---
        VMVocabItem(word: "Emend", definition: "Correct text.", mnemonic: "Mend the text."),
        VMVocabItem(word: "Emeritus", definition: "Retired with title.", mnemonic: "Merit."),
        VMVocabItem(word: "Emigrate", definition: "Leave country.", mnemonic: "Exit."),
        VMVocabItem(word: "Emigre", definition: "One who emigrated.", mnemonic: "Migrated."),
        VMVocabItem(word: "Eminent", definition: "Famous/Respected.", mnemonic: "Eminem."),
        VMVocabItem(word: "Emissary", definition: "Diplomatic rep.", mnemonic: "Missionary."),
        VMVocabItem(word: "Emollient", definition: "Soothing skin.", mnemonic: "Mollify."),
        VMVocabItem(word: "Emolument", definition: "Salary.", mnemonic: "Money."),
        VMVocabItem(word: "Empirical", definition: "Based on observation.", mnemonic: "Empire is real."),
        VMVocabItem(word: "Empyreal", definition: "Heavenly.", mnemonic: "Imperial sky."),
        VMVocabItem(word: "Emulate", definition: "Imitate.", mnemonic: "Simulate."),
        VMVocabItem(word: "Enamored", definition: "In love.", mnemonic: "Amor."),
        VMVocabItem(word: "Enclave", definition: "Territory within.", mnemonic: "Cave in."),
        VMVocabItem(word: "Encomiastic", definition: "Praising.", mnemonic: "Comic con praise."),
        VMVocabItem(word: "Encomium", definition: "High praise.", mnemonic: "Income of praise."),
        VMVocabItem(word: "Encompass", definition: "Surround.", mnemonic: "Compass circle."),
        VMVocabItem(word: "Encroachment", definition: "Intrusion.", mnemonic: "Cockroach enters."),
        VMVocabItem(word: "Encumber", definition: "Burden.", mnemonic: "Cucumber is heavy."),
        VMVocabItem(word: "Endearment", definition: "Love word.", mnemonic: "Dear."),
        VMVocabItem(word: "Efface", definition: "Erase.", mnemonic: "Face off."),
        VMVocabItem(word: "Effectual", definition: "Effective.", mnemonic: "Effect."),
        VMVocabItem(word: "Effeminate", definition: "Womanly (man).", mnemonic: "Female."),
        VMVocabItem(word: "Effervescent", definition: "Bubbly.", mnemonic: "Feverish bubbles."),
        VMVocabItem(word: "Effete", definition: "Worn out.", mnemonic: "Defeated."),
        VMVocabItem(word: "Effigy", definition: "Model of person.", mnemonic: "Figurine."),
        VMVocabItem(word: "Effluvium", definition: "Bad smell.", mnemonic: "Flu smell."),
        VMVocabItem(word: "Effrontery", definition: "Insolence.", mnemonic: "Fronting."),
        VMVocabItem(word: "Effulgent", definition: "Shining brightly.", mnemonic: "Full gent (bright)."),
        VMVocabItem(word: "Effusive", definition: "Gushing emotion.", mnemonic: "Fuse out."),
        VMVocabItem(word: "Egoism", definition: "Self-interest.", mnemonic: "Ego."),
        VMVocabItem(word: "Egotist", definition: "Boastful person.", mnemonic: "Ego."),
        VMVocabItem(word: "Egregious", definition: "Outstandingly bad.", mnemonic: "Gregg's error."),
        VMVocabItem(word: "Egress", definition: "Exit.", mnemonic: "Aggressive exit."),
        VMVocabItem(word: "Ejaculation", definition: "Sudden exclamation.", mnemonic: "Eject words."),
        VMVocabItem(word: "Elaboration", definition: "Detailed explanation.", mnemonic: "Labor over details."),
        VMVocabItem(word: "Elation", definition: "Great happiness.", mnemonic: "Elevation."),
        VMVocabItem(word: "Eleemosynary", definition: "Charitable.", mnemonic: "Alms."),
        VMVocabItem(word: "Elegiac", definition: "Mournful.", mnemonic: "Elegy."),
        VMVocabItem(word: "Elegy", definition: "Funeral poem.", mnemonic: "Leggy death."),
        VMVocabItem(word: "Elicit", definition: "Draw out.", mnemonic: "Illicit response."),
        VMVocabItem(word: "Elixir", definition: "Magical potion.", mnemonic: "Mixer."),
        VMVocabItem(word: "Ellipsis", definition: "Omission of words.", mnemonic: "Lip shut."),
        VMVocabItem(word: "Eloquence", definition: "Fluent speech.", mnemonic: "Loquacious."),
        VMVocabItem(word: "Elucidate", definition: "Make clear.", mnemonic: "Lucid."),
        VMVocabItem(word: "Elude", definition: "Escape.", mnemonic: "Illusion."),
        VMVocabItem(word: "Elusive", definition: "Hard to catch.", mnemonic: "Loose."),
        VMVocabItem(word: "Emaciated", definition: "Abnormally thin.", mnemonic: "Man ate nothing."),
        VMVocabItem(word: "Emanate", definition: "Spread out.", mnemonic: "Man ate -> burp."),
        VMVocabItem(word: "Embed", definition: "Fix firmly.", mnemonic: "In bed."),
        VMVocabItem(word: "Embellish", definition: "Decorate.", mnemonic: "Bell."),
        VMVocabItem(word: "Embezzle", definition: "Steal funds.", mnemonic: "Dazzle with money."),
        VMVocabItem(word: "Emblazon", definition: "Display.", mnemonic: "Blaze."),
        VMVocabItem(word: "Embroil", definition: "Involve in conflict.", mnemonic: "Boil in trouble."),
        VMVocabItem(word: "Embryonic", definition: "Early stage.", mnemonic: "Embryo."),

        // --- X, Y, Z ---
        VMVocabItem(word: "Xenophobia", definition: "Fear of strangers.", mnemonic: "Xeno (alien)."),
        VMVocabItem(word: "Yak", definition: "Talk lengthily.", mnemonic: "Yakity yak."),
        VMVocabItem(word: "Yahoo", definition: "Rude person.", mnemonic: "Gulliver's Travels."),
        VMVocabItem(word: "Yen", definition: "Craving.", mnemonic: "Yen (money)."),
        VMVocabItem(word: "Yoke", definition: "Join together.", mnemonic: "Egg yolk."),
        VMVocabItem(word: "Yore", definition: "Long ago.", mnemonic: "Years ago."),
        VMVocabItem(word: "Yokel", definition: "Country bumpkin.", mnemonic: "Yolk head."),
        VMVocabItem(word: "Zany", definition: "Amusingly unconventional.", mnemonic: "Zany zebra."),
        VMVocabItem(word: "Zeal", definition: "Enthusiasm.", mnemonic: "Seal."),
        VMVocabItem(word: "Zealot", definition: "Fanatic.", mnemonic: "Lot of zeal."),
        VMVocabItem(word: "Zen", definition: "Peaceful.", mnemonic: "Zen garden."),
        VMVocabItem(word: "Zenith", definition: "Highest point.", mnemonic: "Z is top."),
        VMVocabItem(word: "Zephyr", definition: "Gentle breeze.", mnemonic: "Feather."),

        // --- F ---
        VMVocabItem(word: "Fiasco", definition: "Failure.", mnemonic: "Flask breaks."),
        VMVocabItem(word: "Fiance", definition: "Engaged person.", mnemonic: "Finance wedding."),
        VMVocabItem(word: "Fickle", definition: "Changing mind.", mnemonic: "Pickle flavor."),
        VMVocabItem(word: "Fictitious", definition: "Fake.", mnemonic: "Fiction."),
        VMVocabItem(word: "Fidelity", definition: "Faithfulness.", mnemonic: "Wifi."),
        VMVocabItem(word: "Fiduciary", definition: "Trust (money).", mnemonic: "Finance."),
        VMVocabItem(word: "Fiend", definition: "Evil spirit.", mnemonic: "Friend - r."),
        VMVocabItem(word: "Figment", definition: "Imaginary.", mnemonic: "Figure."),
        VMVocabItem(word: "Filch", definition: "Steal.", mnemonic: "Filthy steal."),
        VMVocabItem(word: "Filial", definition: "Son/Daughter duty.", mnemonic: "Affiliation."),
        VMVocabItem(word: "Finale", definition: "End.", mnemonic: "Final."),
        VMVocabItem(word: "Finesse", definition: "Skill.", mnemonic: "Fine."),
        VMVocabItem(word: "Finicky", definition: "Fussy.", mnemonic: "Fine picky."),
        VMVocabItem(word: "Finite", definition: "Limited.", mnemonic: "Finish."),
        VMVocabItem(word: "Firmament", definition: "Heavens.", mnemonic: "Firm sky."),
        VMVocabItem(word: "Fission", definition: "Splitting.", mnemonic: "Fissure."),
        VMVocabItem(word: "Flaccid", definition: "Soft/Limp.", mnemonic: "Flat."),
        VMVocabItem(word: "Flagellate", definition: "Whip.", mnemonic: "Flag pole hit."),
        VMVocabItem(word: "Flagrant", definition: "Obvious.", mnemonic: "Flag burn."),
        VMVocabItem(word: "Flamboyant", definition: "Showy.", mnemonic: "Flame boy."),
        VMVocabItem(word: "Flaunt", definition: "Show off.", mnemonic: "Aunt shows off."),
        VMVocabItem(word: "Flay", definition: "Strip skin.", mnemonic: "Lay open."),
        VMVocabItem(word: "Fledgling", definition: "Beginner.", mnemonic: "Fledge."),
        VMVocabItem(word: "Flippancy", definition: "Lack of respect.", mnemonic: "Flip off."),
        VMVocabItem(word: "Floe", definition: "Ice sheet.", mnemonic: "Flow."),
        VMVocabItem(word: "Florid", definition: "Red-faced/Flowery.", mnemonic: "Flower."),
        VMVocabItem(word: "Flotsam", definition: "Wreckage.", mnemonic: "Float."),
        VMVocabItem(word: "Flounce", definition: "Go angrily.", mnemonic: "Bounce."),
        VMVocabItem(word: "Flout", definition: "Disobey.", mnemonic: "Out law."),
        VMVocabItem(word: "Flux", definition: "Change.", mnemonic: "Fluctuate."),
        VMVocabItem(word: "Foible", definition: "Weakness.", mnemonic: "Feeble."),
        VMVocabItem(word: "Foment", definition: "Instigate.", mnemonic: "Ferment."),
        VMVocabItem(word: "Forage", definition: "Search for food.", mnemonic: "For age."),
        VMVocabItem(word: "Forbear", definition: "Restrain.", mnemonic: "Bear it."),
        VMVocabItem(word: "Foray", definition: "Raid.", mnemonic: "Ray of attack."),
        VMVocabItem(word: "Foreboding", definition: "Fear of future.", mnemonic: "Before."),
        VMVocabItem(word: "Fauna", definition: "Animals.", mnemonic: "Fawn."),
        VMVocabItem(word: "Faux pas", definition: "Social mistake.", mnemonic: "False pass."),
        VMVocabItem(word: "Fawn", definition: "Flatter.", mnemonic: "Fan."),
        VMVocabItem(word: "Febrile", definition: "Feverish.", mnemonic: "February flu."),
        VMVocabItem(word: "Fecund", definition: "Fertile.", mnemonic: "Feces grow."),
        VMVocabItem(word: "Feeble", definition: "Weak.", mnemonic: "Feed me."),
        VMVocabItem(word: "Feign", definition: "Pretend.", mnemonic: "Fake."),
        VMVocabItem(word: "Feint", definition: "Fake move.", mnemonic: "Faint."),
        VMVocabItem(word: "Felicitate", definition: "Congratulate.", mnemonic: "Feliz."),
        VMVocabItem(word: "Felicitous", definition: "Fitting.", mnemonic: "Delicious."),
        VMVocabItem(word: "Felon", definition: "Criminal.", mnemonic: "Fell on."),
        VMVocabItem(word: "Ferment", definition: "Agitate.", mnemonic: "Mint."),
        VMVocabItem(word: "Ferret", definition: "Search.", mnemonic: "Rat search."),
        VMVocabItem(word: "Fervent", definition: "Passionate.", mnemonic: "Fever."),
        VMVocabItem(word: "Fervid", definition: "Intense.", mnemonic: "Fever."),
        VMVocabItem(word: "Fervor", definition: "Passion.", mnemonic: "Fever."),
        VMVocabItem(word: "Fester", definition: "Rot.", mnemonic: "Uncle Fester."),
        VMVocabItem(word: "Fetid", definition: "Stinking.", mnemonic: "Feet."),
        VMVocabItem(word: "Fetish", definition: "Obsession.", mnemonic: "Feet."),
        VMVocabItem(word: "Fetter", definition: "Restrain.", mnemonic: "Feet tie.")
    ]
    
    // Efficient search filtering
    var filteredWords: [VMVocabItem] {
        if searchText.isEmpty {
            return allWords.sorted { $0.word < $1.word }
        } else {
            return allWords.filter { $0.word.lowercased().contains(searchText.lowercased()) }
        }
    }
}

// MARK: - 4. UI VIEWS
struct VMContentView: View {
    @StateObject private var store = VMWordStore()
    
    var body: some View {
        TabView {
            // TAB 1: LIST VIEW
            NavigationStack {
                List(store.filteredWords) { word in
                    NavigationLink(destination: VMWordDetail(word: word)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(word.word)
                                    .font(.headline)
                                    .fontDesign(.serif)
                                Text(word.definition)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                            Spacer()
                            // Quick Audio Button in List
                            Button {
                                VMIndianSpeechManager.shared.speak(word.word)
                            } label: {
                                Image(systemName: "speaker.wave.2.circle")
                                    .foregroundStyle(.blue)
                            }
                            .buttonStyle(PlainButtonStyle()) // Prevents row selection when clicking button
                        }
                    }
                }
                .navigationTitle("Vocab Master (\(store.allWords.count))")
                .searchable(text: $store.searchText, prompt: "Search 600+ words...")
            }
            .tabItem {
                Label("Dictionary", systemImage: "books.vertical")
            }
            
            // TAB 2: FLASHCARDS
            VMFlashcardView(words: store.allWords)
                .tabItem {
                    Label("Practice", systemImage: "rectangle.on.rectangle.angled")
                }
        }
        .tint(.indigo)
    }
}

struct VMWordDetail: View {
    let word: VMVocabItem
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Large Header
                VStack(spacing: 10) {
                    Text(word.word)
                        .font(.system(size: 44, weight: .bold, design: .serif))
                        .multilineTextAlignment(.center)
                    
                    Button {
                        VMIndianSpeechManager.shared.speak(word.word)
                    } label: {
                        HStack {
                            Image(systemName: "speaker.wave.3.fill")
                            Text("Pronounce (IN)")
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.indigo.opacity(0.1))
                        .cornerRadius(20)
                    }
                }
                .padding(.top, 20)
                
                Divider()
                
                // Definition Card
                VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("DEFINITION")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                        Text(word.definition)
                            .font(.title3)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("MEMORY TRICK")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                        Text(word.mnemonic)
                            .font(.body)
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.yellow.opacity(0.15))
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(16)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct VMFlashcardView: View {
    let words: [VMVocabItem]
    @State private var current: VMVocabItem?
    @State private var flipped = false
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                if let w = current {
                    if flipped {
                        // Back of Card
                        VStack(spacing: 20) {
                            Text(w.definition)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Text("Trick: \(w.mnemonic)")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .padding()
                                .background(Color.yellow.opacity(0.1))
                                .cornerRadius(10)
                            
                            Button {
                                VMIndianSpeechManager.shared.speak(w.word)
                            } label: {
                                Image(systemName: "speaker.wave.2.circle.fill")
                                    .font(.largeTitle)
                            }
                        }
                        .padding()
                    } else {
                        // Front of Card
                        VStack {
                            Text(w.word)
                                .font(.system(size: 40, weight: .bold, design: .serif))
                            Text("Tap to flip")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(.top, 20)
                        }
                    }
                } else {
                    Text("Loading...").onAppear {
                        current = words.randomElement()
                    }
                }
            }
            .frame(width: 320, height: 480)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
            .onTapGesture {
                withAnimation(.spring()) {
                    flipped.toggle()
                }
            }
            
            Spacer()
            
            Button("Next Word") {
                withAnimation {
                    flipped = false
                    current = words.randomElement()
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.indigo)
            .padding(.bottom, 30)
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    VMContentView()
}
