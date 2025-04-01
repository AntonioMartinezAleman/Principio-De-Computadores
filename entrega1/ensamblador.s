# PR1. PRINCIPIO DE COMPUTADORES.
# Autor:
# Fecha ultima modificacion:

	.data

titulo:		.asciiz "\nPR1: Principio de computadores.\n"
pet:		.asciiz "\nIntroduzca maximo error permitido: "
caderr:		.asciiz "\nError: el dato introducido debe cumplir 0.00001 <= dato < 1\n"
cade:		.asciiz "\nNumero e: "
cadnt:		.asciiz "\nNumero de terminos: "
cadfin:		.asciiz "\nPR1: Fin del programa.\n"

# #include <iostream>
# #include <iomanip>
# int main(int argc, char *argv[]) {
# double error = 0;
# double e = 1; // 1/0!
# double fact = 1; // 0!
# double numterminos = 1;
# double ultimo_termino = 1; ; // 1/0!

# std::cout << "\nPR1: Principio de computadores.\n";
# do {
#     std::cout << "\nIntroduzca maximo error permitido: ";
#     std::cin >> error;
#     if (!(error >= 0.00001 && error < 1))
#         std::cout << "\nError: el dato introducido debe cumplir 0.00001 <= dato < 1\n";
#     else break;
# } while (true);

# while (ultimo_termino >= error) {
#     fact *= numterminos;
#     ultimo_termino = 1/fact;
#     e += ultimo_termino;
#     numterminos++;
# }
# std::cout <<  "\nNumero e: ";
# std::cout << std::fixed << std::setprecision(17) << e;
# std::cout << "\nNumero de terminos: " << int(numterminos);
# std::cout << "\nPR1: Fin del programa.\n";
# return 0;
# }
  
# Asignacion de registros para variables:
# error          -> $f20
# e              -> $f22
# fact           -> $f24
# numterminos    -> $f26
# ultimo_termino -> $f28
# 0.00001        -> $f30

	.text

# #include <iostream>
# #include <iomanip>
# int main(int argc, char *argv[]) {
main:
# double error = 0;
  li.d $f20,0.0
# double e = 1; // 1/0!
  li.d $f22,1.0
# double fact = 1; // 0!
  li.d $f24,1.0
# double numterminos = 1;
  li.d $f26,1.0
# double ultimo_termino = 1; ; // 1/0!
  li.d $f26,1.0

# std::cout << "\nPR1: Principio de computadores.\n";
	li	$v0,4
	la  $a0,titulo
	syscall
# do {
start:
#     std::cout << "\nIntroduzca maximo error permitido: ";
	li	$v0,4
	la  $a0,pet
	syscall
#     std::cin >> error;
  li $v0,7
	syscall
	mov.d $f20,$f0
#     if (!(error >= 0.00001 && error < 1))
  li.d $f30,0.00001
if_primero:
  c.le.d $f30,$f20
	bc1f if_segundo
if_segundo:
  c.lt.d $f20, $f24
	bc1f if_then
	b fin
#         std::cout << "\nError: el dato introducido debe cumplir 0.00001 <= dato < 1\n";
if_then:
  li $v0,4
	la $a0,caderr
	syscall
#     else break;
else:
  li $v0,10
	syscall
fin:
# } while (true);

# while (ultimo_termino >= error) {
while_start:
  c.le.d $f20, $f28
	bc1f while_fin
while_then:
  li.d $f4,1.0
#     fact *= numterminos;
  mul.d $f24, $f24, $f26
#     ultimo_termino = 1/fact;
  div.d $f28, $f4, $f24
#     e += ultimo_termino;
  add.d $f22, $f22, $f28
#     numterminos++;
  add.d $f26, $f26, $f4

	b while_start
# }
while_fin:
# std::cout <<  "\nNumero e: ";
  li $v0,4
	la $a0,cade
	syscall
# std::cout << std::fixed << std::setprecision(17) << e;
  li $v0, 3
  mov.d $f12, $f22
  syscall
# std::cout << "\nNumero de terminos: " << int(numterminos);
  li $v0,4
	la $a0,cadnt
	syscall
	
# std::cout << "\nPR1: Fin del programa.\n";
  li $v0,4
	la $a0,cadfin
	syscall
# return 0;
  li $v0,10
	syscall
# }
