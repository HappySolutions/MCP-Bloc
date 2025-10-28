class MCPServer {
  final Map<String, Function> _tools = {};

  void registerTool(String name, Function tool) {
    _tools[name] = tool;
    print('🔧 Registered tool: $name');
  }

  dynamic callTool(String name, [dynamic args]) {
    final tool = _tools[name];
    if (tool == null) throw Exception('Tool $name not found');
    return tool(args);
  }
}
