import 'package:mcp_bloc_joke/mcp/mcp_server.dart';

class McpClient {
  final MCPServer server;

  McpClient(this.server);

  dynamic runTool(String name, [dynamic args]) {
    return server.callTool(name, args);
  }
}
