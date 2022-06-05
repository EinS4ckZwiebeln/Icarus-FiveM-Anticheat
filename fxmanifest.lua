fx_version 'cerulean'

game 'gta5'

description '(ALPHA) Anticheat solution for FiveM'

version '0.0.1'

lua54 'yes'

client_script {
	'config_cl.lua',
	'core/client/*.lua',
	'modules/client/*.lua',
}

server_script {
	'config_sv.lua',
	'core/server/*.lua',
	'modules/server/*.lua',
}

dependencies {
	'/server:5181',
	'/onesync',
}