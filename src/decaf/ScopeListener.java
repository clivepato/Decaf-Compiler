 package decaf;

 import java.util.Stack;

import org.antlr.v4.runtime.Token;
 
public class ScopeListener extends DecafParserBaseListener {
	
	private Stack<Scope> scopes;
	
	public ScopeListener() {
		scopes = new Stack<Scope>();
		scopes.push(new Scope(null));
		System.out.println("Confirmed");
	}  

	public void enterVar_decl(DecafParser.Var_nameContext ctx) {
		String name = ctx.ID().getText();
		Scope scope = scopes.peek();
		ScopeElement found = scope.get(name);
		Token token = ctx.getStart();
		int line = token.getLine();
		DecafParser.TypeContext tctx = ((DecafParser.Var_declContext)ctx.getParent()).type();
		int type = (tctx.INT() == null)? DecafParser.BOOLEAN : DecafParser.INT;
		scopes.peek().put(name, new ScopeElement(name, type, line));
		if (found != null) {
			System.err.println("Error line " + token.getLine()
					+ ": Variable \"" + name
					+ "\" used without prior declaration");
		}
		else {
			scopes.peek().put(name, new ScopeElement(name, type, line));
		}
 		
	}
	
	public void enterAssign(DecafParser.AssignContext ctx) { 
		DecafParser.LocationContext lctx = ctx.location();
		String varName = lctx.ID().getText();
		Token token = ctx.getStart();
		Scope scope = scopes.peek();
		ScopeElement found = scope.find(varName);
		if (found == null) {
			System.err.println("Error line " + token.getLine()
					+ ": Variable \"" + varName
					+ "\" used without prior declaration");
		}
	}		
}
