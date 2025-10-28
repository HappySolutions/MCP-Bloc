import 'package:mcp_bloc_joke/mcp/mcp_client.dart';

class GetWeatherUsecase {
  final McpClient mcpClient;

  GetWeatherUsecase(this.mcpClient);

  dynamic execute(String city) {
    return mcpClient.runTool('getWeather', city);
  }
}
