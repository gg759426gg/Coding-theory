#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <iostream>
#define gen strlen(s)
using namespace std;
int  max_hmd=0,min_hmd = 0;
int n, a, b;
char f[4], v[7], T[2] = { '0','0' }, r[3] = { '0','0','0' }; 
void XOR1(char a, char b)
{
	(a == b) ? (T[0] = '0') : (T[0] = '1'); //�P�_XOR1
}
void XOR2(char a, char b)
{
	(a == b) ? (T[1] = '0') : (T[1] = '1');//�P�_XOR2 
}
void putin()
{
	for (n = 3; n < 7; n++)
	{
		v[n] = f[n - 3];
	}

}



int  i, x, y = 0, j, count[120] = { 0 }, s[16][7] = { {0,0,0,0,0,0,0},
											          {0,1,1,0,0,0,1},
											          {1,1,0,0,0,1,0},
											          {1,0,1,0,0,1,1},
											          {1,1,1,0,1,0,0},
											          {1,0,0,0,1,0,1},
											          {0,0,1,0,1,1,0},
											          {0,1,0,0,1,1,1},
											          {1,0,1,1,0,0,0},
											          {1,1,0,1,0,0,1},
											          {0,1,1,1,0,1,0},
											          {0,0,0,1,0,1,1},
											          {0,1,0,1,1,0,0},
											          {0,0,1,1,1,0,1},
											          {1,0,0,1,1,1,0},
											          {1,1,1,1,1,1,1}};
int main()
{
	while(1){
	fflush(stdin);//�M�ſ�J�w�İ�
	cout << "input data:";
	cin >> f;
	
	putin();

	for(n=0;n<=3;n++)
	{
		XOR1(f[3-n],r[2]);
		XOR2(T[0],r[1]);
		r[2]=T[1];
		r[1]=r[0];
		r[0]=T[0];
	}
	for(a=0;a<3;a++)
	{
		v[a]=r[a];
	}
	
    cout<<"�X�r�V�q="<<v<<endl;
	   
		
	for (x = 0; x < 16; x++) //16�ӦV�q 
	{
		for (j = x + 1; j < 16; j++) //�C��X�r�P�L�U�@��X�r�h��� 
		{
			for (i = 0; i < 7; i++) //�`�@7�ӼƦr 
			{
				if ((s[x][i] + s[j][i]) % 2 == 1) //�P�_��e�X�r�P�U�@��X�r�O�_���P 
					count[y]++;//�Y���P �~���Z��+1 
			}
			y++;
		}
	}
	max_hmd = count[0];
	min_hmd = count[0];
	for (y = 1; y < 120; y++)
	{	
		if (count[y] < max_hmd)
			min_hmd = count[y];
	}
	cout << "min_hmd:" << min_hmd;
	system("pause");
	
}
}
