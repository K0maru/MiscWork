#ROS
# Nodes in graph
Nodes，节点，ROS中的重要组成部分，一个节点控制了一个可执行模块，而一个可执行文件中可以包含多个节点，节点与节点之间可以通过**发布、订阅**的方式转发信息。
## Remapping
**重映射**，一个节点中包含着多种可修改信息，而重映射就是通过对节点信息的修改使其指向不同的节点。
# Topic
Topic=message_bus，是节点与节点间传输数据的总线，Topic与节点间也遵循P&S的信息转发方式，同时Topic支持订阅任意数量节点并向任意数量节点发布信息
## echo&info
可以通过echo获取指定Topic发布的信息，info获取指定Topic的相关信息
## Topic pub
通过topic pub 指令直接向topic发送对应数据结构的数据类型
# service
是ROS graph中的另一种节点间数据交流的方法，与Topic不同的是，其采用的是call-and-response模式。Topic的P&S模式保证了**数据的实时性**，他们持续的保持发布和订阅关系，但呼叫响应模式，仅在接收端调用response时才更新数据。
## service type
收或发
## service interface&call
与Topic一样，我们也可以从命令行直接call service，同样的也需要遵循相应的数据结构
# parameter
是每个节点中所包含的参数，参数对该节点进行了节点规定范围内的设置，我们可以通过更改参数来对节点进行允许范围内的更改
## get
直接通过param get获取指定节点指定参数的值，同时可以判断其数据类型，但这种更改只能针对当前创建的session，并不能永久保存。
## dump&load
通过dump指令可以将当前参数以yaml格式保存下来，再通过load可以加载入相应session，也可以在创建session时就载入预设参数
# action
action是ros2 的一种长时间通讯类型，由goal，feedback，result组成，基于topic和service。采用client-server模式收发信息， action支持抢断
## send_goal
该命令可以直接对action的指定类型进行通讯