#include <iostream>
using namespace std;
#include <string>
// creating a stack using arrays
int my_stack[5]={0,0,0,0,0};
//intialize top to -1 (use top to keep track of the topmost element as satck grows upwards and can be used as index)
//see using top we can figure if stack is full or not as in stacks , if we push top incrments and by using top's value as index acees location and store it there , 
//so learn (VVVIMP)stack is full if top's index id array_length-1
//similary learn if stack is empty top is at -1
int top =-1;
void push(int x){
    if(top == 4){
        cout<< "can't push as stack is full\n";
        return;
    }//array_length-1
    else{
        top=top+1;
        my_stack[top]=x;
    }
    cout<<"pushed successfully\n";
    return;
}
void pop(void){
    if(top == -1){
        cout<< "can't pop as stack is empty\n";
        return;
    }
    else{
        int print = my_stack[top];
        top=top-1;
        cout<<print<<endl;
    }
    cout<<"popped successfully\n";
    return ;
}
void ish_empty(void){
    if(top == -1){
        cout<<"stack is empty";
    }
    else{
        cout<<"not empty";
    
    }
    return;
}
void ish_full(void){
    if(top == 4){
        cout<<"stack is full";
    }
    else{
        cout<<"stack is not full";
    
    }
    return;
}
//ask maam , need of is_empty and is_full as already insie push and pop ?
void peek(void){
    cout<<my_stack[top]<<endl;

    return;
}
int main(){

push(10);
pop();
push(10);

push(20);

push(30);
peek();

push(40);
push(50);
push(60);
pop();
pop();
ish_empty();
ish_full();
return 0;
}
