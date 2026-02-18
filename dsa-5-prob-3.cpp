#include <iostream>
using namespace std;
#define max 100
void palin(char a[], char b[]){
    for(int i=0;i<=6;i++){
        if (a[i]!=b[6-i]){
            cout<<"not palindrome";
            return;
        }}
     cout<<" it is a palindrome";
     return ;
}
int main(){
char arr[max]="ddoogg";
int top =5;
char n_arr[max];
int j=0;
for(int i = 6;i>=0;i--){
   
    cout<<arr[i];
    n_arr[j]=arr[i];
    j++;

}
for (int i =0;i<=6;i++){
    cout<<n_arr[i];
}

palin(arr,n_arr);





    return 0;
}