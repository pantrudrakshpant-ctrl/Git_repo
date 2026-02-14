import sys #unlinke c/cpp which run in int main() to terminte whole program cant use return but must import sys then write sys.exit() same as our return (or return 0)
import time #copying delay functionality from arduino coding , just here time in seconds rest same as arduino coding
#make a video screen recording of the fitmusk exercise videos
#You cannot skip a single meal.
'''
Food Source	Quantity	Protein	Notes
Milk	1 Liter	32g	Use Double Toned (blue/purple packet) to save calories, or Toned. Full cream will make you gain fat.
Eggs	4 Whole	24g	Boiled or Omelette.
Paneer	200g	40g	You need to buy/make 200g daily. Divide into Lunch/Dinner.
Green Moong	50g (Raw weight)	12g	Weigh 50g raw, then sprout/boil it. It becomes a big bowl.
Roti/Dal/Rice	Normal intake	~12g	"Hidden" protein in wheat and lentils.
TOTAL		120g	

'''

x=1
#make functions for all independent items 
def milk_verka():
    typewriter("1L Milk from cafeteria : 30g protein , 30.5g fat , 45g carbs , 580 kcal calories")
def eggs():
    typewriter("4 eggs (from cafeteria or self) : 24g protein ,20g fat , 2.4 grams carbs , 310 kcal calories")
#experiment-see working 
def typewriter(message):
    for char in message:
        sys.stdout.write(char)  # Prints 1 character without a newline
        sys.stdout.flush()      # Forces the character to appear on screen NOW
        time.sleep(0.05)        # The delay (0.05 seconds)
    
    print()
#no newline at the end
def typewriterr(message):
    for char in message:
        sys.stdout.write(char)  # Prints 1 character without a newline
        sys.stdout.flush()      # Forces the character to appear on screen NOW
        time.sleep(0.05)        # The delay (0.05 seconds)
    
typewriter("Greeting\nRudraksh")
time.sleep(x)
typewriterr("Enter today's day: ")
day=input()
time.sleep(x)
if(day=="saturday"):
    typewriter("Diet Plan:")
    time.sleep(x)
    milk_verka()
    time.sleep(x)
    eggs()
    time.sleep(x)
    typewriter("rest!!!")
    sys.exit()
if(day=="sunday"):
    typewriter("Diet Plan:")
    time.sleep(x)
    milk_verka()
    time.sleep(x)
    eggs()
    time.sleep(x)
    typewriter("rest!!!")
    sys.exit()
typewriterr("Enter today's date: ")
date=input()
if(day=="monday"):
#in all such if day loops make further if looop to match dates tooo use calendar 
#inside these loops enter their respective diet plan and calorie requirement , 
#along with calorie requirement give a basic diet too that will be independently of the day
# covering atleast 60g protein
    typewriter("Diet Plan:")
    time.sleep(x)
    milk_verka()
    time.sleep(x)
    eggs()
    time.sleep(x)
    typewriter("rest!!!")
    sys.exit()
if(day=="tuesday"):
    typewriter("Diet Plan:")
    time.sleep(x)
    milk_verka()
    time.sleep(x)
    eggs()
    time.sleep(x)
    typewriter("rest!!!")
    sys.exit()
if(day=="wednesday"):
    typewriter("Diet Plan:")
    time.sleep(x)
    milk_verka()
    time.sleep(x)
    eggs()
    time.sleep(x)
    typewriter("rest!!!")
    sys.exit()
if(day=="thursday"):
    typewriter("Diet Plan:")
    time.sleep(x)
    milk_verka()
    time.sleep(x)
    eggs()
    time.sleep(x)
    typewriter("rest!!!")
    sys.exit() 
if(day=="friday"):
    typewriter("Diet Plan:")
    time.sleep(x)
    milk_verka()
    time.sleep(x)
    eggs()
    time.sleep(x)
    typewriter("rest!!!")
    sys.exit()



  