#include <iostream>
#include <fstream>

using namespace std;

int int main(int argc, char *argv[])
{
    ifstream infile;
    string file;

    while(true)
    {
        infile.open("watchfile.txt");
        //Check if allready watched...
        while(infile)
        {
            infile>>file;
            
        }
        infile.close();
    }
    return 0;
}
