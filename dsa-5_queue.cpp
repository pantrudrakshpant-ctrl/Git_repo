#include <iostream>
using namespace std;
#include <string>
int my_queue[5]={0,0,0,0,0};
int front=-1;
int back=-1;
void enqueue(int x){
    if(back==4){
        cout<<"queue is full";
        return;
        
    }//VVVIMP (WRITE IN NOTES) also inside queue take care of 1st enqueing from -1th
    if(front==-1){
        front=0;}
        //now do as done in push()
        back=back+1;
        my_queue[back]=x;
        cout<<x<<endl;
    
    return;
}
void dequeue(int y){
    if(front==-1){
        cout<<"queue is empty";
        return;
        
    }//
    if(front==back){
         cout<<my_queue[front];
        front=-1;
        back=-1;
    }// as front and rear if collided, then to dequeue re-intialize (can be at start or anywhere in the array)
    // if not collison then dequeue as did in pop
    else{
        cout<<my_queue[front];
        front=front+1;
        
    
    }
    return;
}
void ish_empty(void){
    if(front == -1){
        cout<<"queue is empty";
    }
    else{
        cout<<"queue is not empty";
    
    }
    return;
}
void ish_full(void){
    if(back == 4){
        cout<<"queue is full";
    }
    else{
        cout<<"queue is not full";
    
    }
    return;
}
//ask maam , need of is_empty and is_full as already insie push and pop ?
void peek(void){
    cout<<my_queue[front]<<endl;
//vvvimp in queue we peek at at the front
    return;
}

int main(){


    return 0;
}