#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include<string.h>


struct listitem {
    char name[64];
    float energy;
    int space;
    float efficiency;
    struct listitem* next;

};

 struct listitem* head = NULL;

void printandFree (struct listitem *head) {
    struct listitem *current = NULL;
    current = head;
    while (head != NULL) {   ////FAUL
        printf("%s", head->name);
        printf(" ");
        printf("%f\n", head->efficiency);
        struct listitem* temp = NULL;
        temp = head;
        head = head-> next;
        free(temp);
    }
}

void swappy (struct listitem* p, struct listitem* q) {
    char temp[80]; 
    strcpy(temp,p->name);
    float tempf = p->efficiency;
    strcpy(p->name,q->name);
    p->efficiency = q->efficiency;
    strcpy(q->name,temp);
    q->efficiency = tempf;

}

void sorty (struct listitem *head) {
    // int swapped, i;
    int swapped = 0;
    int i = 0;
    struct listitem *temp = NULL;
    struct listitem* lptr = NULL;
    if (head == NULL) {      ////FAUL
        return;
    }
    do {
        swapped = 0;
        temp = head;
        while (temp->next != lptr) {
            if (temp->efficiency < temp->next->efficiency) {
                swappy(temp->next, temp);
                swapped = 1;
            }
            temp = temp->next;
        }
        lptr = temp;
    }
    while(swapped);

}

void alph (struct listitem *head) {
  //  int swapped, i;
    int swapped = 0;
    int i = 0;
    struct listitem *temp = NULL;
    struct listitem* lptr = NULL;
    if (head == NULL) {
        return;
    }
    do {
        swapped = 0;
        temp = head;
        while (temp->next != lptr) {
            if (temp->efficiency == temp->next->efficiency) {
                if (strcmp(temp->name,temp->next->name) > 0) {
                swappy(temp, temp->next);
                swapped = 1;
            }
            }
            temp = temp->next;
        }
        lptr = temp;
    }
    while(swapped);

}




int main(int argc, char* argv[]) {

   // struct listitem* head = (struct listitem*) calloc (1, sizeof(struct listitem));

  //  head = NULL;
   //head->next = NULL;


    //struct listitem* head = (struct listitem*) calloc (1, sizeof(struct listitem));
    
    //

    FILE* ptr;
    char line[1000];
    ptr = fopen(argv[1],"r");   //opening the file
    

    if (ptr == NULL) {
        printf("%s\n","BUILDING FILE IS EMPTY");  //if file doesnt exist ERROR
        return(-1);
    } 

    struct listitem* current;
    current = NULL;

    //head = NULL;
    

    char fake[64];
    struct listitem* Building;
    while (true) {

        Building = (struct listitem*) calloc (1, sizeof(struct listitem)); //allocate memory for each struct

        Building->next = NULL;
  

        fscanf(ptr, "%s", fake);

        if ((strcmp(fake,"DONE") == 0) && head == NULL){
            printf("%s\n","BUILDING FILE IS EMPTY");
            free(Building);
               fclose(ptr);
            return EXIT_SUCCESS;
        }


        if (strcmp(fake,"DONE") == 0) {
            break;
        }


        strcpy((Building->name), fake);      

        fscanf(ptr, "%d", &(Building->space)); //space area variable 
        fscanf(ptr, "%f", &(Building->energy));  //energy variable

        if (Building->energy == 0 || Building->space == 0) {
            Building->efficiency = 0.0; }  //finding the efficiency!
        else {
        Building->efficiency = (float) (Building->energy / Building->space);
        }

            if (head == NULL) {    // start = NULL
            // current = start ;   // current = NULL?     ///ISSUE IS RIGHT HERE!!!!!!!!! ///ISSUE IS RIGHT HERE!!!!!!!!!
            head = Building;
            current = Building ;   //if this is the first element 
           
        } else {
            current->next = Building;
            current = current->next;
        }


    }
    free(Building);
    sorty(head);
    alph(head);
    
   printandFree(head);
   
   fclose(ptr);
    //free(head);

    return EXIT_SUCCESS;
}




//the pocture of a fish or dog watever
//check valgrind
//how to add the error for empty file??
    