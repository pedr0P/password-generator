#!/bin/bash
show_help() {
	echo "Bem vindo ao password-generator! Versão 1.0, (c) 2024, Pedro V. B. Pereira, DIMAp, UFRN"
	echo Uso: ./password-generator.sh [OPÇÕES]
	echo Opções:
	echo  -l [COMPRIMENTO] : comprimento da senha
	echo  -u               : incluir letras maiúsculas
	echo  -d               : incluir números
	echo  -s               : incluir símbolos
	echo  -h               : exibir essa mensagem de ajuda

	echo  O comportamento padrão do script é gerar uma senha de 8 caracteres minúsculos.
}

LENGTH=8
USE_UPPERCASE=false
USE_DIGITS=false
USE_SYMBOLS=false
LOWERCASE="a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z"
UPPERCASE="A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z"
DIGITS="0|1|2|3|4|5|6|7|8|9"
SYMBOLS="!|@|#|'$'|%|'^'|&|'*'|(|)|-|_|=|'+'|'['|']'|'{'|'}'|\||;|:|,|'.'|<|>|'?'|/|~"
QUAIS="$LOWERCASE"
SAVED=false
SAVE=false
while getopts "hudsl:n:o" opt ; do
	case "$opt" in
		h) show_help ; exit ;;
		u) USE_UPPERCASE=true ;;
		d) USE_DIGITS=true ;;
		s) USE_SYMBOLS=true ;;
		l) LENGTH="$OPTARG" ;;
		n) SAVED=true ; SAVENOME="$OPTARG" ;;
		o) SAVE=true ;;	

		
		
	esac
done

if $USE_UPPERCASE ;
then
	QUAIS+=$UPPERCASE
fi

if $USE_DIGITS ;
then
	QUAIS+="|"$DIGITS
fi

if $USE_SYMBOLS ;
then
	QUAIS+="|"$SYMBOLS
fi

PASSWORD=$(cat /dev/urandom | grep -aEo "$QUAIS" | head -c $((LENGTH*2)) | sed ':a;N;$!ba;s/\n//g') 

echo "Senha gerada: $PASSWORD"

if $SAVED ;
then
	echo "$SAVENOME: $PASSWORD" >> passwords.txt
elif $SAVE ;
then 
	echo $PASSWORD >> passwords.txt ; echo "Senhas salva em passwords.txt"
fi



	






# Opcional: salvar a senha em um arquivo criptografado
# Implemente como essa senha será criptografada com o openssl
# echo $PASSWORD >> password.txt.enc

