import java_cup.runtime.*;

%%

%class Lexer
%unicode
%public
%cup
%line
%column

%{
    // Código Java adicional se necessário
%}

// ====== Definições de Macros ======
WHITESPACE = [ \t\r\n]+
COMMENT = "//" [^\n]*
NUMBER = [0-9]+(\.[0-9]+)?
ID = [a-zA-Z_][a-zA-Z0-9_]*
SKEY = "f1"|"f2"|"f3"|"f4"|"f5"|"f6"|"f7"|"f8"|"f9"|"f10"|"f11"|"f12"|"tab"|"enter"|"shift"|"ctrl"|"alt"|"space"|"mwheelup"|"mwheeldown"|"leftarrow"|"rightarrow"|"uparrow"|"downarrow"|"mouse1"|"mouse2"|"mouse3"|"mouse4"|"mouse5"
MSG = [^\n\r;]+

%%

// ====== Regras Lexicais ======
// IMPORTANTE: Ordem das regras importa! Mais específicas primeiro, gerais depois

// Comentários e espaços em branco (ignorados)
{WHITESPACE}                  { /* ignora espaços */ }
{COMMENT}                     { /* ignora comentários */ }

// Símbolos
";"                           { return new Symbol(sym.SEMICOLON, yyline, yycolumn, yytext()); }
"{"                           { return new Symbol(sym.LBRACE, yyline, yycolumn, yytext()); }
"}"                           { return new Symbol(sym.RBRACE, yyline, yycolumn, yytext()); }

// Palavras-chave específicas do CS2 (mais específicas primeiro)
"gama"                        { return new Symbol(sym.R_FULLSCREEN_GAMMA, yyline, yycolumn); }
"escala_hud"                  { return new Symbol(sym.HUD_SCALING, yyline, yycolumn); }
"id_inimigo"                  { return new Symbol(sym.HUD_SHOWTARGETID, yyline, yycolumn); }
"cor"                         { return new Symbol(sym.CL_COLOR, yyline, yycolumn); }
"cor_hud"                     { return new Symbol(sym.CL_HUD_COLOR, yyline, yycolumn); }
"animacao_avatar"             { return new Symbol(sym.CL_ALLOW_ANIMATED_AVATARS, yyline, yycolumn); }
"equipamentos"                { return new Symbol(sym.CL_SHOWLOADOUT, yyline, yycolumn); }
"tab_radar_quadrado"          { return new Symbol(sym.CL_RADAR_SQUARE_WITH_SCOREBOARD, yyline, yycolumn); }
"mensagems_versao"            { return new Symbol(sym.R_SHOW_BUILD_INFO, yyline, yycolumn); }

// Radar
"radar_escala"                { return new Symbol(sym.CL_HUD_RADAR_SCALE, yyline, yycolumn); }
"radar_escala_interno"        { return new Symbol(sym.CL_RADAR_SCALE, yyline, yycolumn); }
"radar_centralizado"          { return new Symbol(sym.CL_RADAR_ALWAYS_CENTERED, yyline, yycolumn); }
"rotar_radar"                 { return new Symbol(sym.CL_RADAR_ROTATE, yyline, yycolumn); }

// Viewmodel
"modelo_classico"             { return new Symbol(sym.VIEWMODEL_PRESETPOS, yyline, yycolumn); }
"visao"                       { return new Symbol(sym.VIEWMODEL_FOV, yyline, yycolumn); }
"visaox"                      { return new Symbol(sym.VIEWMODEL_OFFSET_X, yyline, yycolumn); }
"visaoy"                      { return new Symbol(sym.VIEWMODEL_OFFSET_Y, yyline, yycolumn); }
"visaoz"                      { return new Symbol(sym.VIEWMODEL_OFFSET_Z, yyline, yycolumn); }

// Mira
"contorno_mira"               { return new Symbol(sym.CL_CROSSHAIR_DRAWOUTLINE, yyline, yycolumn); }
"expessura_borda_mira"        { return new Symbol(sym.CL_CROSSHAIR_OUTLINETHICKNESS, yyline, yycolumn); }
"estilo_mira"                 { return new Symbol(sym.CL_CROSSHAIRSTYLE, yyline, yycolumn); }
"tamanho_mira"                { return new Symbol(sym.CL_CROSSHAIRSIZE, yyline, yycolumn); }
"espessura_mira"              { return new Symbol(sym.CL_CROSSHAIRTHICKNESS, yyline, yycolumn); }
"espacamento_mira"            { return new Symbol(sym.CL_CROSSHAIRGAP, yyline, yycolumn); }
"ponto_mira"                  { return new Symbol(sym.CL_CROSSHAIRDOT, yyline, yycolumn); }
"transparencia_mira"          { return new Symbol(sym.CL_CROSSHAIRALPHA, yyline, yycolumn); }
"cor_mira"                    { return new Symbol(sym.CL_CROSSHAIRCOLOR, yyline, yycolumn); }
"cor_mirab"                   { return new Symbol(sym.CL_CROSSHAIRCOLOR_B, yyline, yycolumn); }
"cor_mirag"                   { return new Symbol(sym.CL_CROSSHAIRCOLOR_G, yyline, yycolumn); }
"cor_mirar"                   { return new Symbol(sym.CL_CROSSHAIRCOLOR_R, yyline, yycolumn); }
"mira_espacamento_arma"       { return new Symbol(sym.CL_CROSSHAIRGAP_USEWEAPONVALUE, yyline, yycolumn); }
"tamanho_mira_sniper"         { return new Symbol(sym.CL_CROSSHAIR_SNIPER_WIDTH, yyline, yycolumn); }
"recuo_mira"                  { return new Symbol(sym.CL_CROSSHAIR_RECOIL, yyline, yycolumn); }

// Áudio
"buffer_audio"                { return new Symbol(sym.SND_MIXAHEAD, yyline, yycolumn); }
"equalizacao"                 { return new Symbol(sym.SND_HEADPHONE_EQ, yyline, yycolumn); }
"perspectiva_audio"           { return new Symbol(sym.SND_SPATIALIZE_LERP, yyline, yycolumn); }
"correcao_perspectiva_audio"  { return new Symbol(sym.SND_STEAMAUDIO_ENABLE_PERSPECTIVE_CORRECTION, yyline, yycolumn); }
"mutar_mvp"                   { return new Symbol(sym.SND_MUTE_MVP_MUSIC_LIVE_PLAYERS, yyline, yycolumn); }
"volume_menu"                 { return new Symbol(sym.SND_MENUMUSIC_VOLUME, yyline, yycolumn); }
"volume_inicio_rodada"        { return new Symbol(sym.SND_ROUNDSTART_VOLUME, yyline, yycolumn); }
"volume_fim_rodada"           { return new Symbol(sym.SND_ROUNDEND_VOLUME, yyline, yycolumn); }
"volume_acao_rodada"          { return new Symbol(sym.SND_ROUNDACTION_VOLUME, yyline, yycolumn); }
"volume_mvp"                  { return new Symbol(sym.SND_MVP_VOLUME, yyline, yycolumn); }
"volume_camera_morte"         { return new Symbol(sym.SND_DEATHCAMERA_VOLUME, yyline, yycolumn); }
"volume_voip"                 { return new Symbol(sym.SND_VOIPVOLUME, yyline, yycolumn); }
"volume_alerta_10s"           { return new Symbol(sym.SND_TENSECONDWARNING_VOLUME, yyline, yycolumn); }
"volume_geral"                { return new Symbol(sym.VOLUME, yyline, yycolumn); }

// Sensibilidade
"sensibilidade"               { return new Symbol(sym.SENSITIVITY, yyline, yycolumn); }
"sensibilidade_zoom"          { return new Symbol(sym.ZOOM_SENSITIVITY_RATIO, yyline, yycolumn); }

// Sniper
"delay_tirar_mira_sniper"     { return new Symbol(sym.CL_SNIPER_DELAY_UNSCOPE, yyline, yycolumn); }
"auto_rezoom_sniper"          { return new Symbol(sym.CL_SNIPER_AUTO_REZOOM, yyline, yycolumn); }

// Sistema e Rede
"console"                     { return new Symbol(sym.CON_ENABLE, yyline, yycolumn); }
"ping_max"                    { return new Symbol(sym.MM_DEDICATED_SEARCH_MAXPING, yyline, yycolumn); }
"notificacao_steam"           { return new Symbol(sym.UI_STEAM_OVERLAY_NOTIFICATION_POSITION, yyline, yycolumn); }
"latencia_baixa"              { return new Symbol(sym.ENGINE_LOW_LATENCY_SLEEP_AFTER_CLIENT_TICK, yyline, yycolumn); }
"visibilidade_jogador"        { return new Symbol(sym.R_PLAYER_VISIBILITY_MODE, yyline, yycolumn); }
"comprar_use"                 { return new Symbol(sym.CL_USE_OPENS_BUY_MENU, yyline, yycolumn); }
"modo_id_time"                { return new Symbol(sym.CL_TEAMID_OVERHEAD_MODE, yyline, yycolumn); }
"mostrar_cor_id_time"         { return new Symbol(sym.CL_TEAMID_OVERHEAD_COLORS_SHOW, yyline, yycolumn); }
"mostrar_cor_time"            { return new Symbol(sym.CL_TEAMMATE_COLORS_SHOW, yyline, yycolumn); }
"comprar_arma_aleatoria_dm"   { return new Symbol(sym.CL_DM_BUYRANDOMWEAPONS, yyline, yycolumn); }
"anunciar_partida"            { return new Symbol(sym.CL_JOIN_ADVERTISE, yyline, yycolumn); }
"habilitar_mouse_tab"         { return new Symbol(sym.CL_SCOREBOARD_MOUSE_ENABLE_BINDING, yyline, yycolumn); }
"modo_silenciador"            { return new Symbol(sym.CL_SILENCER_MODE, yyline, yycolumn); }
"mostrar_xray"                { return new Symbol(sym.SPEC_SHOW_XRAY, yyline, yycolumn); }
"economia_bateria"            { return new Symbol(sym.BATTERY_SAVER, yyline, yycolumn); }
"controle"                    { return new Symbol(sym.JOYSTICK, yyline, yycolumn); }

// Comandos
"tecla"                       { return new Symbol(sym.BIND, yyline, yycolumn); }
"var"                         { return new Symbol(sym.ALIAS, yyline, yycolumn); }
"salvar"                      { return new Symbol(sym.HOST_WRITECONFIG, yyline, yycolumn); }
"limpar"                      { return new Symbol(sym.CLEAR, yyline, yycolumn); }
"msg"                         { return new Symbol(sym.ECHO, yyline, yycolumn); }
"perfil"                      { return new Symbol(sym.PROFILE, yyline, yycolumn); }

// Ações
"+pular"                      { return new Symbol(sym.PLUS_JUMP, yyline, yycolumn); }
"-pular"                      { return new Symbol(sym.MINUS_JUMP, yyline, yycolumn); }
"+agachar"                    { return new Symbol(sym.PLUS_DUCK, yyline, yycolumn); }
"-agachar"                    { return new Symbol(sym.MINUS_DUCK, yyline, yycolumn); }
"+atacar"                     { return new Symbol(sym.PLUS_ATTACK, yyline, yycolumn); }
"-atacar"                     { return new Symbol(sym.MINUS_ATTACK, yyline, yycolumn); }
"+recarregar"                 { return new Symbol(sym.PLUS_RELOAD, yyline, yycolumn); }
"-recarregar"                 { return new Symbol(sym.MINUS_RELOAD, yyline, yycolumn); }
"+usar"                       { return new Symbol(sym.PLUS_USE, yyline, yycolumn); }
"-usar"                       { return new Symbol(sym.MINUS_USE, yyline, yycolumn); }
"+placar"                     { return new Symbol(sym.PLUS_SCORE, yyline, yycolumn); }
"-placar"                     { return new Symbol(sym.MINUS_SCORE, yyline, yycolumn); }

// Teclas especiais (ordem importa - antes do ID genérico)
{SKEY}                        { return new Symbol(sym.SKEY, yyline, yycolumn, yytext()); }

// Tokens gerais (ordem importa - mais específicos primeiro)
{NUMBER}                      { return new Symbol(sym.NUMBER, yyline, yycolumn, yytext()); }
{ID}                          { return new Symbol(sym.ID, yyline, yycolumn, yytext()); }

// Mensagem (para comando echo - deve vir antes do catch-all)
{MSG}                         { return new Symbol(sym.MSG, yyline, yycolumn, yytext()); }

// Catch-all para caracteres não reconhecidos (sempre por último)
.                             { System.err.println("Caractere inválido: " + yytext()); return new Symbol(sym.ERROR, yyline, yycolumn, yytext()); }