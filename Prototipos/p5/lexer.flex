import java_cup.runtime.*;
%%
%class Lexer
%unicode
%public
%cup
%line
%column

// ====== Configurações Visuais e Interface ======
R_FULLSCREEN_GAMMA = "gama"
HUD_SCALING = "escala_hud"
HUD_SHOWTARGETID = "id_inimigo"
CL_COLOR = "cor"
CL_HUD_COLOR = "cor_hud"
CL_ALLOW_ANIMATED_AVATARS = "animacao_avatar"
CL_SHOWLOADOUT = "equipamentos"
CL_RADAR_SQUARE_WITH_SCOREBOARD = "tab_radar_quadrado"
R_SHOW_BUILD_INFO = "mensagems_versao"
// ====== Radar ======
CL_HUD_RADAR_SCALE = "radar_escala"
CL_RADAR_SCALE = "radar_escala_interno"
CL_RADAR_ALWAYS_CENTERED = "radar_centralizado"
CL_RADAR_ROTATE = "rotar_radar"
// ====== Viewmodel (Modelo de Arma) ======
VIEWMODEL_PRESETPOS = "modelo_classico"
VIEWMODEL_FOV = "visao"
VIEWMODEL_OFFSET_X = "visaox"
VIEWMODEL_OFFSET_Y = "visaoy"
VIEWMODEL_OFFSET_Z = "visaoz"
// ====== Mira ======
CL_CROSSHAIR_DRAWOULINE = "contorno_mira"
CL_CROSSHAIR_OUTLINETHICKNESS = "expessura_borda_mira"
CL_CROSSHAIRSTYLE = "estilo_mira"
CL_CROSSHAIRSIZE = "tamanho_mira"
CL_CROSSHAIRTHICKNESS = "espessura_mira"
CL_CROSSHAIRGAP = "espacamento_mira"
CL_CROSSHAIRDOT = "ponto_mira"
CL_CROSSHAIRALPHA = "transparencia_mira"
CL_CROSSHAIRCOLOR = "cor_mira"
CL_CROSSHAIRCOLOR_B = "cor_mirab"
CL_CROSSHAIRCOLOR_G = "cor_mirag"
CL_CROSSHAIRCOLOR_R = "cor_mirar"
CL_CROSSHAIRGAP_USEWEAPONVALUE = "mira_espacamento_arma"
CL_CROSSHAIR_SNIPER_WIDTH = "tamanho_mira_sniper"
CL_CROSSHAIR_RECOIL = "recuo_mira"
// ====== Áudio ======
SND_MIXAHEAD = "buffer_audio"
SND_HEADPHONE_EQ = "equalizacao"
SND_SPATIALIZE_LERP = "perspectiva_audio"
SND_STEAMAUDIO_ENABLE_PERSPECTIVE_CORRECTION = "correcao_perspectiva_audio"
SND_MUTE_MVP_MUSIC_LIVE_PLAYERS = "mutar_mvp"
SND_MENUMUSIC_VOLUME = "volume_menu"
SND_ROUNDSTART_VOLUME = "volume_inicio_rodada"
SND_ROUNDEND_VOLUME = "volume_fim_rodada"
SND_ROUNDACTION_VOLUME = "volume_acao_rodada"
SND_MVP_VOLUME = "volume_mvp"
SND_DEATHCAMERA_VOLUME = "volume_camera_morte"
SND_VOIPVOLUME = "volume_voip"
SND_TENSECONDWARNING_VOLUME = "volume_alerta_10s"
VOLUME = "volume_geral"
// ====== Sensibilidade ======
SENSITIVITY = "sensibilidade"
ZOOM_SENSITIVITY_RATIO = "sensibilidade_zoom"
// ====== Sniper ======
CL_SNIPER_DELAY_UNSCOPE = "delay_tirar_mira_sniper"
CL_SNIPER_AUTO_REZOOM = "auto_rezoom_sniper"
// ====== Sistema e Rede ======
CON_ENABLE = "console"
MM_DEDICATED_SEARCH_MAXPING = "ping_max"
UI_STEAM_OVERLAY_NOTIFICATION_POSITION = "notificacao_steam"
ENGINE_LOW_LATENCY_SLEEP_AFTER_CLIENT_TICK = "latencia_baixa"
R_PLAYER_VISIBILITY_MODE = "visibilidade_jogador"
CL_USE_OPENS_BUY_MENU = "comprar_use"
CL_TEAMID_OVERHEAD_MODE = "modo_id_time"
CL_TEAMID_OVERHEAD_COLORS_SHOW = "mostrar_cor_id_time"
CL_TEAMMATE_COLORS_SHOW = "mostrar_cor_time"
CL_DM_BUYRANDOMWEAPONS = "comprar_arma_aleatoria_dm"
CL_JOIN_ADVERTISE = "anunciar_partida"
CL_SCOREBOARD_MOUSE_ENABLE_BINDING = "habilitar_mouse_tab"
CL_SILENCER_MODE = "modo_silenciador"
SPEC_SHOW_XRAY = "mostrar_xray"
BATTERY_SAVER = "economia_bateria"
JOYSTICK = "controle"
// ====== Comandos e Utilitários ======
BIND = "tecla"
ALIAS = "var"
HOST_WRITECONFIG = "salvar"
CLEAR = "limpar"
ECHO = "msg"
PROFILE = "perfil"
// ====== Outras ações comuns ======
PLUS_JUMP = "+pular"
MINUS_JUMP = "-pular"
PLUS_DUCK = "+agachar"
MINUS_DUCK = "-agachar"
PLUS_ATTACK = "+atacar"
MINUS_ATTACK = "-atacar"
PLUS_RELOAD = "+recarregar"
MINUS_RELOAD = "-recarregar"
PLUS_USE = "+usar"
MINUS_USE = "-usar"
PLUS_SCORE = "+placar"
MINUS_SCORE = "-placar"
// ====== Entradas ======
WHITESPACE = [ \t\r\n]+
COMMENT = "//" [^\n]*
NUMBER = [0-9]+(\.[0-9]+)*
ID = [a-zA-Z_]+
// ====== Outros símbolos ======
KEY = [a-zA-Z_][a-zA-Z0-9_]*
SKEY = "f1"|"f2"|"f3"|"f4"|"f5"|"f6"|"f7"|"f8"|"f9"|"f10"|"f11"|"f12"|"tab"|"enter"|"shift"|"ctrl"|"alt"|"space"|"mwheelup"|"mwheeldown"|"leftarrow"|"rightarrow"|"uparrow"|"downarrow"|"mouse1"|"mouse2"|"mouse3"|"mouse4"|"mouse5"
SEMICOLON   = ";"
LBRACE      = "{"
RBRACE      = "}"
// ====== Echo saidas ======
MSG = [^\n\r]+

%%

{R_FULLSCREEN_GAMMA}          { return new Symbol(sym.R_FULLSCREEN_GAMMA, yyline, yycolumn); }
{HUD_SCALING}                 { return new Symbol(sym.HUD_SCALING, yyline, yycolumn); }
{HUD_SHOWTARGETID}            { return new Symbol(sym.HUD_SHOWTARGETID, yyline, yycolumn); }
{CL_COLOR}                    { return new Symbol(sym.CL_COLOR, yyline, yycolumn); }
{CL_HUD_COLOR}                { return new Symbol(sym.CL_HUD_COLOR, yyline, yycolumn); }
{CL_ALLOW_ANIMATED_AVATARS}   { return new Symbol(sym.CL_ALLOW_ANIMATED_AVATARS, yyline, yycolumn); }
{CL_SHOWLOADOUT}              { return new Symbol(sym.CL_SHOWLOADOUT, yyline, yycolumn); }
{CL_RADAR_SQUARE_WITH_SCOREBOARD} { return new Symbol(sym.CL_RADAR_SQUARE_WITH_SCOREBOARD, yyline, yycolumn); }
{R_SHOW_BUILD_INFO}           { return new Symbol(sym.R_SHOW_BUILD_INFO, yyline, yycolumn); }
//---
{CL_HUD_RADAR_SCALE}          { return new Symbol(sym.CL_HUD_RADAR_SCALE, yyline, yycolumn); }
{CL_RADAR_SCALE}              { return new Symbol(sym.CL_RADAR_SCALE, yyline, yycolumn); }
{CL_RADAR_ALWAYS_CENTERED}    { return new Symbol(sym.CL_RADAR_ALWAYS_CENTERED, yyline, yycolumn); }
{CL_RADAR_ROTATE}             { return new Symbol(sym.CL_RADAR_ROTATE, yyline, yycolumn); }
//---
{VIEWMODEL_PRESETPOS}         { return new Symbol(sym.VIEWMODEL_PRESETPOS, yyline, yycolumn); }
{VIEWMODEL_FOV}               { return new Symbol(sym.VIEWMODEL_FOV, yyline, yycolumn); } 
{VIEWMODEL_OFFSET_X}          { return new Symbol(sym.VIEWMODEL_OFFSET_X, yyline, yycolumn); }
{VIEWMODEL_OFFSET_Y}          { return new Symbol(sym.VIEWMODEL_OFFSET_Y, yyline, yycolumn); }
{VIEWMODEL_OFFSET_Z}          { return new Symbol(sym.VIEWMODEL_OFFSET_Z, yyline, yycolumn); }
//---
{CL_CROSSHAIR_DRAWOULINE}     { return new Symbol(sym.CL_CROSSHAIR_DRAWOULINE, yyline, yycolumn); }
{CL_CROSSHAIR_OUTLINETHICKNESS} { return new Symbol(sym.CL_CROSSHAIR_OUTLINETHICKNESS, yyline, yycolumn); }
{CL_CROSSHAIRSTYLE}           { return new Symbol(sym.CL_CROSSHAIRSTYLE, yyline, yycolumn); }
{CL_CROSSHAIRSIZE}            { return new Symbol(sym.CL_CROSSHAIRSIZE, yyline, yycolumn); }
{CL_CROSSHAIRTHICKNESS}       { return new Symbol(sym.CL_CROSSHAIRTHICKNESS, yyline, yycolumn); }
{CL_CROSSHAIRGAP}             { return new Symbol(sym.CL_CROSSHAIRGAP, yyline, yycolumn); }
{CL_CROSSHAIRDOT}             { return new Symbol(sym.CL_CROSSHAIRDOT, yyline, yycolumn); }
{CL_CROSSHAIRALPHA}           { return new Symbol(sym.CL_CROSSHAIRALPHA, yyline, yycolumn); }
{CL_CROSSHAIRCOLOR}           { return new Symbol(sym.CL_CROSSHAIRCOLOR, yyline, yycolumn); }
{CL_CROSSHAIRCOLOR_B}         { return new Symbol(sym.CL_CROSSHAIRCOLOR_B, yyline, yycolumn); }
{CL_CROSSHAIRCOLOR_G}         { return new Symbol(sym.CL_CROSSHAIRCOLOR_G, yyline, yycolumn); }
{CL_CROSSHAIRCOLOR_R}         { return new Symbol(sym.CL_CROSSHAIRCOLOR_R, yyline, yycolumn); }
{CL_CROSSHAIRGAP_USEWEAPONVALUE} { return new Symbol(sym.CL_CROSSHAIRGAP_USEWEAPONVALUE, yyline, yycolumn); }
{CL_CROSSHAIR_SNIPER_WIDTH}   { return new Symbol(sym.CL_CROSSHAIR_SNIPER_WIDTH, yyline, yycolumn); }
{CL_CROSSHAIR_RECOIL}         { return new Symbol(sym.CL_CROSSHAIR_RECOIL, yyline, yycolumn); }
//---
{SND_MIXAHEAD}                { return new Symbol(sym.SND_MIXAHEAD, yyline, yycolumn); }
{SND_HEADPHONE_EQ}            { return new Symbol(sym.SND_HEADPHONE_EQ, yyline, yycolumn); }
{SND_SPATIALIZE_LERP}         { return new Symbol(sym.SND_SPATIALIZE_LERP, yyline, yycolumn); }
{SND_STEAMAUDIO_ENABLE_PERSPECTIVE_CORRECTION} { return new Symbol(sym.SND_STEAMAUDIO_ENABLE_PERSPECTIVE_CORRECTION, yyline, yycolumn); }
{SND_MUTE_MVP_MUSIC_LIVE_PLAYERS} { return new Symbol(sym.SND_MUTE_MVP_MUSIC_LIVE_PLAYERS, yyline, yycolumn); }
{SND_MENUMUSIC_VOLUME}        { return new Symbol(sym.SND_MENUMUSIC_VOLUME, yyline, yycolumn); }
{SND_ROUNDSTART_VOLUME}       { return new Symbol(sym.SND_ROUNDSTART_VOLUME, yyline, yycolumn); }
{SND_ROUNDEND_VOLUME}         { return new Symbol(sym.SND_ROUNDEND_VOLUME, yyline, yycolumn); }
{SND_ROUNDACTION_VOLUME}      { return new Symbol(sym.SND_ROUNDACTION_VOLUME, yyline, yycolumn); }
{SND_MVP_VOLUME}              { return new Symbol(sym.SND_MVP_VOLUME, yyline, yycolumn); }
{SND_DEATHCAMERA_VOLUME}      { return new Symbol(sym.SND_DEATHCAMERA_VOLUME, yyline, yycolumn); }
{SND_VOIPVOLUME}              { return new Symbol(sym.SND_VOIPVOLUME, yyline, yycolumn); }
{SND_TENSECONDWARNING_VOLUME} { return new Symbol(sym.SND_TENSECONDWARNING_VOLUME, yyline, yycolumn); }
{VOLUME}                      { return new Symbol(sym.VOLUME, yyline, yycolumn); }
//---
{SENSITIVITY}                 { return new Symbol(sym.SENSITIVITY, yyline, yycolumn); }
{ZOOM_SENSITIVITY_RATIO}      { return new Symbol(sym.ZOOM_SENSITIVITY_RATIO, yyline, yycolumn); }
//---
{CL_SNIPER_DELAY_UNSCOPE}     { return new Symbol(sym.CL_SNIPER_DELAY_UNSCOPE, yyline, yycolumn); }
{CL_SNIPER_AUTO_REZOOM}       { return new Symbol(sym.CL_SNIPER_AUTO_REZOOM, yyline, yycolumn); }
//---
{CON_ENABLE}                  { return new Symbol(sym.CON_ENABLE, yyline, yycolumn); }
{MM_DEDICATED_SEARCH_MAXPING} { return new Symbol(sym.MM_DEDICATED_SEARCH_MAXPING, yyline, yycolumn); }
{UI_STEAM_OVERLAY_NOTIFICATION_POSITION} { return new Symbol(sym.UI_STEAM_OVERLAY_NOTIFICATION_POSITION, yyline, yycolumn); }
{ENGINE_LOW_LATENCY_SLEEP_AFTER_CLIENT_TICK} { return new Symbol(sym.ENGINE_LOW_LATENCY_SLEEP_AFTER_CLIENT_TICK, yyline, yycolumn); }
{R_PLAYER_VISIBILITY_MODE}    { return new Symbol(sym.R_PLAYER_VISIBILITY_MODE, yyline, yycolumn); }
{CL_USE_OPENS_BUY_MENU}       { return new Symbol(sym.CL_USE_OPENS_BUY_MENU, yyline, yycolumn); }
{CL_TEAMID_OVERHEAD_MODE}     { return new Symbol(sym.CL_TEAMID_OVERHEAD_MODE, yyline, yycolumn); }
{CL_TEAMID_OVERHEAD_COLORS_SHOW} { return new Symbol(sym.CL_TEAMID_OVERHEAD_COLORS_SHOW, yyline, yycolumn); }
{CL_TEAMMATE_COLORS_SHOW}     { return new Symbol(sym.CL_TEAMMATE_COLORS_SHOW, yyline, yycolumn); }
{CL_DM_BUYRANDOMWEAPONS}      { return new Symbol(sym.CL_DM_BUYRANDOMWEAPONS, yyline, yycolumn); }
{CL_JOIN_ADVERTISE}           { return new Symbol(sym.CL_JOIN_ADVERTISE, yyline, yycolumn); }
{CL_SCOREBOARD_MOUSE_ENABLE_BINDING} { return new Symbol(sym.CL_SCOREBOARD_MOUSE_ENABLE_BINDING, yyline, yycolumn); }
{CL_SILENCER_MODE}            { return new Symbol(sym.CL_SILENCER_MODE, yyline, yycolumn); }
{SPEC_SHOW_XRAY}              { return new Symbol(sym.SPEC_SHOW_XRAY, yyline, yycolumn); }
{BATTERY_SAVER}               { return new Symbol(sym.BATTERY_SAVER, yyline, yycolumn); }
{JOYSTICK}                    { return new Symbol(sym.JOYSTICK, yyline, yycolumn); }
//---
{BIND}                        { return new Symbol(sym.BIND, yyline, yycolumn); }
{ALIAS}                       { return new Symbol(sym.ALIAS, yyline, yycolumn); }
{HOST_WRITECONFIG}            { return new Symbol(sym.HOST_WRITECONFIG, yyline, yycolumn); }
{CLEAR}                       { return new Symbol(sym.CLEAR, yyline, yycolumn); }
{ECHO}                        { return new Symbol(sym.ECHO, yyline, yycolumn); }
//---
{PLUS_JUMP}                   { return new Symbol(sym.PLUS_JUMP, yyline, yycolumn); }
{MINUS_JUMP}                  { return new Symbol(sym.MINUS_JUMP, yyline, yycolumn); }
{PLUS_DUCK}                   { return new Symbol(sym.PLUS_DUCK, yyline, yycolumn); }
{MINUS_DUCK}                  { return new Symbol(sym.MINUS_DUCK, yyline, yycolumn); }
{PLUS_ATTACK}                 { return new Symbol(sym.PLUS_ATTACK, yyline, yycolumn); }
{MINUS_ATTACK}                { return new Symbol(sym.MINUS_ATTACK, yyline, yycolumn); }
{PLUS_RELOAD}                 { return new Symbol(sym.PLUS_RELOAD, yyline, yycolumn); }
{MINUS_RELOAD}                { return new Symbol(sym.MINUS_RELOAD, yyline, yycolumn); }
{PLUS_USE}                    { return new Symbol(sym.PLUS_USE, yyline, yycolumn); }
{MINUS_USE}                   { return new Symbol(sym.MINUS_USE, yyline, yycolumn); }
{PLUS_SCORE}                  { return new Symbol(sym.PLUS_SCORE, yyline, yycolumn); }
{MINUS_SCORE}                 { return new Symbol(sym.MINUS_SCORE, yyline, yycolumn); }
//---
{SEMICOLON}                   { return new Symbol(sym.SEMICOLON, yyline, yycolumn, yytext()); }
{LBRACE}                      { return new Symbol(sym.LBRACE, yyline, yycolumn, yytext()); }
{RBRACE}                      { return new Symbol(sym.RBRACE, yyline, yycolumn, yytext()); }
//---
{PROFILE}                     { return new Symbol(sym.PROFILE, yyline, yycolumn); }
{KEY}                         { return new Symbol(sym.KEY, yyline, yycolumn, yytext()); }
{SKEY}                        { return new Symbol(sym.SKEY, yyline, yycolumn, yytext()); }
{NUMBER}                      { return new Symbol(sym.NUMBER, yyline, yycolumn, yytext()); }
{ID}                          { return new Symbol(sym.ID, yyline, yycolumn, yytext()); }
{WHITESPACE}                  { /* ignora espaços */ }
{COMMENT}                     { /* ignora comentários */ }
{MSG}                         { return new Symbol(sym.MSG, yytext()); }
//---
.                             { System.err.println("Caractere inválido: " + yytext()); return new Symbol(sym.ERROR, yyline, yycolumn); }