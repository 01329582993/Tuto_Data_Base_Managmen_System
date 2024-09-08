#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>

using namespace std;

int ROW = 61;
int COLUMN = 6;
int counter = 61;
std::string table[100][6];



void writing()
{
    ofstream file;
    file.open("spell.txt");
    if(file.is_open())
    {
        int i,j;
        for(i =0; i<100; i++)
        {
            for(j= 0; j<6 ; j++) {
            file << table[i][j];
            file<<" ,";
            }
            file<<"\n";
        }
    }
    file.close();
}



void reading()
{
    string data[62];
    string temp;
    ifstream File;

    File.open("spells.txt", ios::in);
    if(File.is_open())
    {
        for(int j = 0; j < 61; j++)
        {
            getline(File, data[j]);
            int i = 0;
            temp.clear();
            for(char ch : data[j])
            {
                if(ch == ',' && i < 5)
                {
                    table[j][i] = temp;
                    i++;
                    temp.clear();
                }
                else
                {
                    temp += ch;
                }
            }

            table[j][i] = temp;
        }

        File.close();
    }
   // cout <<"\033[33m"<<"readed"<<"\033[0m"<<endl;

//
//    cout <<"Spell ID\t\tIncantation\t\tSpell Name\t\tEffect\t\tLight" << endl;
//
//
//    for(int i= 1 ; i< 62; i++)
//    {
//        for(int j= 0; j< 6; j++)
//        {
//            cout <<table [i][j]<<"\t\t";
//            if(j== 5){
//                cout<<"\n";
//            }
//        }
//    }
}


void searching(string id)
{
    reading();
    bool check = false;
    for(int i= 1; i<62; i++)
    {
        if(id == table[i][0])
        {
            check =  true;
            cout<<"\033[31m"<<table[i][0]<<" \033[32m"<<"Found !"<<"\033[0m"<<endl;
            //break;
        }
    }
    if(!check)
    {
        cout<<"\033[31m"<<"Not found"<<"\033[0m"<<endl;

    }
}


void insertion(string row)
{
    reading();
    int row_number = ++counter;
    //cout<< row_number;

    table[row_number][0]= row;
    cin >> table[row_number][1];
    cin >> table[row_number][2];
    cin >> table[row_number][3];
    cin >> table[row_number][4];
    cin >> table[row_number][5];

    writing();

//    cout << table[row_number][0];
//    cout << table[row_number][1];
//    cout << table[row_number][2];
//    cout << table[row_number][3];
//    cout << table[row_number][4];
//    cout << table[row_number][5];
    cout <<"\033[33m"<< "inserted"<<"\033[0m"<< endl;
}



void updatingColumn(int row, int column, string update)
{
    reading();
    table[row][column] = update;
    writing();
    cout<<"\033[33m"<<"Updated"<<"\033[33m"<<endl;
}



void deleting(int row)
{
    reading();
    for(int i =0; i<6; i++)
    {
        table[row][i] = " ";
    }
    writing();
    cout<<"\033[31m"<<"Deleted"<<"\033[0m"<<endl;
}



int main()
{
    int option;
    while (1)
    {
        cout<<"\033[32m"<< " 1 - Reading database file \n 2 - Inserting new rows in the database file \n 3 - Updating certain columns for some entries in the file \n 4 - Deleting entries from the file \n 5 - Searching entries from the file based on a unique ID\n     Press any key to exit !" <<"\033[0m"<< endl;
        cin>> option;
        string update;
        string id;
        string row;
        switch(option)
        {
        case 1:
            reading();
            break;

        case 2:
            cin>> row;
            insertion(row);
            break;

        case 3:
            int update_row, update_column;
            cin>> update_row ;
            cin>> update_column;
            cin>> update;
            updatingColumn(update_row, update_column, update);
            break;

        case 4:
            int delete_row;
            cin>> delete_row;
            deleting(delete_row);
            break;

        case 5:
            cin>> id;
            searching(id);
            break;

        default:
            exit(1);

        }

    }
}
