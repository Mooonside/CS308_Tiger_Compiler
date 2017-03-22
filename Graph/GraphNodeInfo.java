package Graph;

import java.util.*;

public class GraphNodeInfo {
	public Set<Temp.Temp> in = new HashSet<Temp.Temp>(); //来指令前的活性变量
	public Set<Temp.Temp> out = new HashSet<Temp.Temp>(); //出指令后的活跃变量
	public Set<Temp.Temp> use = new HashSet<Temp.Temp>(); //某指令引用的变量 ,赋值号右边
	public Set<Temp.Temp> def = new HashSet<Temp.Temp>(); //某指令定义的变量 ,赋值号左边
	
	public GraphNodeInfo(Node node)
	{
		for (Temp.TempList i = ((FlowGraph.FlowGraph)node.mygraph).def(node); i != null; i = i.tail)
		{
			def.add(i.head);
		}
		for (Temp.TempList i = ((FlowGraph.FlowGraph)node.mygraph).use(node); i != null; i = i.tail)
		{
			use.add(i.head);
		}
	}
}
