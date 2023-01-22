#include <vector>
using namespace std;
class Solution {
public:
    vector<vector<int>> rangeAddQueries(int n, vector<vector<int>>& queries) {
        vector<vector<int>> diff(n+1,vector<int>(n+1,0));
        vector<vector<int>> ans(n,vector<int>(n,0));
        for(const auto &query:queries){
            diff[query[0]][query[1]]++;
            diff[query[2]+1][query[3]+1]++;
            diff[query[0]][query[3]+1]--;
            diff[query[2]+1][query[1]]--;
        }
        for(int i = 0;i<n;++i){
            for(int j = 1;j<n;++j){
                diff[i][j] += diff[i][j-1];
            }
        }
        for(int i = 1;i<n;++i){
            for(int j = 0;j<n;++j){
                diff[i][j] += diff[i-1][j];
            }
        }
        for(int i = 0;i<n;++i){
            for(int j = 0;j<n;++j){
                ans[i][j] = diff[i][j];
            }
        }
        return ans;
    }
};