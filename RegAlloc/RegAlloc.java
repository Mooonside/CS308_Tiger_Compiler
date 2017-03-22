package RegAlloc;

public class RegAlloc implements Temp.TempMap{
	private Assem.InstrList instrs;
	private Color color;

	public String tempMap(Temp.Temp t)
	{
		return color.tempMap(t);
	}
	public RegAlloc(Frame.Frame f, Assem.InstrList instrs) 
	{
		this.instrs = instrs;
		FlowGraph.FlowGraph flowGraph = new FlowGraph.AssemFlowGraph(instrs);
		InterferenceGraph interGraph=new Liveness(flowGraph);
		color = new Color(interGraph, f, f.registers());
	}
}
