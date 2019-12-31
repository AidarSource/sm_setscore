#include <sourcemod>
#include <cstrike>
#include <sdktools_functions>

public Plugin myinfo = {
    name = "SetScore (ScoreboardManagement)",
    author = "Switchback",
    description = "Sets points for scoreboard(CT and T)",
    version = "1.0.0",
    url = "http://steamcommunity.com/id/switchwwe/"
}

public void OnPluginStart() {
    LoadTranslations("common.phrases");
    RegAdminCmd("sm_setscore", Command_SetScore, ADMFLAG_CHAT, "sm_setscore 'team' 'score' - Sets points for scoreboard(CT and T)");
}

public Action Command_SetScore(int client, int args) 
{
    if(!client)
        return Plugin_Handled;
    
    
    if(args) {
        char cTeam[64], cValue[64];
		
        GetCmdArg(1, cTeam, sizeof(cTeam));
        GetCmdArg(2, cValue, sizeof(cValue));
        
        if (StringToInt(cTeam) > 3 || StringToInt(cTeam) == 0) {
        	ReplyToCommand(client, "[SM] Usage: sm_setscore <team> <value> // 1 - SPEC, 2 - T, 3 - CT");
       		return Plugin_Handled;
		}
        
        CS_SetTeamScore(StringToInt(cTeam), StringToInt(cValue));
        SetTeamScore(StringToInt(cTeam), StringToInt(cValue));
		
        LogAction(client, -1, "\"%L\" triggered sm_setscore (score %s)", client, cValue);
    }
    return Plugin_Handled;
}
