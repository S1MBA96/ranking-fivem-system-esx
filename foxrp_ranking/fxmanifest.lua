fx_version 'bodacious'

shared_scripts { 
	'@es_extended/imports.lua',
}

game 'gta5'



version '1.0.1'

ui_page 'html/main.html'

client_script {
	'client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}


files {
	'html/main.html',
	'html/css/*.css',
	'html/font/*.ttf',
	'html/font/*.otf',
	'html/main.js',
	'html/images/*.png',
	'html/images/*.jpg'
}


