package RegAlloc;
import Graph.Node;
import Graph.Graph;
/*
考察控制和数据流图,可以画出一张冲突图.
冲突图中的每个结点代表临时变量的值,每条边(t1,t2)代表了一对不能分配到同一个寄存器中的临时变量.
生成冲突图的算法如下:
1 在任何定义变量 a 且没有转移的指令中,其中非活跃变量包括 b1,b2…bj, 添加干扰边(a,b1),…(a,bj)
2 在转移指令 aﬂc 中,其中非活跃变量为 b1,…,bj,为每一个与 c 不同的 bi 添加干扰边(a,b1),…(a,bj) (即move指令要特殊考虑)
以上步骤在RegAlloc.Liveness.buildGraph中实现

 */
abstract public class InterferenceGraph extends Graph {
	abstract public Node tnode(Temp.Temp temp);
	abstract public Temp.Temp gtemp(Node node);
	abstract public MoveList moves();
	public int spillCost(Node node) {return 1;}
}
