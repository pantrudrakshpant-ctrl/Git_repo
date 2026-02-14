#include <iostream>
#include <string>
#include <thread> // Required for sleep functionality
#include <chrono> // Required for time units
// revamp it to OOP style
using namespace std;
// unlike c/cpp which run in int main() to terminte whole program cant use return but must import sys then write sys.exit() same as our return (or return 0)
// copying delay functionality from arduino coding , just here time in seconds rest same as arduino coding
int x = 1;
// make functions for all independent items 
// experiment-see working 
void typewriter(string message) {
    for (char c : message) {
        cout << c << flush; // Prints 1 character without a newline and forces it to screen
        this_thread::sleep_for(chrono::milliseconds(50)); // The delay (0.05 seconds)
    }
    cout << endl;
}
// no newline at the end
void typewriterr(string message) {
    for (char c : message) {
        cout << c << flush; // Prints 1 character without a newline
        this_thread::sleep_for(chrono::milliseconds(50)); // The delay (0.05 seconds)
    }
}
//define nesting of classes here 
class plan{
    public:
        class week{
            public:
                class days{
                    public:
                        
                };
        };

};
// now using constructor or each day give uncommon properties

int main() {


    return 0;
}