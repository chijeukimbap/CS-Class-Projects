//Adzhar A. Musa
//Renzo Jumangit
//CS200-B
//FINAL PROJECT
//March 22,2015
#include<iostream>															//Library Declarations
#include<time.h>
#include<conio.h>
#include<stdlib.h>
#include <ctime>

using namespace std;

int temp(char answer,int score);											//Function Declarations
int temp2(char answer,int score);

void main()																	//Beginning of Main Function
{
	
	int counter,score=0,Highscore=0,colors=0;
	char answer=NULL,retry;
	float accuracy=0;
	
	do
	{
	cout<<"\t\tMIND FLEXIBILITY AND ATTENTION TRAINER"<<endl<<endl;						//Title and Instructions to user
	cout<<"Instructions: This is a trainer based on popular attention "
		"tests over\nthe Internet.This trainer was designed to improve "
		"the flexibility and\nthe attention of the user's mind."<<endl
		<<"The mechanics of the trainer are simple."<<endl<<endl
		<<"<Enter 'y'>"<<endl<<endl
		<<"If the UPPER CASE statement matches the BACKGROUND"
		"\nor if the LOWER CASE statement matches the TEXT COLOR. "<<endl<<endl
		<<"<Enter 'n'>"<<endl<<endl
		<<"If it doesn't follow the conditions."<<endl<<endl
		<<"Good Luck and Have Fun!"<<endl<<endl;
		
	srand(time(NULL));																//Initialization of random number generator
	cout<<"Ready?"<<endl;															//User prompt to get ready
	system("pause");
	clock_t begin = clock();														//Beginning of time recording
	system("cls");
		for(counter=0;counter<50;counter++)											//Test Iteration of 50rounds
	{ 	
		colors=(rand()%24+1);
	

																					//Color Combinations
																					//Random number is then passed to switch to output corresponding test combination
		switch(colors)
		{
		//**************RED********************//
		case 1://red blue(correct)
			system("color 41");
			cout<<"RED"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;
		case 2://red blue(wrong green)
			system("color 41 ");
			cout<<"GREEN"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;
	
		case 3://red blue(wrong green)
			system("color 14");
			cout<<"green"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;
		
		case 4://red blue(correct)
			system("color 14");
			cout<<"red"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;

		case 5://Green red(correct)
			system("color 42");
			cout<<"RED"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;

		case 6://Green red(wrong)
			system("color 42");
			cout<<"BLUE"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;

		case 7://Red Green(wrong)
			system("color 24");
			cout<<"blue"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;
		
		case 8://Green red(correct)
			system("color 24");
			cout<<"red"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;
		//**************BLUE********************//
		case 9://Blue red(correct)
			system("color 14");
			cout<<"BLUE"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;

		case 10://Blue red(wrong)
			system("color 14");
			cout<<"GREEN"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;

		case 11://Blue red(wrong)
			system("color 41");
			cout<<"green"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;
	

		case 12://Blue red(correct)
			system("color 41");
			cout<<"blue"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;
		//*******BLUE GREEN********//
		case 13://Blue green(correct)
			system("color 12");
			cout<<"BLUE"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;

		case 14://Blue green(wrong)
			system("color 12");
			cout<<"RED"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;
		
		case 15://Blue green(wrong)
			system("color 21");
			cout<<"red"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;

		case 16://Blue green(correct)
			system("color 21");
			cout<<"blue"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;

		//**************GREEN********************//													//More cases

		case 17://GREEN red(correct)
			system("color 24");
			cout<<"GREEN"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;

		case 18://Green red(wrong)
			system("color 24");
			cout<<"BLUE"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;

		case 19://Green red(wrong)
			system("color 42");
			cout<<"blue"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;
	

		case 20://Green red(correct)
			system("color 42");
			cout<<"green"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;
		//*******Green Blue********//
		case 21://Green Blue(correct)
			system("color 21");
			cout<<"GREEN"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;

		case 22://Green Blue(wrong)
			system("color 21");
			cout<<"RED"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;
		
		case 23://Green Blue(wrong)
			system("color 12");
			cout<<"red"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp2(answer,score);
			cout<<endl;
			break;

		case 24://Blue green(correct)
			system("color 12");
			cout<<"green"<<endl;
			cout<<"Answer: ";
			do
			{
			cin>>answer;
			}
			while(answer!='y'&& answer!='n');
			score=temp(answer,score);
			cout<<endl;
			break;
		}
			
	system("cls");													//Screen is cleared to give way to each test page;
	}
	clock_t end = clock();											//End of time recording
	score=score*100;												//Calculation of Scores
	accuracy=score/50;
	system("cls");													
	system("color 07");
	system("pause");
	//Cushion for the trigger happy users
	cout<<"******************************GAME OVER*****************************************"<<endl;	//Results Page
	cout<<"Well done!"<<endl;
	cout<<"Accuracy: "<<accuracy<<"%"<<endl;
	double elapsedtime = double(end - begin) / CLOCKS_PER_SEC;										//Elapsed Time Calculation
	cout<<"Time Completed: "<<elapsedtime<<" "<<"seconds"<<endl<<endl;
	Highscore=10000*((accuracy)-((2*50)-elapsedtime));												//High Score Calculation
	cout<<"Want to try again?"<<endl;																//Prompt to user if they want to try again
	cout<<"High Score: "<<endl<<Highscore<<endl<<endl;
	cout<<"Press<y/n>"<<endl;
	cin>>retry;																						//Enter reply to prompt
	if(retry=='y'||'Y')																				//Screen clear for new set of rounds
	{
		system("cls");
		score=0;
	}
														
}while(retry=='y'||retry=='Y');																		//While the user is still indulged in the game, the game is being reset.
	
}

																									//End of Main Function
																									//Functions were made in order to isolate the scoring system to avoid error and confusion
int temp(char answer,int score)																		//Beginning of temp function
																									//Score Increment answer is yes
{
	
	if(answer=='y')
	{
		score++;
	}
	
	else
	{
		score+=0;
	}

	return score;
}																									//End of temp function

int temp2(char answer,int score)																	//Beginning of temp2 function
{
																									//Score Increment if No is Correct
	if(answer=='n')
	{
		score++;
	}
	else
	{
		score+=0;
	}

	return score;
}																								//End of temp2 function

 
 


	
	







//Programmed by:
//©Adzhar Musa
//for CS200-B
//2015-All Rights Reserved
