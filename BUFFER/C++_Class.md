# 类
通常是作为储存**相同类型项**的集合的数据结构，并且在**类**中还提供处理这些数据的函数。
## 基本构成
类由==成员==组成，成员可以是数据也可以是函数，若是函数则称为==成员函数==。类的每一个实例都是一个==对象==。成员函数可以处理对象，成员函数也往往被称为==方法==。
==public==和==private==确定了类成员的**可见性**，public下的成员可以被任何类任何方法访问，但private成员只能被他所在的类访问。
即**public成员提供了为一般用途设计的通用外部接口，任何类的任何方法都可以使用该接口，而private成员则是提供了对于类和类方法实现的内部接口，仅在内部为实现特定功能才被调用。**
==构造函数(constructor)==：描述如何构建类的实例的方法
## 语法
1. 构造函数的默认参数

```C++
Class IntCell
{
	public:
		explicit IntCell(int initialValue = 0)
			: storedValue{initialValue}{}
		int read() const
			{return storedValue;}
		void write(int x)
			{storedValue = x;}
	private:
		int storedValue; 
};

```
此处
int initialValue = 0就是一个默认参数，当有参数时接收initialValue，无参数则默认使用0为参数
2. 初始化表列
	**: storedValue{initialValue}{}**
3. explicit构造函数
	我们应该使所有的**单参数构造函数**为explicit型的，以避免==后台类型转换==。
	普通的构造函数可以被显式调用和隐试调用，但是explicit的构造函数只能被显式的调用，不能被隐试的调用。
	**抑制构造函数定义的隐式转换**
	**explicit构造函数只能用于直接初始化**
4. 常成员函数
	1. 访问函数：只检查不改变
	2. 修改函数：修改