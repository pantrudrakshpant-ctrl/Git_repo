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
        // --- NEW WORDS ADDED FROM USER LIST ---
        VMVocabItem(word: "Voluminous", definition: "Of great size; large in volume.", mnemonic: "Volume = size."),
        VMVocabItem(word: "Voracious", definition: "Having a huge appetite; very eager.", mnemonic: "Devour food."),
        VMVocabItem(word: "Vouchsafe", definition: "To grant or give as a favor.", mnemonic: "Vouch for safety."),
        VMVocabItem(word: "Vulpine", definition: "Relating to a fox; cunning.", mnemonic: "Fox-like."),
        VMVocabItem(word: "Waddle", definition: "To walk with short steps, swaying side to side.", mnemonic: "Duck walk."),
        VMVocabItem(word: "Waffle", definition: "To speak or write evasively.", mnemonic: "Waffling = indecisive."),
        VMVocabItem(word: "Waft", definition: "To float or be carried through the air.", mnemonic: "Scent wafts."),
        VMVocabItem(word: "Waggish", definition: "Humorous in a playful way.", mnemonic: "Wagging tail = playful."),
        VMVocabItem(word: "Waif", definition: "A homeless or helpless person, especially a child.", mnemonic: "Thin waif."),
        VMVocabItem(word: "Wallow", definition: "To roll about in mud or water; indulge in.", mnemonic: "Pigs wallow."),
        VMVocabItem(word: "Wan", definition: "Pale and giving the impression of illness.", mnemonic: "Sickly wan face."),
        VMVocabItem(word: "Wane", definition: "To decrease in size or strength.", mnemonic: "Moon wanes."),
        VMVocabItem(word: "Wangle", definition: "To get by persuasion or trickery.", mnemonic: "Wangle a deal."),
        VMVocabItem(word: "Wanton", definition: "Deliberate and unprovoked (often cruel).", mnemonic: "Wanton destruction."),
        VMVocabItem(word: "Warble", definition: "To sing with trills and quavers.", mnemonic: "Birds warble."),
        VMVocabItem(word: "Spurn", definition: "To reject with disdain.", mnemonic: "Spurn advances."),
        VMVocabItem(word: "Squalid", definition: "Extremely dirty and unpleasant.", mnemonic: "Squalid slum."),
        VMVocabItem(word: "Staid", definition: "Sedate, respectable, and unadventurous.", mnemonic: "Staid = stayed calm."),
        VMVocabItem(word: "Stalemate", definition: "A situation with no progress possible.", mnemonic: "Chess stalemate."),
        VMVocabItem(word: "Stalwart", definition: "Loyal, reliable, and hardworking.", mnemonic: "Stalwart supporter."),
        VMVocabItem(word: "Stamina", definition: "Endurance; ability to sustain effort.", mnemonic: "Long run stamina."),
        VMVocabItem(word: "Statute", definition: "A written law.", mnemonic: "Statute = law."),
        VMVocabItem(word: "Stentorian", definition: "Very loud or powerful in sound.", mnemonic: "Stentorian voice."),
        VMVocabItem(word: "Stereotyped", definition: "Lacking originality; unoriginal.", mnemonic: "Stereotype = cliché."),
        VMVocabItem(word: "Stilted", definition: "Stiff and self-conscious.", mnemonic: "Stilted speech."),
        VMVocabItem(word: "Stoic", definition: "Enduring pain without showing feelings.", mnemonic: "Stoic = stone-like."),
        VMVocabItem(word: "Strait", definition: "A narrow passage of water; a difficult situation.", mnemonic: "Dire straits."),
        VMVocabItem(word: "Strident", definition: "Loud and harsh.", mnemonic: "Strident alarm."),
        VMVocabItem(word: "Stringent", definition: "Strict, precise, and exacting.", mnemonic: "Stringent rules."),
        VMVocabItem(word: "Stupefy", definition: "To stun or amaze.", mnemonic: "Stupefied by shock."),
        VMVocabItem(word: "Stupendous", definition: "Extremely impressive.", mnemonic: "Stupendous feat."),
        VMVocabItem(word: "Stymie", definition: "To block or hinder.", mnemonic: "Stymied progress."),
        VMVocabItem(word: "Suave", definition: "Charming, confident, and elegant.", mnemonic: "Suave gentleman."),
        VMVocabItem(word: "Renege", definition: "To go back on a promise.", mnemonic: "Renege on deal."),
        VMVocabItem(word: "Reparation", definition: "Making amends for a wrong.", mnemonic: "War reparations."),
        VMVocabItem(word: "Repartee", definition: "Quick, witty conversation.", mnemonic: "Clever repartee."),
        VMVocabItem(word: "Repatriate", definition: "To return to one's own country.", mnemonic: "Re-patriate = return home."),
        VMVocabItem(word: "Repercussion", definition: "An unintended consequence.", mnemonic: "Repercussions of action."),
        VMVocabItem(word: "Repertoire", definition: "A stock of skills or performances.", mnemonic: "Actor's repertoire."),
        VMVocabItem(word: "Repine", definition: "To feel or express discontent.", mnemonic: "Repine = pine again."),
        VMVocabItem(word: "Replenish", definition: "To refill or restore.", mnemonic: "Replenish supplies."),
        VMVocabItem(word: "Replete", definition: "Filled or well-supplied.", mnemonic: "Replete with food."),
        VMVocabItem(word: "Replica", definition: "An exact copy.", mnemonic: "Replica = copy."),
        VMVocabItem(word: "Repository", definition: "A place where things are stored.", mnemonic: "Repository = store."),
        VMVocabItem(word: "Reprehensible", definition: "Deserving blame.", mnemonic: "Reprehensible act."),
        VMVocabItem(word: "Reprieve", definition: "A temporary relief from harm or punishment.", mnemonic: "Reprieve from sentence."),
        VMVocabItem(word: "Reprimand", definition: "A formal scolding.", mnemonic: "Reprimand employee."),
        VMVocabItem(word: "Reprobate", definition: "An unprincipled person.", mnemonic: "Reprobate = rogue."),
        VMVocabItem(word: "Repudiate", definition: "To reject or disown.", mnemonic: "Repudiate claim."),
        VMVocabItem(word: "Repugnance", definition: "Intense disgust.", mnemonic: "Repugnance to smell."),
        VMVocabItem(word: "Rescind", definition: "To revoke or cancel.", mnemonic: "Rescind contract."),
        VMVocabItem(word: "Resiliency", definition: "Ability to recover quickly.", mnemonic: "Resilient rubber."),
        VMVocabItem(word: "Resonant", definition: "Deep, clear, and continuing to sound.", mnemonic: "Resonant bell."),
        VMVocabItem(word: "Authoritarian", definition: "Favoring strict obedience to authority.", mnemonic: "Authoritarian regime."),
        VMVocabItem(word: "Autocracy", definition: "A system of government by one person.", mnemonic: "Auto = self, cracy = rule."),
        VMVocabItem(word: "Automation", definition: "Use of automatic equipment.", mnemonic: "Factory automation."),
        VMVocabItem(word: "Automaton", definition: "A moving mechanical device; robot.", mnemonic: "Robot automaton."),
        VMVocabItem(word: "Autopsy", definition: "Examination of a dead body.", mnemonic: "Post-mortem autopsy."),
        VMVocabItem(word: "Auxiliary", definition: "Providing additional help or support.", mnemonic: "Auxiliary engine."),
        VMVocabItem(word: "Avarice", definition: "Extreme greed for wealth.", mnemonic: "Avarice = greed."),
        VMVocabItem(word: "Aver", definition: "To state or assert to be the case.", mnemonic: "Aver = affirm."),
        VMVocabItem(word: "Aviary", definition: "A large enclosure for birds.", mnemonic: "Aviary = birds."),
        VMVocabItem(word: "Avid", definition: "Having or showing keen interest.", mnemonic: "Avid reader."),
        VMVocabItem(word: "Avocation", definition: "A hobby or minor occupation.", mnemonic: "Avocation = hobby."),
        VMVocabItem(word: "Avow", definition: "To declare openly.", mnemonic: "Avow = vow."),
        VMVocabItem(word: "Avuncular", definition: "Like an uncle.", mnemonic: "Avuncular advice."),
        VMVocabItem(word: "Awe", definition: "A feeling of wonder or admiration.", mnemonic: "Awe-inspiring."),
        VMVocabItem(word: "Awry", definition: "Away from the expected course.", mnemonic: "Plans go awry."),
        VMVocabItem(word: "Axiom", definition: "A statement accepted as true.", mnemonic: "Math axiom."),
        VMVocabItem(word: "Azure", definition: "Bright blue in color.", mnemonic: "Azure sky."),
        VMVocabItem(word: "Macabre", definition: "Disturbing and horrifying.", mnemonic: "Macabre story."),
        VMVocabItem(word: "Macerate", definition: "To soften by soaking.", mnemonic: "Macerate fruit."),
        VMVocabItem(word: "Machiavellian", definition: "Cunning, scheming, and unscrupulous.", mnemonic: "Machiavellian politics."),
        VMVocabItem(word: "Machination", definition: "A plot or scheme.", mnemonic: "Secret machination."),
        VMVocabItem(word: "Maelstrom", definition: "A powerful whirlpool; chaos.", mnemonic: "Maelstrom of activity."),
        VMVocabItem(word: "Maestro", definition: "A distinguished musician.", mnemonic: "Maestro conductor."),
        VMVocabItem(word: "Magnanimous", definition: "Very generous or forgiving.", mnemonic: "Magnanimous gesture."),
        VMVocabItem(word: "Magnate", definition: "A wealthy and influential person.", mnemonic: "Business magnate."),
        VMVocabItem(word: "Magniloquent", definition: "Using high-flown or bombastic language.", mnemonic: "Magniloquent speech."),
        VMVocabItem(word: "Maim", definition: "To wound or injure seriously.", mnemonic: "Maimed in accident."),
        VMVocabItem(word: "Maladroit", definition: "Clumsy; unskillful.", mnemonic: "Maladroit = not adroit."),
        VMVocabItem(word: "Malaise", definition: "A general feeling of discomfort.", mnemonic: "Malaise = unease."),
        VMVocabItem(word: "Malapropism", definition: "Mistaken use of a word.", mnemonic: "Malapropism = word mix-up."),
        VMVocabItem(word: "Malcontent", definition: "A person dissatisfied with current conditions.", mnemonic: "Malcontent = not content."),
        VMVocabItem(word: "Malediction", definition: "A curse.", mnemonic: "Malediction = bad words."),
        VMVocabItem(word: "Malefactor", definition: "A person who commits a crime.", mnemonic: "Malefactor = bad actor."),
        VMVocabItem(word: "Malicious", definition: "Intending to do harm.", mnemonic: "Malicious intent."),
        VMVocabItem(word: "Malign", definition: "To speak harmful untruths.", mnemonic: "Malign = bad language."),
        VMVocabItem(word: "Malignant", definition: "Very harmful or dangerous.", mnemonic: "Malignant tumor."),
        VMVocabItem(word: "Exonerate", definition: "To clear from blame.", mnemonic: "Exonerate = free from blame."),
        VMVocabItem(word: "Exorcise", definition: "To drive out evil spirits.", mnemonic: "Exorcise demon."),
        VMVocabItem(word: "Exotic", definition: "Attractively unusual or foreign.", mnemonic: "Exotic animal."),
        VMVocabItem(word: "Expatiate", definition: "To speak or write at length.", mnemonic: "Expatiate on topic."),
        VMVocabItem(word: "Expatriate", definition: "A person living outside their native country.", mnemonic: "Expatriate = expat."),
        VMVocabItem(word: "Expedite", definition: "To speed up the process.", mnemonic: "Expedite delivery."),
        VMVocabItem(word: "Expeditious", definition: "Done with speed and efficiency.", mnemonic: "Expeditious service."),
        VMVocabItem(word: "Expiate", definition: "To make amends for.", mnemonic: "Expiate sins."),
        VMVocabItem(word: "Exploit", definition: "To make use of; a bold feat.", mnemonic: "Exploit opportunity."),
        VMVocabItem(word: "Exploitation", definition: "The act of using unfairly.", mnemonic: "Exploitation of workers."),
        VMVocabItem(word: "Exponent", definition: "A person who supports an idea; a mathematical power.", mnemonic: "Exponent in math."),
        VMVocabItem(word: "Expunge", definition: "To erase or remove completely.", mnemonic: "Expunge record."),
        VMVocabItem(word: "Expurgate", definition: "To remove offensive parts.", mnemonic: "Expurgate book."),
        VMVocabItem(word: "Extant", definition: "Still in existence.", mnemonic: "Extant = existing."),
        VMVocabItem(word: "Extemporaneous", definition: "Done without preparation.", mnemonic: "Extemporaneous speech."),
        VMVocabItem(word: "Extemporize", definition: "To improvise.", mnemonic: "Extemporize = improvise."),
        VMVocabItem(word: "Extol", definition: "To praise highly.", mnemonic: "Extol achievements."),
        VMVocabItem(word: "Extradite", definition: "To hand over a criminal to another authority.", mnemonic: "Extradite fugitive."),
        VMVocabItem(word: "Corpulent", definition: "Fat; obese.", mnemonic: "Corpulent body."),
        VMVocabItem(word: "Correlation", definition: "A mutual relationship.", mnemonic: "Correlation = relation."),
        VMVocabItem(word: "Corroborate", definition: "To confirm or support.", mnemonic: "Corroborate evidence."),
        VMVocabItem(word: "Corrosive", definition: "Tending to cause corrosion.", mnemonic: "Corrosive acid."),
        VMVocabItem(word: "Corrugated", definition: "Shaped into ridges and grooves.", mnemonic: "Corrugated cardboard."),
        VMVocabItem(word: "Coruscate", definition: "To flash or sparkle.", mnemonic: "Coruscate = sparkle."),
        VMVocabItem(word: "Cosmic", definition: "Relating to the universe.", mnemonic: "Cosmic space."),
        VMVocabItem(word: "Coterie", definition: "A small, exclusive group.", mnemonic: "Coterie of friends."),
        VMVocabItem(word: "Countenance", definition: "A person's face or expression.", mnemonic: "Calm countenance."),
        VMVocabItem(word: "Counterfeit", definition: "Made in imitation; fake.", mnemonic: "Counterfeit money."),
        VMVocabItem(word: "Countermand", definition: "To revoke an order.", mnemonic: "Countermand command."),
        VMVocabItem(word: "Counterpart", definition: "A person or thing corresponding to another.", mnemonic: "Counterpart in company."),
        VMVocabItem(word: "Coup", definition: "A sudden, successful action.", mnemonic: "Military coup."),
        VMVocabItem(word: "Couple", definition: "Two individuals together.", mnemonic: "Married couple."),
        VMVocabItem(word: "Courier", definition: "A messenger.", mnemonic: "Courier delivers."),
        VMVocabItem(word: "Covenant", definition: "A formal agreement.", mnemonic: "Marriage covenant."),
        VMVocabItem(word: "Covert", definition: "Not openly acknowledged; secret.", mnemonic: "Covert operation."),
        VMVocabItem(word: "Infinitesimal", definition: "Extremely small.", mnemonic: "Infinitesimal amount."),
        VMVocabItem(word: "Infirmity", definition: "Physical or mental weakness.", mnemonic: "Old age infirmity."),
        VMVocabItem(word: "Influx", definition: "An arrival of large numbers.", mnemonic: "Influx of tourists."),
        VMVocabItem(word: "Infraction", definition: "A violation of a law.", mnemonic: "Traffic infraction."),
        VMVocabItem(word: "Infringe", definition: "To violate a law or right.", mnemonic: "Infringe copyright."),
        VMVocabItem(word: "Ingenious", definition: "Clever, original, and inventive.", mnemonic: "Ingenious invention."),
        VMVocabItem(word: "Ingenue", definition: "An innocent or naive young woman.", mnemonic: "Ingenue actress."),
        VMVocabItem(word: "Ingenuous", definition: "Innocent and unsuspecting.", mnemonic: "Ingenuous child."),
        VMVocabItem(word: "Ingenuity", definition: "Cleverness or inventiveness.", mnemonic: "Ingenuity = genius."),
        VMVocabItem(word: "Ingratiate", definition: "To gain favor by flattery.", mnemonic: "Ingratiate with boss."),
        VMVocabItem(word: "Inherent", definition: "Existing as a natural part.", mnemonic: "Inherent trait."),
        VMVocabItem(word: "Inhibit", definition: "To restrain or prevent.", mnemonic: "Inhibit growth."),
        VMVocabItem(word: "Inimical", definition: "Hostile or unfriendly.", mnemonic: "Inimical attitude."),
        VMVocabItem(word: "Inimitable", definition: "Impossible to imitate.", mnemonic: "Inimitable style."),
        VMVocabItem(word: "Initiate", definition: "To begin or start.", mnemonic: "Initiate project."),
        VMVocabItem(word: "Inkling", definition: "A slight suspicion or hint.", mnemonic: "Inkling of truth."),
        VMVocabItem(word: "Innate", definition: "Inborn; natural.", mnemonic: "Innate talent."),
        VMVocabItem(word: "Innocuous", definition: "Not harmful or offensive.", mnemonic: "Innocuous remark."),
        VMVocabItem(word: "Innovation", definition: "A new idea or method.", mnemonic: "Innovation in tech."),
        VMVocabItem(word: "Alliteration", definition: "Repetition of initial consonant sounds.", mnemonic: "Alliteration in poetry."),
        VMVocabItem(word: "Allude", definition: "To refer to indirectly.", mnemonic: "Allude to event."),
        VMVocabItem(word: "Allure", definition: "The quality of being attractive.", mnemonic: "Allure of fame."),
        VMVocabItem(word: "Alluvial", definition: "Relating to deposits made by flowing water.", mnemonic: "Alluvial soil."),
        VMVocabItem(word: "Aloft", definition: "Up in the air.", mnemonic: "Balloon aloft."),
        VMVocabItem(word: "Aloof", definition: "Not friendly or forthcoming.", mnemonic: "Aloof = distant."),
        VMVocabItem(word: "Altercation", definition: "A noisy argument.", mnemonic: "Altercation = quarrel."),
        VMVocabItem(word: "Altruism", definition: "Selfless concern for others.", mnemonic: "Altruism = selfless."),
        VMVocabItem(word: "Altruistic", definition: "Showing selfless concern.", mnemonic: "Altruistic act."),
        VMVocabItem(word: "Alumna", definition: "A female graduate.", mnemonic: "Alumna = woman alum."),
        VMVocabItem(word: "Amateur", definition: "A person who engages in an activity for pleasure.", mnemonic: "Amateur = not professional."),
        VMVocabItem(word: "Amalgamate", definition: "To combine or unite.", mnemonic: "Amalgamate companies."),
        VMVocabItem(word: "Amazon", definition: "A strong, powerful woman.", mnemonic: "Amazon warrior."),
        VMVocabItem(word: "Ambidextrous", definition: "Able to use both hands equally well.", mnemonic: "Ambidextrous = both hands."),
        VMVocabItem(word: "Ambience", definition: "The character of a place.", mnemonic: "Ambience = atmosphere."),
        VMVocabItem(word: "Ambiguous", definition: "Open to more than one interpretation.", mnemonic: "Ambiguous answer."),
        VMVocabItem(word: "Ameliorate", definition: "To make better.", mnemonic: "Ameliorate situation."),
        VMVocabItem(word: "Amen", definition: "An expression of agreement.", mnemonic: "Amen = so be it."),
        VMVocabItem(word: "Amenable", definition: "Open and responsive to suggestion.", mnemonic: "Amenable to advice."),
        VMVocabItem(word: "Pummel", definition: "To strike repeatedly.", mnemonic: "Pummel with fists."),
        VMVocabItem(word: "Punctilious", definition: "Showing great attention to detail.", mnemonic: "Punctilious = punctual."),
        VMVocabItem(word: "Pundit", definition: "An expert in a particular subject.", mnemonic: "TV pundit."),
        VMVocabItem(word: "Pandit", definition: "A Hindu scholar or teacher.", mnemonic: "Pandit = learned."),
        VMVocabItem(word: "Pungency", definition: "The quality of being pungent.", mnemonic: "Pungency of onion."),
        VMVocabItem(word: "Punitive", definition: "Intended as punishment.", mnemonic: "Punitive damages."),
        VMVocabItem(word: "Puny", definition: "Small and weak.", mnemonic: "Puny arms."),
        VMVocabItem(word: "Purblind", definition: "Having impaired vision; slow to understand.", mnemonic: "Purblind = partly blind."),
        VMVocabItem(word: "Purgatory", definition: "A place of temporary punishment.", mnemonic: "Purgatory = cleanse."),
        VMVocabItem(word: "Purge", definition: "To rid of impurities.", mnemonic: "Purge toxins."),
        VMVocabItem(word: "Purloin", definition: "To steal.", mnemonic: "Purloin = steal."),
        VMVocabItem(word: "Purport", definition: "To claim or profess.", mnemonic: "Purport to know."),
        VMVocabItem(word: "Purveyor", definition: "A supplier of goods.", mnemonic: "Purveyor of food."),
        VMVocabItem(word: "Purview", definition: "The range of experience or thought.", mnemonic: "Purview of law."),
        VMVocabItem(word: "Pusillanimous", definition: "Lacking courage; cowardly.", mnemonic: "Pusillanimous = pussycat."),
        VMVocabItem(word: "Putative", definition: "Generally considered or reputed to be.", mnemonic: "Putative leader."),
        VMVocabItem(word: "Putrefy", definition: "To decay or rot.", mnemonic: "Putrefy meat."),
        VMVocabItem(word: "Putrid", definition: "Decaying or rotting and emitting a foul smell.", mnemonic: "Putrid smell."),
        VMVocabItem(word: "Pyre", definition: "A heap of combustible material for burning a body.", mnemonic: "Funeral pyre."),
        VMVocabItem(word: "Pyromania", definition: "An obsessive desire to set fire to things.", mnemonic: "Pyromania = fire mania."),
        VMVocabItem(word: "Pyromaniac", definition: "A person with pyromania.", mnemonic: "Pyromaniac sets fires."),
        VMVocabItem(word: "Forensic", definition: "Relating to scientific methods in crime investigation.", mnemonic: "Forensic science."),
        VMVocabItem(word: "Forfeit", definition: "To lose as a penalty.", mnemonic: "Forfeit the game."),
        VMVocabItem(word: "Forego", definition: "To go before; precede.", mnemonic: "Forego dessert."),
        VMVocabItem(word: "Forgo", definition: "To do without.", mnemonic: "Forgo luxuries."),
        VMVocabItem(word: "Fortuitous", definition: "Happening by chance.", mnemonic: "Fortuitous event."),
        VMVocabItem(word: "Foster", definition: "To encourage or promote.", mnemonic: "Foster growth."),
        VMVocabItem(word: "Foundling", definition: "An abandoned child.", mnemonic: "Found foundling."),
        VMVocabItem(word: "Fracas", definition: "A noisy quarrel.", mnemonic: "Fracas = ruckus."),
        VMVocabItem(word: "Fractious", definition: "Irritable and quarrelsome.", mnemonic: "Fractious child."),
        VMVocabItem(word: "Fragile", definition: "Easily broken.", mnemonic: "Fragile glass."),
        VMVocabItem(word: "Frailty", definition: "The condition of being weak.", mnemonic: "Frailty of old age."),
        VMVocabItem(word: "Franchise", definition: "The right to vote; a business license.", mnemonic: "Franchise business."),
        VMVocabItem(word: "Fraught", definition: "Filled with (something undesirable).", mnemonic: "Fraught with danger."),
        VMVocabItem(word: "Fray", definition: "A fight or battle.", mnemonic: "Join the fray."),
        VMVocabItem(word: "Frenzied", definition: "Wildly excited or uncontrolled.", mnemonic: "Frenzied crowd."),
        VMVocabItem(word: "Fresco", definition: "A painting on wet plaster.", mnemonic: "Fresco art."),
        VMVocabItem(word: "Fritter", definition: "To waste time or money on unimportant things.", mnemonic: "Fritter away time."),
        VMVocabItem(word: "Frolicsome", definition: "Full of fun; playful.", mnemonic: "Frolicsome puppy."),
        VMVocabItem(word: "Frond", definition: "A large leaf, especially of a fern.", mnemonic: "Fern frond."),
        VMVocabItem(word: "Noncommittal", definition: "Not expressing commitment.", mnemonic: "Noncommittal answer."),
        VMVocabItem(word: "Nonentity", definition: "A person or thing with no special qualities.", mnemonic: "Nonentity = nobody."),
        VMVocabItem(word: "Nonplussed", definition: "Surprised and confused.", mnemonic: "Nonplussed by news."),
        VMVocabItem(word: "Nosegay", definition: "A small bunch of flowers.", mnemonic: "Nosegay bouquet."),
        VMVocabItem(word: "Nostalgia", definition: "A sentimental longing for the past.", mnemonic: "Nostalgia for childhood."),
        VMVocabItem(word: "Nostrum", definition: "A medicine of doubtful effectiveness.", mnemonic: "Nostrum remedy."),
        VMVocabItem(word: "Notarize", definition: "To have a document legalized by a notary.", mnemonic: "Notarize signature."),
        VMVocabItem(word: "Notorious", definition: "Famous for something bad.", mnemonic: "Notorious criminal."),
        VMVocabItem(word: "Novice", definition: "A beginner.", mnemonic: "Novice learner."),
        VMVocabItem(word: "Nuance", definition: "A subtle difference.", mnemonic: "Nuance in meaning."),
        VMVocabItem(word: "Nubile", definition: "(Of a young woman) sexually attractive.", mnemonic: "Nubile bride."),
        VMVocabItem(word: "Negatory", definition: "Expressing denial or refusal.", mnemonic: "Negatory = negative."),
        VMVocabItem(word: "Numismatist", definition: "A coin collector.", mnemonic: "Numismatist = coins."),
        VMVocabItem(word: "Nuptial", definition: "Relating to marriage.", mnemonic: "Nuptial ceremony."),
        VMVocabItem(word: "Nurture", definition: "To care for and encourage growth.", mnemonic: "Nurture child."),
        VMVocabItem(word: "Nutrient", definition: "A substance that provides nourishment.", mnemonic: "Nutrient in food."),
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
                .background(Color.gray.opacity(0.15))
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
        .background(Color.white)
    }
}

struct VMContentView_Previews: PreviewProvider {
    static var previews: some View {
        VMContentView()
    }
}
