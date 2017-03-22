package FlowGraph;

import Graph.*;

public class AssemFlowGraph extends FlowGraph{
	//用图上的节点查找指令的哈希表
	private java.util.Hashtable<Node, Assem.Instr> node2instr = new java.util.Hashtable<Node, Assem.Instr>();
	//用label查找图上的节点
	private java.util.Hashtable<Temp.Label, Node> label2node = new java.util.Hashtable<Temp.Label, Node>();
	//生成流图
	public AssemFlowGraph(Assem.InstrList instrs)
	{
		for (Assem.InstrList i = instrs; i != null; i = i.tail) 
		{
			//为构造流图产生基本信息
			Node node = newNode();
			//将节点/指令对存入哈希表
			node2instr.put(node, i.head);
			//将label/节点对存入哈希表
			if (i.head instanceof Assem.LABEL)
			label2node.put(((Assem.LABEL) i.head).label, node);
		}
		for (NodeList node = nodes(); node != null; node = node.tail)
		{
			//构造流图
			Assem.Targets next = instr(node.head).jumps(); 
			//得到跳转的目标label
			if (next == null) 
			{ 
				//若不是跳转指令,则从此条指令到下一条指令之间连一条有向边
				if (node.tail != null) 
					addEdge(node.head, node.tail.head);
			} 
			else 
			{
				//若是跳转指令,则从此条指令到所有可能跳转到的label之间连一条有向边,有多个label的原因是JUMP指令只有一个出口,但CJUMP指令有真假两个出口
				for (Temp.LabelList l = next.labels; l != null; l = l.tail)
					addEdge(node.head, (Node) label2node.get(l.head));
			}
		}
	}

	public Assem.Instr instr(Node n) //在哈希表中查询图的节点并返回所对应的指令
	{	return (Assem.Instr)node2instr.get(n);	}
		
	public Temp.TempList def(Node node) //返回在图中节点(指令)中所定值的寄存器(目标寄存器)
	{	return instr(node).def();	}

	public Temp.TempList use(Node node)//返回在图中节点(指令)中所引用的寄存器(源寄存器)
	{	return instr(node).use();	}
		
	public boolean isMove(Node node) 
	{
		//判断一条指令(节点)是否是move语句,因为在活性分析中move语句需要特别处理
		Assem.Instr instr = instr(node);
		//调用String类的成员函数,判断是否已move为开头
		return instr.assem.startsWith("move");
	}	
}
