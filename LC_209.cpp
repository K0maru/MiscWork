#include <vector>
using namespace std;
class Solution {
public:
    int minSubArrayLen(int target, vector<int>& nums) {
        int L = 0,R = 0;
        int n = nums.size();
        int tmp = 0,ans = n+1;
        for(;R<n;++R){
            tmp += nums[R];
            if(tmp>=target){
                while(tmp-nums[L]>=target){
                    tmp-=nums[L];
                    L++;
                }
                ans = min(ans,R-L+1);
            }
        }
        if(ans<n+1){
            return ans;
        }
        else return 0;
    }
};
