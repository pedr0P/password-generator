#!/bin/bash

# Funções
show_help(){
	echo " Bem vindo ao password generator! Versão 1.0, (c) 2024, Pedr0P, DIMAp, UFRN"
	echo " Uso ./password-gen.sh [OPTIONS]"
	echo " Opções:"
	echo "   -l LENGTH  Especifica o tamanho da senha (padrão: 8)"
	echo "   -u         Inclui letras maiúsculas na senha"
	echo "   -d         Inclui dígitos na senha"
	echo "   -s         Inclui símbolos na senha"
	echo "   -h         Exibe essa ajuda"
	echo "   -o         Salva a senha gerada em um arquivo"
	echo "   -n NAME    Adiciona um nome a senha gerada"
	echo "   -p         Exibe senhas geradas"
	echo " O comporatemento padrão é gerar uma senha de 8 caracteres minúsculos"
}

# Declarações
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
LISTAR=false


# IFs and Cases
while getopts "hudsl:n:op" opt ; do
	case "$opt" in
		h) show_help ; exit ;;
		u) USE_UPPERCASE=true ;;
		d) USE_DIGITS=true ;;
		s) USE_SYMBOLS=true ;;
		l) LENGTH="$OPTARG" ;;
		n) SAVED=true ; SAVENOME="$OPTARG" ;;
		o) SAVE=true ;;	
		p) LISTAR=true ; cat passwords.txt ; exit ;;
		
		
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
	echo "$SAVENOME: $PASSWORD" >> passwords.txt ; echo "Senha do(a) $SAVENOME salva em passwords.txt"
elif $SAVE ;
then 
	echo $PASSWORD >> passwords.txt ; echo "Senha salva em passwords.txt"
fi


# Opcional: salvar a senha em um arquivo criptografado
# Implemente como essa senha será criptografada com o openssl
# echo $PASSWORD >> password.txt.enc

