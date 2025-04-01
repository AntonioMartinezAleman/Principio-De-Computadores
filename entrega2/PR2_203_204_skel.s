# /*
# Introducir dos números enteros por consola. Mostrar los números del rango que va 
# desde el menor al mayor con paso 1, normalizados como flotantes entre cero y uno. 
# Por ejemplo, si se introduce 0 y 5 deberá producir 0, 0.2, 0.4, 0.6, 0.8, 1.
# */

# #include<iostream>
# int main(void) {
#     int min,max,distancia;
#     float normalizado;  

#     std::cout << "Normalizar un rango de enteros a flotantes entre 0 y 1. \nIntroduzca los límites del rango [min,max].\n";
#     do {
#         std::cout << "Introduzca límite inferior del rango (min): ";
#         std::cin >> min;
#         std::cout << "Introduzca límite superior del rango (max): ";
#         std::cin >> max;
#         if (max <= min)
#             std::cout << "Error. min tiene que ser menor estrictamente que max.\n";
#     } while (max <= min);
#     int i;
#     for (i = min ; i <= max ; i++) {
#         normalizado = float((i - min)) / float((max - min));
#         std::cout << "Normalizado(" << i << ") = " << normalizado << std::endl;
#     }
#     std::cout << "\nFIN DEL PROGRAMA.\n";

    .data 
titulo: .asciiz "Normalizar un rango de enteros a flotantes entre 0 y 1. \nIntroduzca los límites del rango [min,max].\n"
cadmin: .asciiz "\nIntroduzca límite inferior del rango (min): "
cadmax: .asciiz "\nIntroduzca límite superior del rango (max): "
caderr: .asciiz "\nError. min tiene que ser menor estrictamente que max.\n"
cadfin: .asciiz "\nFIN DEL PROGRAMA.\n"
cadnor: .asciiz "\nNormalizado("
cadigu: .asciiz ") = "
cadlin: .asciiz "\n"

# Asignacion de variables
# min         -> $s0
# max         -> $s1
# distancia   -> $s2
# i           -> $s3
# normalizado -> $f20


     .text
     
# #include<iostream>
# int main(void) {
main:
#     int min,max,distancia;
#     float normalizado;  

#     std::cout << "Normalizar un rango de enteros a flotantes entre 0 y 1. \nIntroduzca los límites del rango [min,max].\n";
li $v0,4
la $a0,titulo
syscall
#     do {
start:
#         std::cout << "Introduzca límite inferior del rango (min): ";
li $v0,4
la $a0,cadmin
syscall
#         std::cin >> min;
li $v0,5
syscall
move $s0,$v0
#         std::cout << "Introduzca límite superior del rango (max): ";
li $v0,4
la $a0,cadmax
syscall
#         std::cin >> max;
li $v0,5
syscall
move $s1,$v0
#         if (max <= min)
if_start:
bgtu $s1,$s0,if_fin
#             std::cout << "Error. min tiene que ser menor estrictamente que max.\n";
li $v0,4
la $a0,caderr
syscall
b start
if_fin:
#     } while (max <= min);
while_start:
bgtu $s0,$s1,fin
#     int i;
#     for (i = min ; i <= max ; i++) {
for_start:
move $s3,$s0
bgt $s3,$s1,forfin
#         normalizado = float((i - min)) / float((max - min));
sub $t0,$s3,$s0        # i - min 
# pasamos de int a float
mtc1 $t0,$f22
cvt.s.w $f24,$f22
mov.s $f21,$f2
sub $t1,$1,$s0         # max - min
# pasamos de int a float
mtc1 $t1,$f26
cvt.s.w $t0,$f0
mov.s $f28,$f26
div.s $f20,$f24,$f28
#         std::cout << "Normalizado(" << i << ") = " << normalizado << std::endl;
li $v0,4
la $a0,cadnor
syscall
li $v0,5
la $a0,$s3
syscall
li $v0,4
la $a0,cadigu
syscall
li $a0,2
mov.s $f12,$f20
syscall
li $v0,4
la $a0,cadlin
syscall
#     }
addi $s3,1
for_fin:
fin:
#     std::cout << "\nFIN DEL PROGRAMA.\n";
li $v0,4
la $a0,cadfin
syscall
li $v0,10
syscall
