#include <vector>
#include <string.h>
using namespace std;
class Solution {
public:
    bool isValidSudoku(vector<vector<char>>& board) {
        int row[9][9];
        int col[9][9];
        int box[3][3][9];
        memset(row,0,sizeof(row));
        memset(col,0,sizeof(col));
        memset(box,0,sizeof(box));
        for(int i = 0;i<9;++i){
            for(int j = 0;j<9;++j){
                char c = board[i][j];
                if(c != '.'){
                    int index = c-'0'-1;
                    row[i][index]++;
                    col[j][index]++;
                    box[i/3][j/3][index]++;
                    if(row[i][index]>1||col[j][index]>1||box[i/3][j/3][index]>1){
                        return false;
                    }
                }
            }
        }
        return true;
    }
};